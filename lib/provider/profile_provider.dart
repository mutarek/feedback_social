import 'dart:io';
import 'package:als_frontend/data/model/response/followers_model.dart';
import 'package:als_frontend/data/model/response/friend_model.dart';
import 'package:als_frontend/data/model/response/send_friend_request_model.dart';
import 'package:als_frontend/data/model/response/suggested_friend_model.dart';

import 'package:als_frontend/data/repository/auth_repo.dart';
import 'package:http/http.dart' as Http;
import 'package:als_frontend/data/model/response/news_feed_model.dart';
import 'package:als_frontend/data/model/response/user_profile_model.dart';
import 'package:als_frontend/data/repository/newsfeed_repo.dart';
import 'package:als_frontend/data/repository/profile_repo.dart';
import 'package:als_frontend/helper/image_compressure.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileProvider with ChangeNotifier {
  final ProfileRepo profileRepo;
  final NewsfeedRepo newsfeedRepo;
  final AuthRepo authRepo;

  ProfileProvider({required this.profileRepo, required this.newsfeedRepo, required this.authRepo});

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  int position = 0;
  List<NewsFeedData> newsFeedLists = [];
  bool isBottomLoading = false;
  int selectPage = 1;
  List<int> likesStatusAllData = [];
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
    Response response = await profileRepo.getUserNewsfeedDataByUsingID(id, page);
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

        newsFeedLists.add(newsFeedData);
      });
    } else {
      Fluttertoast.showToast(msg: response.statusText!);
    }
    notifyListeners();
  }

  updatePostOnTimeLine(int index, NewsFeedData n) async {
    likesStatusAllData.removeAt(index);
    newsFeedLists.removeAt(index);
    likesStatusAllData.insert(0, 0);
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
    Response response = await profileRepo.getUserInfo();
    isProfileLoading = false;
    if (response.statusCode == 200) {
      userprofileData = UserProfileModel.fromJson(response.body);
    } else {
      Fluttertoast.showToast(msg: response.statusText!);
    }
    notifyListeners();
  }

  // for LIKE comment

  addLike(int postID, int index) async {
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

    await newsfeedRepo.addLike(postID);
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
    if (newsFeedLists.isNotEmpty) {
      newsFeedLists[index].totalComment = newsFeedLists[index].totalComment! + 1;
      notifyListeners();
    }
  }

  Future updateData(String firstName, lastName, company, education, religion, liveInAdress, fromAdress, Function callBack) async {
    _isLoading = true;
    notifyListeners();
    Response response = await profileRepo.updateProfileDetails(
        firstName, lastName, company, education, selectDGenderValue, religion, liveInAdress, fromAdress);
    _isLoading = false;
    if (response.statusCode == 200) {
      userprofileData.firstName = response.body['first_name'];
      userprofileData.lastName = response.body['last_name'];
      userprofileData.gender = response.body['gender'];
      userprofileData.livesInAddress = response.body['lives_in_address'];
      userprofileData.fromAddress = response.body['from_address'];
      userprofileData.religion = response.body['religion'];
      userprofileData.presentCompany = response.body['company'];
      userprofileData.presentEducation = response.body['education'];
      Fluttertoast.showToast(msg: "Profile Update successfully");
      authRepo.changeUserName("${userprofileData.firstName} ${userprofileData.lastName}");
      callBack(true);
    } else {
      Fluttertoast.showToast(msg: response.statusText!);
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
    List<Http.MultipartFile> multipartFile = [];
    if (isCover) {
      multipartFile
          .add(Http.MultipartFile('cover_image', file.readAsBytes().asStream(), file.lengthSync(), filename: file.path.split("/").last));
    } else {
      multipartFile
          .add(Http.MultipartFile('profile_image', file.readAsBytes().asStream(), file.lengthSync(), filename: file.path.split("/").last));
    }

    notifyListeners();
    Response response = await profileRepo.uploadPhoto(multipartFile, isCover: isCover);
    isLoadingForUploadPhoto = false;
    if (response.statusCode == 200) {
      if (isCover) {
        userprofileData.coverImage = response.body['cover_image'];
      } else {
        authRepo.changeUserImage(response.body['profile_image']);
        userprofileData.profileImage = response.body['profile_image'];
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

  //TODO: for Public All NewsfeedData

  List<NewsFeedData> publicNewsFeedLists = [];
  List<int> publicLikesStatusAllData = [];

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
      position = 0;
      publicLikesStatusAllData.clear();
      publicLikesStatusAllData = [];
      if (!isFirstTime) {
        notifyListeners();
      }
    } else {
      isBottomLoading = true;
      notifyListeners();
    }
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String id = (prefs.getString('userID') ?? '0');
    Response response = await profileRepo.getUserNewsfeedDataByUsingID(id, page);
    _isLoading = false;
    isBottomLoading = false;
    callBackFunction(true);
    int status = 0;
    if (response.statusCode == 200) {
      hasNextData = response.body['next'] != null ? true : false;
      response.body['results'].forEach((element) {
        NewsFeedData newsFeedData = NewsFeedData.fromJson(element);

        status = 0;
        publicLikesStatusAllData.add(0);
        for (var e in newsFeedData.likedBy!) {
          if (e.id.toString() == id) {
            status = 1;
            continue;
          }
        }
        if (status == 0) {
          publicLikesStatusAllData[position] = 0;
        } else {
          publicLikesStatusAllData[position] = 1;
        }
        position++;

        publicNewsFeedLists.add(newsFeedData);
      });
    } else {
      Fluttertoast.showToast(msg: response.statusText!);
    }
    notifyListeners();
  }

  //TODO:   for Suggestion Friend Request Lists
  List<SuggestFriendModel> suggestFriendRequestList = [];
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
    Response response = await profileRepo.sendSuggestFriendRequestLists(page);
    isLoadingSuggestedFriend = false;
    isBottomLoading = false;
    if (response.statusCode == 200) {
      hasNextData = response.body['next'] != null ? true : false;
      response.body['results'].forEach((element) {
        SuggestFriendModel newsFeedData = SuggestFriendModel.fromJson(element);
        suggestFriendRequestList.add(newsFeedData);
      });
    } else {
      Fluttertoast.showToast(msg: response.statusText!);
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

    Response response = await profileRepo.sendFriendRequestLists(page);
    _isLoading = false;
    isBottomLoadingFriendRequest = false;
    if (page == 1) callForGetAllSuggestFriendRequest();
    if (response.statusCode == 200) {
      hasNextDataFriendRequest = response.body['next'] != null ? true : false;
      response.body['results'].forEach((element) {
        sendFriendRequestLists.add(SendFriendRequestModel.fromJson(element));
      });
    } else {
      Fluttertoast.showToast(msg: response.statusText!);
    }
    notifyListeners();
  }

  removeRequestAfterCancelRequest(int index) {
    sendFriendRequestLists.removeAt(index);
    notifyListeners();
  }

//TODO: ************************* for Send Friend Request cancel Friend Request or unfriend

  sendFriendRequest(int userID, int index) async {
    Response response = await profileRepo.sendFriendRequest(userID.toString());
    if (response.statusCode == 201) {
      suggestFriendRequestList.removeAt(index);
      Fluttertoast.showToast(msg: response.body['message']);
    } else {
      Fluttertoast.showToast(msg: response.statusText!);
    }

    notifyListeners();
  }

  Future cancelSuggestedFriend(int index) async {
    suggestFriendRequestList.removeAt(index);
    notifyListeners();
  }

  //TODO: ************************* for Accept Friend Request or unfriend

  Future<bool> acceptFriendRequest(String id, int index, {bool isFromFollowers = false, bool isFromFriendRequest = false}) async {
    Response response = await profileRepo.acceptFriendRequest(id);
    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: response.body['message']);
      if (isFromFollowers) {
        followersModelList[index].isFriend = true;
      } else if (isFromFriendRequest) {
        removeRequestAfterCancelRequest(index);
      } else {}
      notifyListeners();
      return true;
    } else {
      Fluttertoast.showToast(msg: response.statusText!);
      return false;
    }
  }

  Future cancelFriendRequest(String id, int index) async {
    Response response = await profileRepo.cancelFriendRequest(id);
    if (response.statusCode == 204) {
      Fluttertoast.showToast(msg: 'Friend Request is canceled successfully');
      removeRequestAfterCancelRequest(index);
    } else {
      Fluttertoast.showToast(msg: response.statusText!);
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
    Response response = await profileRepo.getAllFriends(page);
    isLoadingSuggestedFriend = false;
    isBottomLoading = false;
    if (response.statusCode == 200) {
      hasNextData = response.body['next'] != null ? true : false;
      response.body['results'].forEach((element) {
        FriendModel friendModel = FriendModel.fromJson(element);
        paginationFriendLists.add(friendModel);
      });
    } else {
      Fluttertoast.showToast(msg: response.statusText!);
    }

    notifyListeners();
  }

  //TODO:   for get All Followers

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
    Response response = await profileRepo.getAllFollowers(page);
    isLoadingSuggestedFriend = false;
    isBottomLoading = false;
    if (response.statusCode == 200) {
      hasNextData = response.body['next'] != null ? true : false;
      response.body['results'].forEach((element) {
        FollowersModel followersModel = FollowersModel.fromJson(element);
        followersModelList.add(followersModel);
      });
    } else {
      Fluttertoast.showToast(msg: response.statusText!);
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
