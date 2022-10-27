import 'package:als_frontend/data/repository/auth_repo.dart';
import 'package:als_frontend/data/repository/newsfeed_repo.dart';
import 'package:als_frontend/data/model/response/news_feed_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewsFeedProvider with ChangeNotifier {
  final NewsfeedRepo newsFeedRepo;
  final AuthRepo authRepo;

  NewsFeedProvider({required this.newsFeedRepo, required this.authRepo});

  int position = 0;
  List<NewsFeedData> newsFeedLists = [];
  bool isLoading = false;
  bool isBottomLoading = false;
  int selectPage = 1;
  List<int> likesStatusAllData = [];
  bool hasNextData = false;

  updatePageNo() {
    selectPage++;
    initializeAllFeedData(page: selectPage);
    notifyListeners();
  }

  initializeAllFeedData({int page = 1, bool isFirstTime = true}) async {
    if (page == 1) {
      selectPage = 1;
      newsFeedLists.clear();
      newsFeedLists = [];
      isLoading = true;
      hasNextData = false;
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

    Response response = await newsFeedRepo.getNewsFeedData(page);
    isLoading = false;
    isBottomLoading = false;
    int status = 0;
    if (response.statusCode == 200) {
      hasNextData = response.body['next'] != null ? true : false;
      response.body['results'].forEach((element) {
        NewsFeedData newsFeedData = NewsFeedData.fromJson(element);

        status = 0;
        likesStatusAllData.add(0);
        for (var e in newsFeedData.likedBy!) {
          if (e.id.toString() == authRepo.getUserID()) {
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

  changeLikeStatus(int value, int index) async {
    if (value == 1) {
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

  NewsFeedData newsFeedData = NewsFeedData();

  addPostOnTimeLine(NewsFeedData n) async {
    likesStatusAllData.insert(0, 0);
    newsFeedLists.insert(0, n);
    notifyListeners();
  }

  updatePostOnTimeLine(int index, NewsFeedData n) async {
    likesStatusAllData.removeAt(index);
    newsFeedLists.removeAt(index);
    likesStatusAllData.insert(0, 0);
    newsFeedLists.insert(0, n);
    notifyListeners();
  }

  /////// TODO: for single post

  NewsFeedData singleNewsFeedModel = NewsFeedData();
  bool isLikeMe = false;

  callForSinglePosts(String url) async {
    isLoading = true;
    singleNewsFeedModel = NewsFeedData();
    //notifyListeners();
    Response response = await newsFeedRepo.callForSinglePostFromNotification(url.replaceAll('comment/', ''));
    isLoading = false;
    isLikeMe = false;
    if (response.statusCode == 200) {
      singleNewsFeedModel = NewsFeedData.fromJson(response.body);

      for (var e in singleNewsFeedModel.likedBy!) {
        if (e.id.toString() == authRepo.getUserID()) {
          isLikeMe = true;
          break;
        }
      }
    } else {
      Fluttertoast.showToast(msg: response.statusText!);
    }
    notifyListeners();
  }

  Future<int> singlePostLike(int postID, {bool isGroup = false, bool isFromLike = false, int groupID = 0}) async {
    Response response = await newsFeedRepo.addLike(postID, isGroup: isGroup, isFromLike: isFromLike, groupID: groupID);
    if (response.statusCode == 200) {
      if (response.body['liked'] == true) {
        isLikeMe = true;
        singleNewsFeedModel.totalLike = singleNewsFeedModel.totalLike! + 1;
        notifyListeners();
        return 1;
      } else {
        isLikeMe = false;
        singleNewsFeedModel.totalLike = singleNewsFeedModel.totalLike! - 1;
        notifyListeners();
        return 0;
      }
    } else {
      Fluttertoast.showToast(msg: response.statusText!);
    }

    notifyListeners();
    return -1;
  }

  void updateSingleCommentDataCount() {
    singleNewsFeedModel.totalComment = singleNewsFeedModel.totalComment! + 1;
    notifyListeners();
  }
}
