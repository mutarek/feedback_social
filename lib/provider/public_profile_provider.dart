import 'package:als_frontend/data/model/response/base/api_response.dart';
import 'package:als_frontend/data/model/response/news_feed_model.dart';
import 'package:als_frontend/data/model/response/profile_images_model.dart';
import 'package:als_frontend/data/model/response/profile_video_model.dart';
import 'package:als_frontend/data/model/response/user_profile_model.dart';
import 'package:als_frontend/data/repository/newsfeed_repo.dart';
import 'package:als_frontend/data/repository/profile_repo.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PublicProfileProvider with ChangeNotifier{
  final ProfileRepo profileRepo;
  final NewsfeedRepo newsfeedRepo;

  PublicProfileProvider({required this.profileRepo,required this.newsfeedRepo});

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
    ApiResponse response = await profileRepo.getUserNewsfeedDataByUsingID(userID, page);
    _isLoading = false;
    isBottomLoading = false;
    callBackFunction(true);
    if (response.response.statusCode == 200) {
      hasNextData = response.response.data['next'] != null ? true : false;
      response.response.data['results'].forEach((element) {
        publicNewsFeedLists.add(NewsFeedModel.fromJson(element));
      });
    } else {
      Fluttertoast.showToast(msg: response.response.statusMessage!);
    }
    notifyListeners();
  }

  ///TODO: for Public user profile
  UserProfileModel publicProfileData = UserProfileModel();
  bool isProfileLoading = false;

  callForPublicProfileData(String userID, {bool isShowLoading = true}) async {
    if (isShowLoading) isProfileLoading = true;
    if (isShowLoading) publicProfileData = UserProfileModel();
    ApiResponse response = await profileRepo.getPublicProfileInfo(userID);
    isProfileLoading = false;
    if (response.response.statusCode == 200) {
      publicProfileData = UserProfileModel.fromJson(response.response.data);
    } else {
      Fluttertoast.showToast(msg: response.response.statusMessage!);
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

    ApiResponse response = await profileRepo.getPublicProfileImageList(userID);
    _isLoading = false;
    if (response.response.statusCode == 200) {
      response.response.data.forEach((element) {
        publicAllImages.add(ProfileImagesModel.fromJson(element));
      });
    } else {
      Fluttertoast.showToast(msg: response.response.statusMessage!);
    }
    notifyListeners();
  }
  ///// for get Public profile all Video:
  List<ProfileVideoModel> publicAllVideo = [];

  initializeUserAllVideo(String userID) async {
    publicAllVideo.clear();
    publicAllVideo = [];
    _isLoading = true;

    ApiResponse response = await profileRepo.getPublicProfileVideoList(userID);
    _isLoading = false;
    if (response.response.statusCode == 200) {
      response.response.data.forEach((element) {
        publicAllVideo.add(ProfileVideoModel.fromJson(element));
      });
    } else {
      Fluttertoast.showToast(msg: response.response.statusMessage!);
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
    ApiResponse response = await profileRepo.sendFriendRequest(publicProfileData.id.toString());
    if (response.response.statusCode == 201) {
      callback(true);
      Fluttertoast.showToast(msg: response.response.data['message']);
      callForPublicProfileData(publicProfileData.id.toString(), isShowLoading: false);
    } else {
      callback(false);
      Fluttertoast.showToast(msg: response.response.statusMessage!);
    }

    notifyListeners();
  }
  Future addFriend(String id) async {
    ApiResponse response = await profileRepo.sendFriendRequest(id);
    if (response.response.statusCode == 201) {
      Fluttertoast.showToast(msg: response.response.data['message']);
    } else {
      Fluttertoast.showToast(msg: response.response.statusMessage!);
    }
  }

  Future cancelFriendRequest(Function callback) async {
    ApiResponse response = await profileRepo.cancelFriendRequest(publicProfileData.friendRequestSentId.toString());
    if (response.response.statusCode == 204) {
      callback(true);
      Fluttertoast.showToast(msg: 'Friend Request is canceled successfully');
      callForPublicProfileData(publicProfileData.id.toString(), isShowLoading: false);
    } else {
      callback(false);
      Fluttertoast.showToast(msg: response.response.statusMessage!);
    }
    notifyListeners();
  }

  Future unFriend(Function callback) async {
    ApiResponse response = await profileRepo.unfriend(publicProfileData.id.toString());
    if (response.response.statusCode == 200) {
      callback(true);
      Fluttertoast.showToast(msg: response.response.data['message']);
      callForPublicProfileData(publicProfileData.id.toString(), isShowLoading: false);
    } else {
      callback(false);
      Fluttertoast.showToast(msg: response.response.statusMessage!);
    }
    notifyListeners();
  }
  //TODO: ************************* for Block
  bool block = false;
  bool isBlockLoading = false;

  Future<bool> blockUser(int userid) async {
    isBlockLoading = true;
    notifyListeners();
    ApiResponse response = await profileRepo.blockUser(userid);
    isBlockLoading = false;
    notifyListeners();
    if (response.response.statusCode == 201) {
      block = true;
      Fluttertoast.showToast(msg: response.response.data['message']);
      return true;
    } else {
      Fluttertoast.showToast(msg: response.response.statusMessage!);
      return false;
    }
  }
}