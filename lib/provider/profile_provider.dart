import 'dart:io';

import 'package:als_frontend/data/model/response/base/api_response.dart';
import 'package:als_frontend/data/model/response/followers_model.dart';
import 'package:als_frontend/data/model/response/friend_model.dart';
import 'package:als_frontend/data/model/response/send_friend_request_model.dart';
import 'package:als_frontend/data/model/response/suggested_friend_model.dart';
import 'package:als_frontend/data/model/response/user_profile_model.dart';
import 'package:als_frontend/data/repository/auth_repo.dart';
import 'package:als_frontend/data/repository/newsfeed_repo.dart';
import 'package:als_frontend/data/repository/profile_repo.dart';
import 'package:als_frontend/helper/image_compressure.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/model/response/news_feed_model.dart';

class ProfileProvider with ChangeNotifier{
  final ProfileRepo profileRepo;
  final NewsfeedRepo newsfeedRepo;
  final AuthRepo authRepo;

  ProfileProvider({required this.profileRepo,required this.newsfeedRepo,required this.authRepo});

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  List<NewsFeedModel> newsFeedLists = [];
  bool isBottomLoading = false;
  int selectPage = 1;
  bool hasNextData = false;

  String message = "";
  bool success = false;
  List<String> gender = ["Male", "Female", "Other", ""];
  String selectDGenderValue = "";

  changeGender(String value) {
    selectDGenderValue = value;
    notifyListeners();
  }

  initializeGender(String value) {
    if (value.isEmpty) {
      selectDGenderValue = '';
    } else if (gender.contains(value)) {
      selectDGenderValue = value;
    } else {
      selectDGenderValue = '';
    }
    notifyListeners();
  }

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
      if (!isFirstTime) {
        notifyListeners();
      }
    } else {
      isBottomLoading = true;
      notifyListeners();
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = (prefs.getString('userID') ?? '0');
    ApiResponse response = await profileRepo.getUserNewsfeedDataByUsingID(id, page);
    _isLoading = false;
    isBottomLoading = false;
    callBackFunction(true);
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

  updatePostOnTimeLine(int index, NewsFeedModel n) async {
    newsFeedLists.removeAt(index);
    newsFeedLists.insert(0, n);
    notifyListeners();
  }

  void deleteNewsfeedData(int index) {
    newsFeedLists.removeAt(index);
    notifyListeners();
  }

  ///TODO: for Current user profile
  UserProfileModel userprofileData = UserProfileModel();
  bool isProfileLoading = false;

  initializeUserData() async {
    isProfileLoading = true;
    userprofileData = UserProfileModel();
    ApiResponse response = await profileRepo.getUserInfo();
    isProfileLoading = false;
    if (response.response.statusCode == 200) {
      userprofileData = UserProfileModel.fromJson(response.response.data);
    } else {
      Fluttertoast.showToast(msg: response.response.statusMessage!);
    }
    notifyListeners();
  }

  addLike(int postID, int index) async {
    if (newsFeedLists[index].isLiked == false) {
      newsFeedLists[index].totalLiked = newsFeedLists[index].totalLiked! + 1;
      newsFeedLists[index].isLiked = true;
    } else {
      newsFeedLists[index].totalLiked = newsFeedLists[index].totalLiked! - 1;
      newsFeedLists[index].isLiked = false;
    }

    notifyListeners();

    await newsfeedRepo.addLike(postID);
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
    if (newsFeedLists.isNotEmpty) {
      newsFeedLists[index].totalComment = newsFeedLists[index].totalComment! + 1;
      notifyListeners();
    }
  }

  Future updateData(String firstName, lastName, company, education, religion, liveInAdress, fromAdress, Function callBack) async {
    _isLoading = true;
    notifyListeners();
    ApiResponse response = await profileRepo.updateProfileDetails(
        firstName, lastName, company, education, selectDGenderValue, religion, liveInAdress, fromAdress);
    _isLoading = false;
    if (response.response.statusCode == 200) {
      userprofileData.firstName = response.response.data['first_name'];
      userprofileData.lastName = response.response.data['last_name'];
      userprofileData.gender = response.response.data['gender'];
      userprofileData.livesInAddress =response.response.data['lives_in_address'];
      userprofileData.fromAddress = response.response.data['from_address'];
      userprofileData.religion = response.response.data['religion'];
      userprofileData.presentCompany = response.response.data['company'];
      userprofileData.presentEducation = response.response.data['education'];
      Fluttertoast.showToast(msg: "Profile Update successfully");
      authRepo.changeUserName("${userprofileData.firstName} ${userprofileData.lastName}");
      callBack(true);
    } else {
      Fluttertoast.showToast(msg: response.response.statusMessage!);
      callBack(true);
    }

    notifyListeners();
  }

  //TODO: for upload user profile and cover
  // for pic a image
  File? image;
  int? id;
  final _picker = ImagePicker();

  Future pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = await imageCompressed(imagePathToCompress: File(pickedFile.path));
      notifyListeners();
    }
  }

  bool isLoadingForUploadPhoto = false;

  uploadPhoto(Function callBackFunction, File file, {bool isCover = false}) async {
    isLoadingForUploadPhoto = true;
    FormData formData = FormData();
    if (isCover) {
      formData.files.add(MapEntry('cover_image',MultipartFile(file.readAsBytes().asStream(), file.lengthSync(), filename: file.path.split("/").last)));
    } else {
      formData.files.add(MapEntry('profile_image',MultipartFile(file.readAsBytes().asStream(), file.lengthSync(), filename: file.path.split("/").last)));
    }
    notifyListeners();
    ApiResponse response = await profileRepo.uploadPhoto(formData, isCover: isCover);
    isLoadingForUploadPhoto = false;
    if (response.response.statusCode == 200) {
      if (isCover) {
        userprofileData.coverImage = response.response.data['cover_image'];
      } else {
        authRepo.changeUserImage(response.response.data['profile_image']);
        userprofileData.profileImage = response.response.data['profile_image'];
      }
      callBackFunction(true);
      Fluttertoast.showToast(msg: "Upload Successfully");
    } else {
      callBackFunction(false);
      Fluttertoast.showToast(msg: "Something went wrong!");
    }
    image = null;
    notifyListeners();
  }

  List<NewsFeedModel> publicNewsFeedLists = [];

  updatePublicPageNo() {
    selectPage++;
    initializeAllUserPostData((bool status) {}, page: selectPage);
    notifyListeners();
  }

  initializePublicUserTimelineData(Function callBackFunction, {int page = 1, bool isFirstTime = true}) async {
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = (prefs.getString('userID') ?? '0');
    ApiResponse response = await profileRepo.getUserNewsfeedDataByUsingID(id, page);
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

  List<SuggestFriendModel> suggestFriendRequestList = [];

  removeSuggestionFriend(int position) {
    suggestFriendRequestList.removeAt(position);
    notifyListeners();
  }

  bool isLoadingSuggestedFriend = false;

  updateSuggestedPageNo() {
    selectPage++;
    callForGetAllSuggestFriendRequest(page: selectPage);
    notifyListeners();
  }

  callForGetAllSuggestFriendRequest({int page = 1}) async {
    if (page == 1) {
      selectPage = 1;
      suggestFriendRequestList.clear();
      suggestFriendRequestList = [];
      isLoadingSuggestedFriend = true;
      isBottomLoading = false;
      hasNextData = false;
    } else {
      isBottomLoading = true;
      notifyListeners();
    }
    ApiResponse response = await profileRepo.sendSuggestFriendRequestLists(page);
    isLoadingSuggestedFriend = false;
    isBottomLoading = false;
    if (response.response.statusCode == 200) {
      hasNextData = response.response.data['next'] != null ? true : false;
      response.response.data['results'].forEach((element) {
        SuggestFriendModel newsFeedData = SuggestFriendModel.fromJson(element);
        suggestFriendRequestList.add(newsFeedData);
      });
    } else {
      Fluttertoast.showToast(msg: response.response.statusMessage!);
    }

    notifyListeners();
  }

  //TODO:   for send Friend Request Lists
  int friendRequestSelectPage = 1;
  bool isBottomLoadingFriendRequest = false;
  bool hasNextDataFriendRequest = false;

  updateUpcomingFriendsRequest() {
    friendRequestSelectPage++;
    callForgetAllFriendRequest(page: friendRequestSelectPage);
    notifyListeners();
  }

  List<SendFriendRequestModel> sendFriendRequestLists = [];

  callForgetAllFriendRequest({int page = 1}) async {
    if (page == 1) {
      friendRequestSelectPage = 1;
      sendFriendRequestLists.clear();
      sendFriendRequestLists = [];
      _isLoading = true;
      isBottomLoadingFriendRequest = false;
      hasNextDataFriendRequest = false;
    } else {
      isBottomLoadingFriendRequest = true;
      notifyListeners();
    }

    ApiResponse response = await profileRepo.sendFriendRequestLists(page);
    _isLoading = false;
    isBottomLoadingFriendRequest = false;
    if (page == 1) callForGetAllSuggestFriendRequest();
    if (response.response.statusCode == 200) {
      hasNextDataFriendRequest = response.response.data['next'] != null ? true : false;
      response.response.data['results'].forEach((element) {
        sendFriendRequestLists.add(SendFriendRequestModel.fromJson(element));
      });
    } else {
      Fluttertoast.showToast(msg: response.response.statusMessage!);
    }
    notifyListeners();
  }

  removeRequestAfterCancelRequest(int index) {
    sendFriendRequestLists.removeAt(index);
    notifyListeners();
  }

  //TODO: ************************* for Send Friend Request cancel Friend Request or unfriend

  sendFriendRequest(int userID, int index) async {
    ApiResponse response = await profileRepo.sendFriendRequest(userID.toString());
    if (response.response.statusCode == 201) {
      suggestFriendRequestList.removeAt(index);
      Fluttertoast.showToast(msg: response.response.data['message']);
    } else {
      Fluttertoast.showToast(msg: response.response.statusMessage!);
    }

    notifyListeners();
  }

  Future cancelSuggestedFriend(int index) async {
    suggestFriendRequestList.removeAt(index);
    notifyListeners();
  }

  //TODO: ************************* for Accept Friend Request or unfriend

  Future<bool> acceptFriendRequest(String id, int index, {bool isFromFollowers = false, bool isFromFriendRequest = false}) async {
    ApiResponse response = await profileRepo.acceptFriendRequest(id);
    if (response.response.statusCode == 200) {
      Fluttertoast.showToast(msg: response.response.data['message']);
      if (isFromFollowers) {
        followersModelList[index].isFriend = true;
      } else if (isFromFriendRequest) {
        removeRequestAfterCancelRequest(index);
      } else {}
      notifyListeners();
      return true;
    } else {
      Fluttertoast.showToast(msg: response.response.statusMessage!);
      return false;
    }
  }

  Future cancelFriendRequest(String id, int index) async {
    ApiResponse response = await profileRepo.cancelFriendRequest(id);
    if (response.response.statusCode == 204) {
      Fluttertoast.showToast(msg: 'Friend Request is canceled successfully');
      removeRequestAfterCancelRequest(index);
    } else {
      Fluttertoast.showToast(msg: response.response.statusMessage!);
    }
    notifyListeners();
  }
//TODO:   for get All Friend

  List<FriendModel> paginationFriendLists = [];

  updateAllFriendsPage() {
    selectPage++;
    callForGetAllFriendsPagination(page: selectPage);
    notifyListeners();
  }

  callForGetAllFriendsPagination({int page = 1}) async {
    if (page == 1) {
      selectPage = 1;
      paginationFriendLists.clear();
      paginationFriendLists = [];
      isLoadingSuggestedFriend = true;
      isBottomLoading = false;
      hasNextData = false;
    } else {
      isBottomLoading = true;
      notifyListeners();
    }
    ApiResponse response = await profileRepo.getAllFriends(page);
    isLoadingSuggestedFriend = false;
    isBottomLoading = false;
    if (response.response.statusCode == 200) {
      hasNextData = response.response.data['next'] != null ? true : false;
      response.response.data['results'].forEach((element) {
        FriendModel friendModel = FriendModel.fromJson(element);
        paginationFriendLists.add(friendModel);
      });
    } else {
      Fluttertoast.showToast(msg: response.response.statusMessage!);
    }

    notifyListeners();
  }

  List<FollowersModel> followersModelList = [];

  updateAllFollowersPage() {
    selectPage++;
    callForGetAllFollowersPagination(page: selectPage);
    notifyListeners();
  }

  callForGetAllFollowersPagination({int page = 1}) async {
    if (page == 1) {
      selectPage = 1;
      followersModelList.clear();
      followersModelList = [];
      isLoadingSuggestedFriend = true;
      isBottomLoading = false;
      hasNextData = false;
    } else {
      isBottomLoading = true;
      notifyListeners();
    }
    ApiResponse response = await profileRepo.getAllFollowers(page);
    isLoadingSuggestedFriend = false;
    isBottomLoading = false;
    if (response.response.statusCode == 200) {
      hasNextData = response.response.data['next'] != null ? true : false;
      response.response.data['results'].forEach((element) {
        FollowersModel followersModel = FollowersModel.fromJson(element);
        followersModelList.add(followersModel);
      });
    } else {
      Fluttertoast.showToast(msg: response.response.statusMessage!);
    }

    notifyListeners();
  }
  removeFollowers(int index) {
    followersModelList.removeAt(index);
    userprofileData.followers!.removeAt(index);
    userprofileData.friends!.removeAt(index);
    notifyListeners();
  }

  removeFriend(int index) {
    paginationFriendLists.removeAt(index);
    userprofileData.friends!.removeAt(index);
    notifyListeners();
  }

}