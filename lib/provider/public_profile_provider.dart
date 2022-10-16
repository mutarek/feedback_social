import 'package:als_frontend/data/model/response/news_feed_model.dart';
import 'package:als_frontend/data/model/response/profile-images_model.dart';
import 'package:als_frontend/data/model/response/profile_video_model.dart';
import 'package:als_frontend/data/model/response/user_profile_model.dart';
import 'package:als_frontend/data/repository/newsfeed_repo.dart';
import 'package:als_frontend/data/repository/profile_repo.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PublicProfileProvider with ChangeNotifier {
  final ProfileRepo profileRepo;
  final NewsfeedRepo newsfeedRepo;

  PublicProfileProvider({required this.profileRepo, required this.newsfeedRepo});

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  int position = 0;
  List<NewsFeedData> publicNewsFeedLists = [];
  bool isBottomLoading = false;
  int selectPage = 1;
  List<int> likesStatusAllData = [];
  bool hasNextData = false;

  updatePageNo(String userID) {
    selectPage++;
    initializeAllUserPostData((bool status) {}, userID, page: selectPage);
    notifyListeners();
  }

  initializeAllUserPostData(Function callBackFunction, String userID, {int page = 1, bool isFirstTime = true}) async {
    if (page == 1) {
      selectPage = 1;
      publicNewsFeedLists.clear();
      publicNewsFeedLists = [];
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
    Response response = await profileRepo.getUserNewsfeedDataByUsingID(userID, page);
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

        publicNewsFeedLists.add(newsFeedData);
      });
    } else {
      Fluttertoast.showToast(msg: response.statusText!);
    }
    notifyListeners();
  }

  ///TODO: for Public user profile
  UserProfileModel publicProfileData = UserProfileModel();
  bool isProfileLoading = false;

  callForPublicProfileData(String userID, {bool isShowLoading = true}) async {
    if (isShowLoading) isProfileLoading = true;
    if (isShowLoading) publicProfileData = UserProfileModel();
    Response response = await profileRepo.getPublicProfileInfo(userID);
    isProfileLoading = false;
    if (response.statusCode == 200) {
      publicProfileData = UserProfileModel.fromJson(response.body);
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
      publicNewsFeedLists[index].totalLike = publicNewsFeedLists[index].totalLike! + 1;
    } else {
      likesStatusAllData[index] = 0;
      publicNewsFeedLists[index].totalLike = publicNewsFeedLists[index].totalLike! - 1;
    }
    notifyListeners();
  }

  void updateCommentDataCount(int index) {
    publicNewsFeedLists[index].totalComment = publicNewsFeedLists[index].totalComment! + 1;
    notifyListeners();
  }

  ///// for get Public profile all image:
  List<ProfileImagesModel> publicAllImages = [];

  initializeUserAllImages(String userID) async {
    publicAllImages.clear();
    publicAllImages = [];
    _isLoading = true;

    Response response = await profileRepo.getPublicProfileImageList(userID);
    _isLoading = false;
    if (response.statusCode == 200) {
      response.body.forEach((element) {
        publicAllImages.add(ProfileImagesModel.fromJson(element));
      });
    } else {
      Fluttertoast.showToast(msg: response.statusText!);
    }
    notifyListeners();
  }

  ///// for get Public profile all Video:
  List<ProfileVideoModel> publicAllVideo = [];

  initializeUserAllVideo(String userID) async {
    publicAllVideo.clear();
    publicAllVideo = [];
    _isLoading = true;

    Response response = await profileRepo.getPublicProfileVideoList(userID);
    _isLoading = false;
    if (response.statusCode == 200) {
      response.body.forEach((element) {
        publicAllVideo.add(ProfileVideoModel.fromJson(element));
      });
    } else {
      Fluttertoast.showToast(msg: response.statusText!);
    }
    notifyListeners();
  }

  //TODO: ************************* for Send Friend Request cancel Friend Request or unfriend

  Future sendFriendRequest() async {
    Response response = await profileRepo.sendFriendRequest(publicProfileData.id.toString());
    if (response.statusCode == 201) {
      Fluttertoast.showToast(msg: response.body['message']);
      callForPublicProfileData(publicProfileData.id.toString(), isShowLoading: false);
    } else {
      Fluttertoast.showToast(msg: response.statusText!);
    }

    notifyListeners();
  }

  Future cancelFriendRequest() async {
    Response response = await profileRepo.cancelFriendRequest(publicProfileData.friendRequestSentId.toString());
    if (response.statusCode == 204) {
      Fluttertoast.showToast(msg: 'Friend Request is canceled successfully');
      callForPublicProfileData(publicProfileData.id.toString(), isShowLoading: false);
    } else {
      Fluttertoast.showToast(msg: response.statusText!);
    }
    notifyListeners();
  }

  Future unFriend() async {
    Response response = await profileRepo.unfriend(publicProfileData.id.toString());
    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: response.body['message']);
      callForPublicProfileData(publicProfileData.id.toString(), isShowLoading: false);
    } else {
      Fluttertoast.showToast(msg: response.statusText!);
    }
    notifyListeners();
  }
}
