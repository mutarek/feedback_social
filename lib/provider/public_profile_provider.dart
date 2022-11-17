import 'package:als_frontend/data/model/response/news_feed_model.dart';
import 'package:als_frontend/data/model/response/profile-images_model.dart';
import 'package:als_frontend/data/model/response/profile_video_model.dart';
import 'package:als_frontend/data/model/response/user_profile_model.dart';
import 'package:als_frontend/data/repository/newsfeed_repo.dart';
import 'package:als_frontend/data/repository/profile_repo.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_connect/http/src/response/response.dart';

class PublicProfileProvider with ChangeNotifier {
  final ProfileRepo profileRepo;
  final NewsfeedRepo newsfeedRepo;

  PublicProfileProvider({required this.profileRepo, required this.newsfeedRepo});

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  List<NewsFeedModel> publicNewsFeedLists = [];
  bool isBottomLoading = false;
  int selectPage = 1;
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
      if (!isFirstTime) {
        notifyListeners();
      }
    } else {
      isBottomLoading = true;
      notifyListeners();
    }
    Response response = await profileRepo.getUserNewsfeedDataByUsingID(userID, page);
    _isLoading = false;
    isBottomLoading = false;
    callBackFunction(true);
    if (response.statusCode == 200) {
      hasNextData = response.body['next'] != null ? true : false;
      response.body['results'].forEach((element) {
        publicNewsFeedLists.add(NewsFeedModel.fromJson(element));
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
    if (publicNewsFeedLists[index].isLiked == false) {
      publicNewsFeedLists[index].totalLiked = publicNewsFeedLists[index].totalLiked! + 1;
      publicNewsFeedLists[index].isLiked = true;
    } else {
      publicNewsFeedLists[index].totalLiked = publicNewsFeedLists[index].totalLiked! - 1;
      publicNewsFeedLists[index].isLiked = false;
    }

    notifyListeners();
    await newsfeedRepo.addLike(postID);
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

  acceptFriendRequest() {
    publicProfileData.isFriend = true;
    publicProfileData.friendRequestAccept = false;
    publicProfileData.friendRequestSent = false;
    notifyListeners();
  }

  Future sendFriendRequest(Function callback) async {
    Response response = await profileRepo.sendFriendRequest(publicProfileData.id.toString());
    if (response.statusCode == 201) {
      callback(true);
      Fluttertoast.showToast(msg: response.body['message']);
      callForPublicProfileData(publicProfileData.id.toString(), isShowLoading: false);
    } else {
      callback(false);
      Fluttertoast.showToast(msg: response.statusText!);
    }

    notifyListeners();
  }

  Future cancelFriendRequest(Function callback) async {
    Response response = await profileRepo.cancelFriendRequest(publicProfileData.friendRequestSentId.toString());
    if (response.statusCode == 204) {
      callback(true);
      Fluttertoast.showToast(msg: 'Friend Request is canceled successfully');
      callForPublicProfileData(publicProfileData.id.toString(), isShowLoading: false);
    } else {
      callback(false);
      Fluttertoast.showToast(msg: response.statusText!);
    }
    notifyListeners();
  }

  Future unFriend(Function callback) async {
    Response response = await profileRepo.unfriend(publicProfileData.id.toString());
    if (response.statusCode == 200) {
      callback(true);
      Fluttertoast.showToast(msg: response.body['message']);
      callForPublicProfileData(publicProfileData.id.toString(), isShowLoading: false);
    } else {
      callback(false);
      Fluttertoast.showToast(msg: response.statusText!);
    }
    notifyListeners();
  }

  //TODO: ************************* for Block
  bool block = false;
  bool isBlockLoading = false;

  Future<bool> blockUser(int userid) async {
    isBlockLoading = true;
    notifyListeners();
    Response response = await profileRepo.blockUser(userid);
    isBlockLoading = false;
    notifyListeners();
    if (response.statusCode == 201) {
      block = true;
      Fluttertoast.showToast(msg: response.body['message']);
      return true;
    } else {
      Fluttertoast.showToast(msg: response.statusText!);
      return false;
    }
  }
}
