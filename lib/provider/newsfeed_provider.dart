import 'package:als_frontend/data/model/response/news_feed_model.dart';
import 'package:als_frontend/data/repository/auth_repo.dart';
import 'package:als_frontend/data/repository/newsfeed_repo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_connect/http/src/response/response.dart';

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

  addLike(int postID, int index, {bool isGroup = false, bool isFromPage = false, int groupPageID = 0}) async {
    if (likesStatusAllData[index] == 0) {
      likesStatusAllData[index] = 1;
      newsFeedLists[index].totalLike = newsFeedLists[index].totalLike! + 1;
      newsFeedLists[index]
          .likedBy!
          .add(LikedBy(id: int.parse(authRepo.getUserID()), name: authRepo.getUserName(), profileImage: authRepo.getUserProfile()));
    } else {
      likesStatusAllData[index] = 0;
      newsFeedLists[index].totalLike = newsFeedLists[index].totalLike! - 1;
      newsFeedLists[index].likedBy!.removeWhere((element) => element.id.toString() == authRepo.getUserID());
    }
    notifyListeners();
    await newsFeedRepo.addLike(postID, isGroup: isGroup, isFromLike: isFromPage, groupPageID: groupPageID);
  }

  changeLikeStatus(int value, int index) async {
    if (value == 1) {
      likesStatusAllData[index] = 1;
      newsFeedLists[index].totalLike = newsFeedLists[index].totalLike! + 1;
      newsFeedLists[index]
          .likedBy!
          .add(LikedBy(id: int.parse(authRepo.getUserID()), name: authRepo.getUserName(), profileImage: authRepo.getUserProfile()));
    } else {
      likesStatusAllData[index] = 0;
      newsFeedLists[index].totalLike = newsFeedLists[index].totalLike! - 1;
      newsFeedLists[index].likedBy!.removeWhere((element) => element.id.toString() == authRepo.getUserID());
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

  //TODO remove post when successfully done block a user
  void afterBlockRemoveUserPosts(int id) {
    newsFeedLists.removeWhere((element) {
      return element.author!.id.toString() == id.toString();
    });
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

   singlePostLike(int postID,Function callBackFunction, {bool isGroup = false, bool isFromLike = false, int groupID = 0}) async {
    var contain = singleNewsFeedModel.likedBy!.where((element) => element.id.toString() == authRepo.getUserID());
    if (contain.isEmpty) {
      callBackFunction(true);
      isLikeMe = true;
      singleNewsFeedModel.totalLike = singleNewsFeedModel.totalLike! + 1;
      singleNewsFeedModel.likedBy!
          .add(LikedBy(id: int.parse(authRepo.getUserID()), name: authRepo.getUserName(), profileImage: authRepo.getUserProfile()));
    } else {
      callBackFunction(false);
      isLikeMe = false;
      singleNewsFeedModel.totalLike = singleNewsFeedModel.totalLike! - 1;
      singleNewsFeedModel.likedBy!.removeWhere((element) => element.id.toString() == authRepo.getUserID());
    }
    notifyListeners();

    await newsFeedRepo.addLike(postID, isGroup: isGroup, isFromLike: isFromLike, groupPageID: groupID);

  }

  void updateSingleCommentDataCount() {
    singleNewsFeedModel.totalComment = singleNewsFeedModel.totalComment! + 1;
    notifyListeners();
  }
}
