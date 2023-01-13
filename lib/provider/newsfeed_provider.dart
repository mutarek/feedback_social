import 'dart:convert';
import 'package:als_frontend/data/model/response/base/api_response.dart';
import 'package:als_frontend/data/model/response/chat/offline_chat_model.dart';
import 'package:als_frontend/data/model/response/liked_by_model.dart';
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
  final NewsfeedRepo newsFeedRepo1;
  final AuthRepo authRepo1;

  NewsFeedProvider({required this.newsFeedRepo1, required this.authRepo1});

  int position = 0;
  List<NewsFeedModel> newsFeedLists = [];
  bool isLoading = false;
  bool isBottomLoading = false;
  int selectPage = 1;
  bool hasNextData = false;
  late SharedPreferences? sharedPreferences;
  final _itemsPerPage = 5;
  int _currentPage = 0;

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
    print('Loading from api');
    ApiResponse response = await newsFeedRepo1.getNewsFeedData(page);
    isLoading = false;
    isBottomLoading = false;
    if (response.response.statusCode == 200) {
      // var dataa = response.response.data;
      // file.writeAsStringSync(dataa.toString(),
      //     flush: true, mode: FileMode.write);
      hasNextData = response.response.data['next'] != null ? true : false;
      response.response.data['results'].forEach((element) {
        newsFeedLists.add(NewsFeedModel.fromJson(element));
      });
    } else {
      Fluttertoast.showToast(msg: response.response.statusMessage!);
    }
    notifyListeners();
    // String filename =
    //     AppConstant.baseUrl + AppConstant.newsFeedURI + page.toString();
    // var dir = await getTemporaryDirectory();
    // File file = File("${dir.path}/$filename");
    // if (file.existsSync()) {
    //   print('Loading from cache');
    //   var jsonData = file.readAsStringSync();
    //   final String response = jsonDecode(jsonData);
    //   final data = await json.decode(response);
    //   data['results'].forEach((element) {
    //     newsFeedLists.add(NewsFeedModel.fromJson(element));
    //   });
    // } else {
    //
    // }
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
    mydataList.forEach((element) {
      newsFeedLists.add(NewsFeedModel.fromJson(element));
    });
  }

  addLike(int postID, int index,
      {bool isGroup = false,
      bool isFromPage = false,
      int groupPageID = 0}) async {
    if (newsFeedLists[index].isLiked == false) {
      newsFeedLists[index].totalLiked = newsFeedLists[index].totalLiked! + 1;
      newsFeedLists[index].isLiked = true;
    } else {
      newsFeedLists[index].totalLiked = newsFeedLists[index].totalLiked! - 1;
      newsFeedLists[index].isLiked = false;
    }
    notifyListeners();
    await newsFeedRepo1.addLike(postID,
        isGroup: isGroup, isFromLike: isFromPage, groupPageID: groupPageID);
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
    ApiResponse response = await newsFeedRepo1
        .callForSinglePostFromNotification(url.replaceAll('comment/', ''));
    isLoadingSinglePost = false;
    if (response.response.statusCode == 200) {
      singleNewsFeedModel = NewsFeedModel.fromJson(response.response.data);
    } else {
      Fluttertoast.showToast(msg: response.response.statusMessage!);
    }
    notifyListeners();
  }

  singlePostLike(int postID, Function callBackFunction,
      {bool isGroup = false, bool isFromLike = false, int groupID = 0}) async {
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

    await newsFeedRepo1.addLike(postID,
        isGroup: isGroup, isFromLike: isFromLike, groupPageID: groupID);
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

  initializeLikedShareByAllUser(String url,
      {int page = 1, bool isFirstTime = true}) async {
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

    ApiResponse response =
        await newsFeedRepo1.callForgetLikedShareUser(url, page);
    isLoadingLiked = false;
    isBottomLoadingLiked = false;
    if (response.response.statusCode == 200) {
      hasNextDataLiked = response.response.data['next'] != null ? true : false;
      response.response.data['results'].forEach((element) {
        likedShareByModels.add(LikedByModel.fromJson(element));
      });
      notifyListeners();
    } else {
      Fluttertoast.showToast(msg: response.response.data!);
    }
    notifyListeners();
  }

  void pushLocalMessage() {
    if (sharedPreferences!.containsKey(AppConstant.chats)) {
      List<String> chatsSave =
          sharedPreferences!.getStringList(AppConstant.chats) ?? [];
      List<OfflineChat> chatData = [];
      for (var cart in chatsSave) {
        chatData.add(OfflineChat.fromJson(jsonDecode(cart)));
      }
      for (var element in chatData) {
        //TODO: push message to socket and clear cache
        addPost(element.userId.toString(), element.roomID.toString(),
            element.message.toString(), element.index!);
      }
      //TODO: REMOVE ALL LOCAL MESSAGES FROM SHAredPreferences
    }
  }

  WebSocketChannel channel = IOWebSocketChannel.connect(
      'wss://testing.feedback-social.com/ws/post/191/comment/timeline_post/');

  addPost(String userID, String roomID, String message, int index) async {
    bool result = await InternetConnectionChecker().hasConnection;
    channel = IOWebSocketChannel.connect(
        'wss://testing.feedback-social.com/ws/messaging/thread/$roomID/');
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
