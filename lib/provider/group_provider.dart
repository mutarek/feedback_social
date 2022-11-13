import 'dart:io';

import 'package:als_frontend/data/model/response/category_model.dart';
import 'package:als_frontend/data/model/response/group/all_group_model.dart';
import 'package:als_frontend/data/model/response/group/author_group_details_model.dart';
import 'package:als_frontend/data/model/response/group/friends_list_model.dart';
import 'package:als_frontend/data/model/response/group/group_images_model.dart';
import 'package:als_frontend/data/model/response/group/group_memebers_model.dart';
import 'package:als_frontend/data/model/response/news_feed_model.dart';
import 'package:als_frontend/data/model/response/profile_video_model.dart';
import 'package:als_frontend/data/repository/group_repo.dart';
import 'package:als_frontend/data/repository/newsfeed_repo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:http/http.dart' as Http;
import 'package:shared_preferences/shared_preferences.dart';

class GroupProvider with ChangeNotifier {
  final GroupRepo groupRepo;
  final NewsfeedRepo newsfeedRepo;

  GroupProvider({required this.groupRepo, required this.newsfeedRepo});

  bool isLoading = false;
  bool isLoadingSuggestedGroup = false;

  //TODO: for get ALl Suggest Group
  List<AllGroupModel> allSuggestGroupList = [];

  initializeSuggestGroup() async {
    isLoadingSuggestedGroup = true;
    Response response = await groupRepo.getAllSuggestGroup();
    isLoadingSuggestedGroup = false;
    if (response.statusCode == 200) {
      response.body.forEach((element) {
        allSuggestGroupList.add(AllGroupModel.fromJson(element));
      });
    } else {
      Fluttertoast.showToast(msg: response.statusText!);
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
    Response response = await groupRepo.getAllJoinGroup();

    if (response.statusCode == 200) {
      initializeAuthorGroup();
      response.body.forEach((element) {
        myGroupList.add(AllGroupModel.fromJson(element));
      });
    } else {
      Fluttertoast.showToast(msg: response.statusText!);
    }
    notifyListeners();
  }

  //TODO: for get ALl Suggest Group
  List<AllGroupModel> authorGroupList = [];

  initializeAuthorGroup() async {
    authorGroupList.clear();
    authorGroupList = [];
    Response response = await groupRepo.getOwnGroupList();
    isLoading = false;
    notifyListeners();
    if (response.statusCode == 200) {
      response.body.forEach((element) {
        authorGroupList.add(AllGroupModel.fromJson(element));
      });
    } else {
      Fluttertoast.showToast(msg: response.statusText!);
    }
    notifyListeners();
  }

  //TODO: for get ALl category
  List<CategoryModel> items = [];

  initializeCategory() async {
    isLoading = true;
    items.clear();
    items = [];
    Response response = await groupRepo.getCategory();
    isLoading = false;
    if (response.statusCode == 200) {
      response.body.forEach((element) {
        items.add(CategoryModel.fromJson(element));
      });
      categoryValue = items[0];
    } else {
      Fluttertoast.showToast(msg: response.statusText!);
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

  // TODO: for create and update Group
  createGroup(String groupName, File? file, Function callback) async {
    isLoading = true;
    notifyListeners();
    Response response;
    if (file != null) {
      List<Http.MultipartFile> multipartFile = [];

      multipartFile
          .add(Http.MultipartFile('cover_photo', file.readAsBytes().asStream(), file.lengthSync(), filename: file.path.split("/").last));

      response = await groupRepo.createGroupWithImageUpload(
          {"name": groupName, "category": categoryValue.id.toString(), "is_private": groupISPrivate.toString()}, multipartFile);
    } else {
      response =
          await groupRepo.createGroupWithoutImageUpload({"name": groupName, "category": categoryValue.id, "is_private": groupISPrivate});
    }
    isLoading = false;
    if (response.statusCode == 201) {
      authorGroupList.add(AllGroupModel(
          id: response.body['id'],
          name: response.body['name'],
          category: response.body['category'],
          coverPhoto: response.body['cover_photo'],
          isPrivate: response.body['is_private'],
          totalMember: response.body['total_member']));
      Fluttertoast.showToast(msg: "Created successfully");
      callback(true);
    } else {
      callback(false);
      Fluttertoast.showToast(msg: response.statusText!);
    }
    notifyListeners();
  }

  // TODO: for create and update Group
  updateGroup(String groupName, File? file, Function callback, int groupID, int index) async {
    isLoading = true;
    notifyListeners();
    Response response;
    if (file != null) {
      List<Http.MultipartFile> multipartFile = [];

      multipartFile
          .add(Http.MultipartFile('cover_photo', file.readAsBytes().asStream(), file.lengthSync(), filename: file.path.split("/").last));

      response = await groupRepo.updateGroupWithImageUpload(
          {"name": groupName, "category": categoryValue.id.toString(), "is_private": groupISPrivate.toString()}, multipartFile, groupID);
    } else {
      response = await groupRepo
          .updateGroupWithoutImageUpload({"name": groupName, "category": categoryValue.id, "is_private": groupISPrivate}, groupID);
    }
    isLoading = false;
    if (response.statusCode == 200) {
      authorGroupList[index].id = response.body['id'];
      authorGroupList[index].name = response.body['name'];
      authorGroupList[index].category = response.body['category'];
      authorGroupList[index].coverPhoto = response.body['cover_photo'];
      authorGroupList[index].totalMember = response.body['total_member'];

      Fluttertoast.showToast(msg: "Update successfully");
      callback(true);
    } else {
      callback(false);
      Fluttertoast.showToast(msg: response.statusText!);
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
    Response response = await groupRepo.callForGetGroupDetails(id);
    callForGetAllGroupMembers(id);
    isLoading = false;
    if (response.statusCode == 200) {
      groupDetailsModel = AuthorGroupDetailsModel.fromJson(response.body);
    } else {
      Fluttertoast.showToast(msg: response.statusText!);
    }
    notifyListeners();
  }

  // TODO:: for group Members
  List<GroupMembersModel> groupMembersLists = [];

  callForGetAllGroupMembers(String id) async {
    groupMembersLists.clear();
    groupMembersLists = [];
    Response response = await groupRepo.callForGetGroupMembers(id);

    if (response.statusCode == 200) {
      response.body.forEach((element) {
        groupMembersLists.add(GroupMembersModel.fromJson(element));
      });
    } else {
      Fluttertoast.showToast(msg: response.statusText!);
    }
    notifyListeners();
  }

  // TODO:: for group All Posts
  List<NewsFeedData> groupAllPosts = [];
  List<int> likesStatusAllData = [];
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
      likesStatusAllData.clear();
      likesStatusAllData = [];
      if (!isFirstTime) {
        notifyListeners();
      }
    } else {
      isBottomLoading = true;
      notifyListeners();
    }

    Response response = await groupRepo.callForGetGroupAllPosts(id, selectPage);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userID = (prefs.getString('userID') ?? '0');
    int status = 0;
    isLoading = false;
    isBottomLoading = false;

    if (response.statusCode == 200) {
      hasNextData = response.body['next'] != null ? true : false;
      response.body['results'].forEach((element) {
        NewsFeedData newsFeedData = NewsFeedData.fromJson(element);

        status = 0;
        likesStatusAllData.add(0);
        for (var e in newsFeedData.likedBy!) {
          if (e.id.toString() == userID) {
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

        groupAllPosts.add(newsFeedData);
      });
    } else {
      Fluttertoast.showToast(msg: response.statusText!);
    }
    notifyListeners();
  }

  // for LIKE comment

  addLike(int groupID, int postID, int index) async {
    if (likesStatusAllData[index] == 0) {
      likesStatusAllData[index] = 1;
      groupAllPosts[index].totalLike = groupAllPosts[index].totalLike! + 1;
    } else {
      likesStatusAllData[index] = 0;
      groupAllPosts[index].totalLike = groupAllPosts[index].totalLike! - 1;
    }
    notifyListeners();
    await newsfeedRepo.addLikeONGroup(postID, groupID);
  }

  changeLikeStatus(int value, int index) async {
    if (value == 1) {
      likesStatusAllData[index] = 1;
      groupAllPosts[index].totalLike = groupAllPosts[index].totalLike! + 1;
    } else {
      likesStatusAllData[index] = 0;
      groupAllPosts[index].totalLike = groupAllPosts[index].totalLike! - 1;
    }
    notifyListeners();
  }

  void updateCommentDataCount(int index) {
    groupAllPosts[index].totalComment = groupAllPosts[index].totalComment! + 1;
    notifyListeners();
  }

  addGroupPostTimeLine(NewsFeedData n) async {
    groupAllPosts.insert(0, n);
    likesStatusAllData.insert(0, 0);
    notifyListeners();
  }

  updatePostOnTimeLine(int index, NewsFeedData n) async {
    likesStatusAllData.removeAt(index);
    groupAllPosts.removeAt(index);
    likesStatusAllData.insert(0, 0);
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
    Response response = await groupRepo.callForGetGroupAllImages(groupID.toString());
    isLoadingForGroupImageVideo = false;
    if (response.statusCode == 200) {
      response.body.forEach((element) {
        groupImagesLists.add(GroupImagesModel.fromJson(element));
      });
    } else {
      Fluttertoast.showToast(msg: response.statusText!);
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
    Response response = await groupRepo.callForGetGroupAllVideo(groupID.toString());
    isLoadingForGroupImageVideo = false;
    if (response.statusCode == 200) {
      response.body.forEach((element) {
        groupVideoLists.add(ProfileVideoModel.fromJson(element));
      });
    } else {
      Fluttertoast.showToast(msg: response.statusText!);
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
    Response response = await groupRepo.callForGetAllGroupMemberWhoNotMember(groupID.toString());
    isLoading = false;
    if (response.statusCode == 200) {
      response.body.forEach((element) {
        friendsList.add(FriendListModel.fromJson(element));
      });
      friendsListTemp.addAll(friendsList);
    } else {
      Fluttertoast.showToast(msg: response.statusText!);
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
    Response response = await groupRepo.sendInvitation(groupID.toString(), userID);

    if (response.statusCode == 201) {
      Fluttertoast.showToast(msg: response.body['message']);
      friendsList.removeAt(index);
      friendsListTemp.removeAt(index);
    } else {
      Fluttertoast.showToast(msg: response.statusText!);
    }
    notifyListeners();
  }

// TODO: for member Join
  memberJoin(int groupID, {bool isFromMyGroup = false, int index = 0}) async {
    Response response = await groupRepo.memberJoin(groupID.toString());

    if (response.statusCode == 201) {
      Fluttertoast.showToast(msg: response.body['message']);
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
      Fluttertoast.showToast(msg: response.statusText!);
    }
    notifyListeners();
  }

// TODO: for member Join
  leaveGroup(int groupID, {int index = 0, bool isFromMYGroup = false}) async {
    Response response = await groupRepo.leaveGroup(groupID.toString());

    if (response.statusCode == 204) {
      Fluttertoast.showToast(msg: 'Successfully leave this group');
      groupDetailsModel.totalMember = groupDetailsModel.totalMember! - 1;
      groupDetailsModel.isMember = false;
      callForGetAllGroupMembers(groupID.toString());
      if (isFromMYGroup) {
        allSuggestGroupList.insert(0, myGroupList[index]);
        myGroupList.removeAt(index);
      }
    } else {
      Fluttertoast.showToast(msg: response.statusText!);
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