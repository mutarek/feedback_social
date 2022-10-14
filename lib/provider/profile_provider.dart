import 'package:als_frontend/data/model/response/news_feed_model.dart';
import 'package:als_frontend/data/model/response/user_profile_model.dart';
import 'package:als_frontend/data/repository/newsfeed_repo.dart';
import 'package:als_frontend/data/repository/profile_repo.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileProvider with ChangeNotifier {
  final ProfileRepo profileRepo;
  final NewsfeedRepo newsfeedRepo;

  ProfileProvider({required this.profileRepo, required this.newsfeedRepo});

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  int position = 0;
  List<NewsFeedData> newsFeedLists = [];
  bool isBottomLoading = false;
  int selectPage = 1;
  List<int> likesStatusAllData = [];
  bool hasNextData = false;

  updatePageNo() {
    selectPage++;
    initializeAllUserPostData((bool status) {}, page: selectPage);
    notifyListeners();
  }

  initializeAllUserPostData(Function callBackFunction, {int page = 1, bool isFirstTime = true}) async {
    if (page == 1) {
      selectPage = 1;
      newsFeedLists.clear();
      newsFeedLists = [];
      _isLoading = true;
      isBottomLoading = false;
      hasNextData = false;
      position = 0;
      likesStatusAllData.clear();
      likesStatusAllData = [];
      if (!isFirstTime) {
        notifyListeners();
      }
    } else {
      isBottomLoading = true;
      notifyListeners();
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = (prefs.getString('userID') ?? '0');
    Response response = await profileRepo.getUserNewsfeedDataByUsingID(id, page);
    _isLoading = false;
    isBottomLoading = false;
    callBackFunction(true);
    int status = 0;
    if (response.statusCode == 200) {
      hasNextData = response.body['next'] != null ? true : false;
      response.body['results'].forEach((element) {
        NewsFeedData newsFeedData = NewsFeedData.fromJson(element);

        status = 0;
        likesStatusAllData.add(0);
        for (var e in newsFeedData.likedBy!) {
          if (e.id.toString() == id) {
            status = 1;
            continue;
          }
        }
        if (status == 0) {
          likesStatusAllData[position] = 0;
        } else {
          likesStatusAllData[position] = 1;
        }
        position++;

        newsFeedLists.add(newsFeedData);
      });
    } else {
      Fluttertoast.showToast(msg: response.statusText!);
    }
    notifyListeners();
  }

  ///TODO: for user profile
  UserProfileModel userprofileData = UserProfileModel();
  bool isProfileLoading = false;

  initializeUserData() async {
    isProfileLoading = true;
    userprofileData = UserProfileModel();
    Response response = await profileRepo.getUserInfo();
    isProfileLoading = false;
    if (response.statusCode == 200) {
      hasNextData = response.body['next'] != null ? true : false;
      userprofileData = UserProfileModel.fromJson(response.body);
    } else {
      Fluttertoast.showToast(msg: response.statusText!);
    }
    notifyListeners();
  }

  // for LIKE comment

  addLike(int postID, int index) async {
    Response response = await newsfeedRepo.addLike(postID);
    if (response.body['liked'] == true) {
      likesStatusAllData[index] = 1;
      newsFeedLists[index].totalLike = newsFeedLists[index].totalLike! + 1;
    } else {
      likesStatusAllData[index] = 0;
      newsFeedLists[index].totalLike = newsFeedLists[index].totalLike! - 1;
    }
    notifyListeners();
  }

  void updateCommentDataCount(int index) {
    newsFeedLists[index].totalComment = newsFeedLists[index].totalComment! + 1;
    notifyListeners();
  }
}
