import 'dart:convert';
import 'package:als_frontend/data/model/response/base/api_response.dart';
import 'package:als_frontend/data/model/response/chat/offline_chat_model.dart';
import 'package:als_frontend/data/model/response/news_feed_model.dart';
import 'package:als_frontend/data/repository/auth_repo.dart';
import 'package:als_frontend/data/repository/newsfeed_repo.dart';
import 'package:als_frontend/util/app_constant.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';


class NewsFeedProvider with ChangeNotifier {
  final NewsfeedRepo newsFeedRepo;
  final AuthRepo authRepo1;

  NewsFeedProvider({required this.newsFeedRepo, required this.authRepo1});

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
    ApiResponse response = await newsFeedRepo.getNewsFeedData(page);
    isLoading = false;
    isBottomLoading = false;
    if (response.response.statusCode == 200) {
      hasNextData = response.response.data['next'] != null ? true : false;
      response.response.data['results'].forEach((element) {
        newsFeedLists.add(NewsFeedModel.fromJson(element));
      });
    } else {
      Fluttertoast.showToast(msg: response.response.statusMessage!);
    }
    notifyListeners();
  }

  saveLastTenData(List<NewsFeedModel> newsFeedLists) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    List<NewsFeedModel> savedList = [];
    savedList.sublist(newsFeedLists.length - 9, newsFeedLists.length);
    for (var singleItem in savedList) {
      String data = jsonEncode(singleItem);
      //TODO: save to shared storage
      prefs.setStringList('offlineNewsfeed', [data]);
    }
  }

  getSavedList() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final mydataList = prefs.getStringList('offlineNewsfeed') ?? [];
    for (var element in mydataList) {
      newsFeedLists.add(NewsFeedModel.fromJson(element));
    }
  }

  hideNewsFeedData(index) {
    newsFeedLists.removeAt(index);
    notifyListeners();
  }
  addLike(int reactStatusID, int index) async {
    if (reactStatusID == 1 || reactStatusID == 2 || reactStatusID == 3) {
      if (newsFeedLists[index].reaction == -1) newsFeedLists[index].totalReaction = newsFeedLists[index].totalReaction! + 1;

      if (reactStatusID == 1) {
        newsFeedLists[index].totalLiked = newsFeedLists[index].totalLiked! + 1;
        if (newsFeedLists[index].reaction! == 2) newsFeedLists[index].totalLoved = newsFeedLists[index].totalLoved! - 1;
        if (newsFeedLists[index].reaction! == 3) newsFeedLists[index].totalSad = newsFeedLists[index].totalSad! - 1;
      } else if (reactStatusID == 2) {
        newsFeedLists[index].totalLoved = newsFeedLists[index].totalLoved! + 1;
        if (newsFeedLists[index].reaction! == 1) newsFeedLists[index].totalLiked = newsFeedLists[index].totalLiked! - 1;
        if (newsFeedLists[index].reaction! == 3) newsFeedLists[index].totalSad = newsFeedLists[index].totalSad! - 1;
      } else {
        newsFeedLists[index].totalSad = newsFeedLists[index].totalSad! + 1;
        if (newsFeedLists[index].reaction! == 1) newsFeedLists[index].totalLiked = newsFeedLists[index].totalLiked! - 1;
        if (newsFeedLists[index].reaction! == 2) newsFeedLists[index].totalLoved = newsFeedLists[index].totalLoved! - 1;
      }

      newsFeedLists[index].reaction = reactStatusID;
    } else {
      newsFeedLists[index].totalReaction = newsFeedLists[index].totalReaction! - 1;
      newsFeedLists[index].reaction = reactStatusID;
    }
    notifyListeners();
  }

  changeLikeStatus(int index) async {
    if (newsFeedLists[index].reaction != -1) {
      newsFeedLists[index].totalReaction = newsFeedLists[index].totalReaction! - 1;
      if (newsFeedLists[index].reaction == 1) {
        newsFeedLists[index].totalLiked = newsFeedLists[index].totalLiked! - 1;
      } else if (newsFeedLists[index].reaction == 2) {
        newsFeedLists[index].totalLoved = newsFeedLists[index].totalLoved! - 1;
      } else {
        newsFeedLists[index].totalSad = newsFeedLists[index].totalSad! - 1;
      }
      newsFeedLists[index].reaction = -1;
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

  // addPostOnTimeLine(NewsFeedModel n) async {
  //   List<NewsFeedModel> pagePostLists = [];
  //   pagePostLists.addAll(newsFeedLists);
  //   notifyListeners();
  //   newsFeedLists.clear();
  //   newsFeedLists = [];
  //   notifyListeners();
  //   newsFeedLists.insert(0, n);
  //   newsFeedLists.insertAll(1,pagePostLists);
  //   notifyListeners();
  // }

  addPostOnTimeLine(NewsFeedModel n) async {
    newsFeedLists.insert(0, NewsFeedModel());
    newsFeedLists[0] = n;
    notifyListeners();
  }

  updatePostOnTimeLine(int index, NewsFeedModel n) async {
    newsFeedLists[index] = n;
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

  callForSinglePosts(String id) async {
    isLoadingSinglePost = true;
    singleNewsFeedModel = NewsFeedModel();
    //notifyListeners();
    ApiResponse response = await newsFeedRepo.callForSinglePostFromNotification(id);
    isLoadingSinglePost = false;
    if (response.response.statusCode == 200) {
      singleNewsFeedModel = NewsFeedModel.fromJson(response.response.data);
    } else {
      Fluttertoast.showToast(msg: response.response.statusMessage!);
    }
    notifyListeners();
  }

  singlePostLike(int postID, Function callBackFunction, {bool isGroup = false, bool isFromLike = false, int groupID = 0}) async {
    // if (singleNewsFeedModel.isLiked == false) {
    //   callBackFunction(true);
    //   singleNewsFeedModel.totalLiked = singleNewsFeedModel.totalLiked! + 1;
    //   singleNewsFeedModel.isLiked = true;
    // } else {
    //   callBackFunction(false);
    //   singleNewsFeedModel.totalLiked = singleNewsFeedModel.totalLiked! - 1;
    //   singleNewsFeedModel.isLiked = false;
    // }
    notifyListeners();

    await newsFeedRepo.addLike(postID, isGroup: isGroup, isFromLike: isFromLike, groupPageID: groupID);
  }

  void updateSingleCommentDataCount() {
    singleNewsFeedModel.totalComment = singleNewsFeedModel.totalComment! + 1;
    notifyListeners();
  }

  //TODO: call for get Liked by user list
  List<Author> likedShareByModels = [];
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

    ApiResponse response = await newsFeedRepo.callForgetLikedShareUser(url, page);
    isLoadingLiked = false;
    isBottomLoadingLiked = false;
    if (response.response.statusCode == 200) {
      hasNextDataLiked = response.response.data['next'] != null ? true : false;
      response.response.data['results'].forEach((element) {
        likedShareByModels.add(Author.fromJson(element));
      });
      notifyListeners();
    } else {
      Fluttertoast.showToast(msg: response.response.data!);
    }
    notifyListeners();
  }

  void pushLocalMessage() {
    if (sharedPreferences!.containsKey(AppConstant.chats)) {
      List<String> chatsSave = sharedPreferences!.getStringList(AppConstant.chats) ?? [];
      List<OfflineChat> chatData = [];
      for (var cart in chatsSave) {
        chatData.add(OfflineChat.fromJson(jsonDecode(cart)));
      }
      for (var element in chatData) {
        //TODO: push message to socket and clear cache
        addPost(element.userId.toString(), element.roomID.toString(), element.message.toString(), element.index!);
      }
      //TODO: REMOVE ALL LOCAL MESSAGES FROM SHAredPreferences
    }
  }

  WebSocketChannel channel = IOWebSocketChannel.connect('wss://testing.feedback-social.com/ws/post/191/comment/timeline_post/');

  addPost(String userID, String roomID, String message, int index) async {
    bool result = await InternetConnectionChecker().hasConnection;
    channel = IOWebSocketChannel.connect('wss://testing.feedback-social.com/ws/messaging/thread/$roomID/');
    if (result == true) {
      Map map = {
        "data": {"user_id": userID, "room_id": roomID, "text": message},
        "action": "chat"
      };
      channel.sink.add(jsonEncode(map));
      sharedPreferences!.remove(AppConstant.chats);
    }
  }
}
