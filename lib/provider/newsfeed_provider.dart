import 'package:als_frontend/data/repository/newsfeed_repo.dart';
import 'package:als_frontend/old_code/model/post/news_feed_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewsFeedProvider with ChangeNotifier {
  final NewsfeedRepo newsFeedRepo;

  NewsFeedProvider({required this.newsFeedRepo});

  int position = 0;
  List<NewsFeedData> newsFeedLists = [];
  bool isLoading = false;
  bool isBottomLoading = false;
  int selectPage = 1;
  List<int> likesStatusAllData = [];

  updatePageNo() {
    selectPage++;
    initializeAllFeedData((bool status) {}, page: selectPage);
    notifyListeners();
  }

  initializeAllFeedData(Function callBackFunction, {int page = 1, bool isFirstTime = true}) async {
    if (page == 1) {
      selectPage = 1;
      newsFeedLists.clear();
      newsFeedLists = [];
      isLoading = true;
      isBottomLoading = false;
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
    Response response = await newsFeedRepo.getNewsFeedData(page);
    isLoading = false;
    isBottomLoading = false;
    callBackFunction(true);
    int status = 0;
    if (response.statusCode == 200) {
      response.body['results'].forEach((element) {
        NewsFeedData newsFeedData = NewsFeedData.fromJson(element);
        String id = (prefs.getString('userID') ?? '0');

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

  addLike(int postID, int index) async {
    Response response = await newsFeedRepo.addLike(postID);
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

  int count = 0;
  NewsFeedData newsFeedData = NewsFeedData();

  initializeCount0() {
    count = 0;
    notifyListeners();
  }

  addPostOnTimeLine(NewsFeedData n) async {
    newsFeedData = n;
    count = 1;
    notifyListeners();
  }

  addedDataOnLists() async {
    likesStatusAllData.insert(0, 0);
    newsFeedLists.add(newsFeedData);
    count = 2;
    notifyListeners();
  }
}
