import 'package:als_frontend/data/model/response/chat/offline_chat_model.dart';
import 'package:als_frontend/data/model/response/liked_by_model.dart';
import 'package:als_frontend/data/model/response/news_feed_model.dart';
import 'package:als_frontend/data/repository/auth_repo.dart';
import 'package:als_frontend/data/repository/newsfeed_repo.dart';
import 'package:als_frontend/provider/chat_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewsFeedProvider with ChangeNotifier {
  final NewsfeedRepo newsFeedRepo;
  final AuthRepo authRepo;

  NewsFeedProvider({required this.newsFeedRepo, required this.authRepo});

  int position = 0;
  List<NewsFeedModel> newsFeedLists = [];
  bool isLoading = false;
  bool isBottomLoading = false;
  int selectPage = 1;
  bool hasNextData = false;
  late SharedPreferences? sharedPreferences;

  updatePageNo() {
    selectPage++;
    initializeAllFeedData(page: selectPage);
    notifyListeners();
  }


  initializeAllFeedData({int page = 1, bool isFirstTime = true}) async {
    sharedPreferences = await SharedPreferences.getInstance();
    pushLocalMessage();
    if (page == 1) {
      selectPage = 1;
      newsFeedLists.clear();
      newsFeedLists = [];
      isLoading = true;
      hasNextData = false;
      isBottomLoading = false;
      position = 0;
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
    if (response.statusCode == 200) {
      hasNextData = response.body['next'] != null ? true : false;
      response.body['results'].forEach((element) {
        newsFeedLists.add(NewsFeedModel.fromJson(element));
      });
    } else {
      Fluttertoast.showToast(msg: response.statusText!);
    }
    notifyListeners();
  }

  addLike(int postID, int index, {bool isGroup = false, bool isFromPage = false, int groupPageID = 0}) async {
    if (newsFeedLists[index].isLiked == false) {
      newsFeedLists[index].totalLiked = newsFeedLists[index].totalLiked! + 1;
      newsFeedLists[index].isLiked = true;
    } else {
      newsFeedLists[index].totalLiked = newsFeedLists[index].totalLiked! - 1;
      newsFeedLists[index].isLiked = false;
    }
    notifyListeners();
    await newsFeedRepo.addLike(postID, isGroup: isGroup, isFromLike: isFromPage, groupPageID: groupPageID);
  }

  changeLikeStatus(int value, int index) async {
    if (value == 1) {
      newsFeedLists[index].totalLiked = newsFeedLists[index].totalLiked! + 1;
      newsFeedLists[index].isLiked = true;
    } else {
      newsFeedLists[index].totalLiked = newsFeedLists[index].totalLiked! - 1;
      newsFeedLists[index].isLiked = false;
    }
    notifyListeners();
  }

  void updateCommentDataCount(int index) {
    newsFeedLists[index].totalComment = newsFeedLists[index].totalComment! + 1;
    notifyListeners();
  }

  void deleteNewsfeedData(int index) {
    newsFeedLists.removeAt(index);
    notifyListeners();
  }

  NewsFeedModel newsFeedData = NewsFeedModel();

  addPostOnTimeLine(NewsFeedModel n) async {
    newsFeedLists.insert(0, n);
    notifyListeners();
  }

  updatePostOnTimeLine(int index, NewsFeedModel n) async {
    newsFeedLists.removeAt(index);
    newsFeedLists.insert(0, n);
    notifyListeners();
  }

  //TODO remove post when successfully done block a user
  void afterBlockRemoveUserPosts(int id) {
    newsFeedLists.removeWhere((element) {
      return element.author!.id.toString() == id.toString();
    });
    notifyListeners();
  }

  /////// TODO: for single post

  NewsFeedModel singleNewsFeedModel = NewsFeedModel();
  bool isLoadingSinglePost = true;
  callForSinglePosts(String url) async {
    isLoadingSinglePost = true;
    singleNewsFeedModel = NewsFeedModel();
    //notifyListeners();
    Response response = await newsFeedRepo.callForSinglePostFromNotification(url.replaceAll('comment/', ''));
    isLoadingSinglePost = false;
    if (response.statusCode == 200) {
      singleNewsFeedModel = NewsFeedModel.fromJson(response.body);
    } else {
      Fluttertoast.showToast(msg: response.statusText!);
    }
    notifyListeners();
  }

  singlePostLike(int postID, Function callBackFunction, {bool isGroup = false, bool isFromLike = false, int groupID = 0}) async {
    if (singleNewsFeedModel.isLiked == false) {
      callBackFunction(true);
      singleNewsFeedModel.totalLiked = singleNewsFeedModel.totalLiked! + 1;
      singleNewsFeedModel.isLiked = true;
    } else {
      callBackFunction(false);
      singleNewsFeedModel.totalLiked = singleNewsFeedModel.totalLiked! - 1;
      singleNewsFeedModel.isLiked = false;
    }
    notifyListeners();

    await newsFeedRepo.addLike(postID, isGroup: isGroup, isFromLike: isFromLike, groupPageID: groupID);
  }

  void updateSingleCommentDataCount() {
    singleNewsFeedModel.totalComment = singleNewsFeedModel.totalComment! + 1;
    notifyListeners();
  }

  //TODO: call for get Liked by user list
  List<LikedByModel> likedShareByModels = [];
  bool isLoadingLiked = false;
  bool isBottomLoadingLiked = false;
  int selectPageLiked = 1;
  bool hasNextDataLiked = false;

  updateForLikedSharedUserLists(String url) {
    selectPageLiked++;
    initializeLikedShareByAllUser(url, page: selectPageLiked);
    notifyListeners();
  }

  initializeLikedShareByAllUser(String url, {int page = 1, bool isFirstTime = true}) async {
    if (page == 1) {
      selectPageLiked = 1;
      likedShareByModels.clear();
      likedShareByModels = [];
      isLoadingLiked = true;
      hasNextDataLiked = false;
      isBottomLoadingLiked = false;
      notifyListeners();
    } else {
      isBottomLoadingLiked = true;
      notifyListeners();
    }

    Response response = await newsFeedRepo.callForgetLikedShareUser(url, page);
    isLoadingLiked = false;
    isBottomLoadingLiked = false;
    if (response.statusCode == 200) {
      hasNextDataLiked = response.body['next'] != null ? true : false;
      response.body['results'].forEach((element) {
        likedShareByModels.add(LikedByModel.fromJson(element));
      });
      notifyListeners();
    } else {
      Fluttertoast.showToast(msg: response.statusText!);
    }
    notifyListeners();
  }

  void pushLocalMessage() {
    if (sharedPreferences!.containsKey('chat_list_key')) {
      List<String>? message = sharedPreferences!.getStringList('chat_list_key');
      for (var element in message!) {
        //TODO: push message to socket and clear cache
        Get.snackbar('data', element);
      }
      //TODO: REMOVE ALL LOCAL MESSAGES FROM SHAredPreferences
      //sharedPreferences?.remove('chat_list_key');
    }
  }
}
