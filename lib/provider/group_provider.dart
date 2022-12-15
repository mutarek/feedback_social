import 'dart:io';

import 'package:als_frontend/data/model/response/base/api_response.dart';
import 'package:als_frontend/data/model/response/category_model.dart';
import 'package:als_frontend/data/model/response/group/all_group_model.dart';
import 'package:als_frontend/data/model/response/group/author_group_details_model.dart';
import 'package:als_frontend/data/model/response/group/friends_list_model.dart';
import 'package:als_frontend/data/model/response/group/group_images_model.dart';
import 'package:als_frontend/data/model/response/group/group_memebers_model.dart';
import 'package:als_frontend/data/model/response/news_feed_model.dart';
import 'package:als_frontend/data/model/response/profile_video_model.dart';
import 'package:als_frontend/data/repository/auth_repo.dart';
import 'package:als_frontend/data/repository/group_repo.dart';
import 'package:als_frontend/data/repository/newsfeed_repo.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class GroupProvider with ChangeNotifier {
  final GroupRepo groupRepo;
  final NewsfeedRepo newsfeedRepo;
  final AuthRepo authRepo;

  GroupProvider({required this.groupRepo, required this.newsfeedRepo, required this.authRepo});

  bool isLoading = false;
  bool isLoadingSuggestedGroup = false;

  //TODO: for get ALl Suggest Group
  List<AllGroupModel> allSuggestGroupList = [];

  initializeSuggestGroup() async {
    isLoadingSuggestedGroup = true;
    ApiResponse response = await groupRepo.getAllSuggestGroup();
    isLoadingSuggestedGroup = false;
    if (response.response.statusCode == 200) {
      response.response.data.forEach((element) {
        allSuggestGroupList.add(AllGroupModel.fromJson(element));
      });
    } else {
      Fluttertoast.showToast(msg: response.response.statusMessage!);
    }
    notifyListeners();
  }

  //TODO: for get ALl Suggest Group
  List<AllGroupModel> myGroupList = [];

  initializeMyGroup() async {
    isLoading = true;
    myGroupList.clear();
    myGroupList = [];
    allSuggestGroupList.clear();
    allSuggestGroupList = [];
    menuValue = 0;
    ApiResponse response = await groupRepo.getAllJoinGroup();

    if (response.response.statusCode == 200) {
      initializeAuthorGroup();
      response.response.data.forEach((element) {
        myGroupList.add(AllGroupModel.fromJson(element));
      });
    } else {
      Fluttertoast.showToast(msg: response.response.statusMessage!);
    }
    notifyListeners();
  }

  //TODO: for get ALl Suggest Group
  List<AllGroupModel> authorGroupList = [];

  initializeAuthorGroup() async {
    authorGroupList.clear();
    authorGroupList = [];
    ApiResponse response = await groupRepo.getOwnGroupList();
    isLoading = false;
    notifyListeners();
    if (response.response.statusCode == 200) {
      response.response.data.forEach((element) {
        authorGroupList.add(AllGroupModel.fromJson(element));
      });
    } else {
      Fluttertoast.showToast(msg: response.response.statusMessage!);
    }
    notifyListeners();
  }

  //TODO: for get ALl category
  List<CategoryModel> items = [];

  initializeCategory() async {
    isLoading = true;
    items.clear();
    items = [];
    ApiResponse response = await groupRepo.getCategory();
    isLoading = false;
    if (response.response.statusCode == 200) {
      response.response.data.forEach((element) {
        items.add(CategoryModel.fromJson(element));
      });
      categoryValue = items[0];
    } else {
      Fluttertoast.showToast(msg: response.response.statusMessage!);
    }
    notifyListeners();
  }

  //TODO: for Group Category
  CategoryModel categoryValue = CategoryModel();

  changeGroupCategory(CategoryModel value) {
    categoryValue = value;
    notifyListeners();
  }

  bool groupISPrivate = false;

  changeGroupPrivateStatus(bool value, {bool isFirstTime = false}) {
    groupISPrivate = value;
    if (!isFirstTime) notifyListeners();
  }
  FormData formData = FormData();
  // TODO: for create and update Group
  createGroup(String groupName, File? file, Function callback) async {
    isLoading = true;
    formData = FormData();
    ApiResponse response;

    if (file != null) {
      formData.files.add(
          MapEntry('cover_photo', MultipartFile(file.readAsBytes().asStream(), file.lengthSync(), filename: file.path.split("/").last)));
      formData.fields.addAll([
        MapEntry('name', groupName),
        MapEntry('category', categoryValue.id.toString()),
        MapEntry('is_private', groupISPrivate.toString()),
      ]);

      response = await groupRepo.createGroupWithImageUpload(formData);
    } else {
      response =
      await groupRepo.createGroupWithoutImageUpload({"name": groupName, "category": categoryValue.id, "is_private": groupISPrivate});
    }
    isLoading = false;
    if (response.response.statusCode == 201) {
      authorGroupList.add(AllGroupModel(
          id: response.response.data['id'],
          name: response.response.data['name'],
          category: response.response.data['category'],
          coverPhoto: response.response.data['cover_photo'],
          isPrivate: response.response.data['is_private'],
          totalMember: response.response.data['total_member']));
      Fluttertoast.showToast(msg: "Created successfully");
      callback(true);
    } else {
      callback(false);
      Fluttertoast.showToast(msg: response.response.statusMessage!);
    }
    notifyListeners();
  }

  // TODO: for create and update Group
  updateGroup(String groupName, File? file, Function callback, int groupID, int index) async {
    isLoading = true;
    notifyListeners();
    ApiResponse response;
    if (file != null) {formData.files.add(
        MapEntry('cover_photo', MultipartFile(file.readAsBytes().asStream(), file.lengthSync(), filename: file.path.split("/").last)));
    formData.fields.addAll([
      MapEntry('name', groupName),
      MapEntry('category', categoryValue.id.toString()),
      MapEntry('is_private', groupISPrivate.toString()),
    ]);
      response = await groupRepo.updateGroupWithImageUpload(formData, groupID);
    } else {
      response = await groupRepo
          .updateGroupWithoutImageUpload({"name": groupName, "category": categoryValue.id, "is_private": groupISPrivate}, groupID);
    }
    isLoading = false;
    if (response.response.statusCode == 200) {
      authorGroupList[index].id = response.response.data['id'];
      authorGroupList[index].name = response.response.data['name'];
      authorGroupList[index].category = response.response.data['category'];
      authorGroupList[index].coverPhoto = response.response.data['cover_photo'];
      authorGroupList[index].totalMember = response.response.data['total_member'];

      Fluttertoast.showToast(msg: "Update successfully");
      callback(true);
    } else {
      callback(false);
      Fluttertoast.showToast(msg: response.response.statusMessage!);
    }
    notifyListeners();
  }

  loadingStart() {
    isLoading = true;
    notifyListeners();
  }

  //TODO: for User Group
  AuthorGroupDetailsModel groupDetailsModel = AuthorGroupDetailsModel();

  callForGetAllGroupInformation(String id) async {
    isLoading = true;
    groupMembersLists.clear();
    groupMembersLists = [];
    groupAllPosts.clear();
    groupAllPosts = [];
    groupDetailsModel = AuthorGroupDetailsModel();
    // notifyListeners();
    ApiResponse response = await groupRepo.callForGetGroupDetails(id);
    callForGetAllGroupMembers(id);
    isLoading = false;
    if (response.response.statusCode == 200) {
      groupDetailsModel = AuthorGroupDetailsModel.fromJson(response.response.data);
    } else {
      Fluttertoast.showToast(msg: response.response.statusMessage!);
    }
    notifyListeners();
  }

  // TODO:: for group Members
  List<GroupMembersModel> groupMembersLists = [];

  callForGetAllGroupMembers(String id) async {
    groupMembersLists.clear();
    groupMembersLists = [];
    ApiResponse response = await groupRepo.callForGetGroupMembers(id);

    if (response.response.statusCode == 200) {
      response.response.data.forEach((element) {
        groupMembersLists.add(GroupMembersModel.fromJson(element));
      });
    } else {
      Fluttertoast.showToast(msg: response.response.statusMessage!);
    }
    notifyListeners();
  }

  // TODO:: for group All Posts
  List<NewsFeedModel> groupAllPosts = [];
  int position = 0;
  bool isBottomLoading = false;
  int selectPage = 1;
  bool hasNextData = false;

  void deleteNewsfeedData(int index) {
    groupAllPosts.removeAt(index);
    notifyListeners();
  }

  updatePageNo(String id) {
    selectPage++;
    callForGetAllGroupPosts(id, page: selectPage);
    notifyListeners();
  }

  callForGetAllGroupPosts(String id, {int page = 1, bool isFirstTime = true}) async {
    if (page == 1) {
      selectPage = 1;
      groupAllPosts.clear();
      groupAllPosts = [];
      isLoading = true;
      hasNextData = false;
      isBottomLoading = false;
      position = 0;
      menuValue = 0;
      if (!isFirstTime) {
        notifyListeners();
      }
    } else {
      isBottomLoading = true;
      notifyListeners();
    }

    ApiResponse response = await groupRepo.callForGetGroupAllPosts(id, selectPage);

    isLoading = false;
    isBottomLoading = false;

    if (response.response.statusCode == 200) {
      hasNextData = response.response.data['next'] != null ? true : false;
      response.response.data['results'].forEach((element) {
        groupAllPosts.add(NewsFeedModel.fromJson(element));
      });
    } else {
      Fluttertoast.showToast(msg: response.response.statusMessage!);
    }
    notifyListeners();
  }

  // for LIKE comment

  addLike(int groupID, int postID, int index) async {
    if (groupAllPosts[index].isLiked == false) {
      groupAllPosts[index].totalLiked = groupAllPosts[index].totalLiked! + 1;
      groupAllPosts[index].isLiked = true;
    } else {
      groupAllPosts[index].totalLiked = groupAllPosts[index].totalLiked! - 1;
      groupAllPosts[index].isLiked = false;
    }

    notifyListeners();
    await newsfeedRepo.addLikeONGroup(postID, groupID);
  }

  changeLikeStatus(int value, int index) async {
    if (value == 1) {
      groupAllPosts[index].totalLiked = groupAllPosts[index].totalLiked! + 1;
      groupAllPosts[index].isLiked = true;
    } else {
      groupAllPosts[index].totalLiked = groupAllPosts[index].totalLiked! - 1;
      groupAllPosts[index].isLiked = false;
    }
    notifyListeners();
  }

  void updateCommentDataCount(int index) {
    groupAllPosts[index].totalComment = groupAllPosts[index].totalComment! + 1;
    notifyListeners();
  }

  addGroupPostTimeLine(NewsFeedModel n) async {
    groupAllPosts.insert(0, n);
    notifyListeners();
  }

  updatePostOnTimeLine(int index, NewsFeedModel n) async {
    groupAllPosts.removeAt(index);
    groupAllPosts.insert(0, n);
    notifyListeners();
  }

  // TODO: for Group Image
  List<GroupImagesModel> groupImagesLists = [];
  bool isLoadingForGroupImageVideo = false;

  callForGetAllGroupImage(int groupID) async {
    isLoadingForGroupImageVideo = true;
    groupImagesLists.clear();
    groupImagesLists = [];
    //notifyListeners();
    ApiResponse response = await groupRepo.callForGetGroupAllImages(groupID.toString());
    isLoadingForGroupImageVideo = false;
    if (response.response.statusCode == 200) {
      response.response.data.forEach((element) {
        groupImagesLists.add(GroupImagesModel.fromJson(element));
      });
    } else {
      Fluttertoast.showToast(msg: response.response.statusMessage!);
    }
    notifyListeners();
  }

  // TODO: for Group Video
  List<ProfileVideoModel> groupVideoLists = [];

  callForGetAllGroupVideo(int groupID) async {
    isLoadingForGroupImageVideo = true;
    groupVideoLists.clear();
    groupVideoLists = [];
    //notifyListeners();
    ApiResponse response = await groupRepo.callForGetGroupAllVideo(groupID.toString());
    isLoadingForGroupImageVideo = false;
    if (response.response.statusCode == 200) {
      response.response.data.forEach((element) {
        groupVideoLists.add(ProfileVideoModel.fromJson(element));
      });
    } else {
      Fluttertoast.showToast(msg: response.response.statusMessage!);
    }
    notifyListeners();
  }

  // TODO: for Group members lists who's not member in this group
  List<FriendListModel> friendsList = [];
  List<FriendListModel> friendsListTemp = [];

  callForGetAllGroupMemberWhoNotMember(int groupID) async {
    isLoading = true;
    friendsList.clear();
    friendsList = [];
    friendsListTemp.clear();
    friendsListTemp = [];
    //notifyListeners();
    ApiResponse response = await groupRepo.callForGetAllGroupMemberWhoNotMember(groupID.toString());
    isLoading = false;
    if (response.response.statusCode == 200) {
      response.response.data.forEach((element) {
        friendsList.add(FriendListModel.fromJson(element));
      });
      friendsListTemp.addAll(friendsList);
    } else {
      Fluttertoast.showToast(msg: response.response.statusMessage!);
    }
    notifyListeners();
  }

  searchUser(String query) {
    friendsList.clear();
    friendsList = [];
    if (query.isEmpty) {
      friendsList.addAll(friendsListTemp);
      notifyListeners();
    } else {
      for (var element in friendsListTemp) {
        if (element.fullName.toLowerCase().toString().contains(query.toLowerCase().toString())) {
          friendsList.add(element);
        }
      }
      notifyListeners();
    }
  }

// TODO: for send invitation
  sendInvitation(int groupID, int userID, int index) async {
    ApiResponse response = await groupRepo.sendInvitation(groupID.toString(), userID);

    if (response.response.statusCode == 201) {
      Fluttertoast.showToast(msg: response.response.data['message']);
      friendsList.removeAt(index);
      friendsListTemp.removeAt(index);
    } else {
      Fluttertoast.showToast(msg: response.response.statusMessage!);
    }
    notifyListeners();
  }

// TODO: for member Join
  memberJoin(int groupID, {bool isFromMyGroup = false, int index = 0}) async {
    ApiResponse response = await groupRepo.memberJoin(groupID.toString());

    if (response.response.statusCode == 201) {
      Fluttertoast.showToast(msg: response.response.data['message']);
      groupDetailsModel.totalMember = groupDetailsModel.totalMember! + 1;
      groupDetailsModel.isMember = true;
      callForGetAllGroupMembers(groupID.toString());
      if (isFromMyGroup) {
        allSuggestGroupList.removeAt(index);
        myGroupList.insert(
            0,
            AllGroupModel(
                id: groupDetailsModel.id as int,
                name: groupDetailsModel.name!,
                category: groupDetailsModel.category!,
                coverPhoto: groupDetailsModel.coverPhoto!,
                isPrivate: groupDetailsModel.isPrivate!,
                totalMember: groupDetailsModel.totalMember! as int));
      }
    } else {
      Fluttertoast.showToast(msg: response.response.statusMessage!);
    }
    notifyListeners();
  }

// TODO: for member Join
  leaveGroup(int groupID, {int index = 0, bool isFromMYGroup = false}) async {
    ApiResponse response = await groupRepo.leaveGroup(groupID.toString());

    if (response.response.statusCode == 204) {
      Fluttertoast.showToast(msg: 'Successfully leave this group');
      groupDetailsModel.totalMember = groupDetailsModel.totalMember! - 1;
      groupDetailsModel.isMember = false;
      callForGetAllGroupMembers(groupID.toString());
      if (isFromMYGroup) {
        allSuggestGroupList.insert(0, myGroupList[index]);
        myGroupList.removeAt(index);
      }
    } else {
      Fluttertoast.showToast(msg: response.response.statusMessage!);
    }
    notifyListeners();
  }

  //TODO for menu value
  int menuValue = 0;

  changeMenuValue(int value) {
    menuValue = value;
    notifyListeners();
  }
}
