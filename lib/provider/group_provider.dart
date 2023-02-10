import 'dart:io';

import 'package:als_frontend/data/model/response/base/api_response.dart';
import 'package:als_frontend/data/model/response/category_model.dart';
import 'package:als_frontend/data/model/response/group/all_group_model.dart';
import 'package:als_frontend/data/model/response/group/find_group_model.dart';
import 'package:als_frontend/data/model/response/group/group_details_model.dart';
import 'package:als_frontend/data/model/response/group/group_memebers_model.dart';
import 'package:als_frontend/data/model/response/news_feed_model.dart';
import 'package:als_frontend/data/model/response/settings/privacy_model.dart';
import 'package:als_frontend/data/repository/auth_repo.dart';
import 'package:als_frontend/data/repository/group_repo.dart';
import 'package:als_frontend/data/repository/newsfeed_repo.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../data/model/response/author_group_model.dart';
import '../data/model/response/friend_model.dart';
import '../data/model/response/group_members.dart';
import '../widgets/snackbar_message.dart';

class GroupProvider with ChangeNotifier {
  final GroupRepo groupRepo;
  final NewsfeedRepo newsfeedRepo;
  final AuthRepo authRepo;

  GroupProvider({required this.groupRepo, required this.newsfeedRepo, required this.authRepo});

  bool isLoading = false;
  bool isLoadingSuggestedGroup = false;

  //TODO: FOR EXPANDED PAGES
  bool yourGroup = false;
  bool joinedGroup = false;
  bool suggestedGroup = false;
  bool adminList = false;
  bool moderatorList = false;
  bool memberList = false;

  String privacy = "Select Privacy";

  changeGroupPrivacy(String item) {
    privacy = item;
    notifyListeners();
  }

  changeMemberListGroupStatus() {
    memberList = !memberList;
    notifyListeners();
  }

  changeModeratorListGroupStatus() {
    moderatorList = !moderatorList;
    notifyListeners();
  }

  changeAdminListGroupStatus() {
    adminList = !adminList;
    notifyListeners();
  }

  changeSuggestedGroupStatus() {
    suggestedGroup = !suggestedGroup;
    if (suggestedGroup) {
      initializeSuggestedGroupLists();
      yourGroup = false;
      joinedGroup = false;
    }
    notifyListeners();
  }

  changeJoinedGroupStatus() {
    joinedGroup = !joinedGroup;
    if (joinedGroup) {
      initializeJoinedGroupLists();
      yourGroup = false;
      suggestedGroup = false;
    }
    notifyListeners();
  }

  changeYourGroupStatus() {
    yourGroup = !yourGroup;
    if (yourGroup) {
      initializeAuthorGroupLists();
      joinedGroup = false;
      suggestedGroup = false;
    }
    notifyListeners();
  }

  bool pageExpended = false;
  bool adminAccessPage = false;
  bool allFollower = false;
  bool adminSectionAccess = false;
  bool moderatorSectionAccess = false;
  bool pendingApprovals = false;
  bool groupPolicy = false;
  bool reportedContent = false;

  changeRepotedContentExpanded() {
    reportedContent = !reportedContent;
    notifyListeners();
  }

  changeGroupPolicyExpanded() {
    groupPolicy = !groupPolicy;
    notifyListeners();
  }

  changePendingApprovalsExpanded() {
    pendingApprovals = !pendingApprovals;
    notifyListeners();
  }

  changeModeratorSectionAccessExpanded() {
    moderatorSectionAccess = !moderatorSectionAccess;
    notifyListeners();
  }

  changeAllFollowerExpanded(String groupID) {
    allFollower = !allFollower;
    if (allFollower == true) {
      getGroupMembers(groupID, isFirstTime: true, page: 1);
    }
    notifyListeners();
  }

  changeAdminSectionAccessExpanded() {
    adminSectionAccess = !adminSectionAccess;
    notifyListeners();
  }

  changeAdminAccessExpanded() {
    adminAccessPage = !adminAccessPage;
    if (adminAccessPage) {
      callForGetAllFriendsPagination(page: 1);
    }
    notifyListeners();
  }

  changeExpended() {
    pageExpended = !pageExpended;
    if (pageExpended) {
      callForGetInviteFriendLists(isFirstTime: true);
    }
    notifyListeners();
  }

  //TODO: for get ALl Suggest Group
  List<AllGroupModel> myGroupList = [];

  initializeMyGroup() async {
    isLoading = true;
    myGroupList.clear();
    myGroupList = [];
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

  //TODO: Adding Value to Privacy Model
  List<PrivacyModel> privacyModels = [];

  addTypeToModel() {
    privacyModels.add(PrivacyModel(id: 1, name: "Public"));
    privacyModels.add(PrivacyModel(id: 2, name: "Private"));
  }

  //TODO: For Group Privacy
  PrivacyModel privacyModel = PrivacyModel();

  changePrivacyType(PrivacyModel value) {
    privacyModel = value;
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
    if (file != null) {
      formData.files.add(
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
  GroupDetailsModel groupDetailsModel = GroupDetailsModel();

  callForGetAllGroupInformation(String id) async {
    isLoadingGroupDetails = true;
    groupDetailsModel = GroupDetailsModel();
    // notifyListeners();
    ApiResponse response = await groupRepo.callForGetGroupDetails(id);
    isLoadingGroupDetails = false;
    if (response.response.statusCode == 200) {
      groupDetailsModel = GroupDetailsModel.fromJson(response.response.data);
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

  updateGroupNo(String id) {
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
      callForGetAllGroupInformation(id);
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
    // if (groupAllPosts[index].isLiked == false) {
    //   groupAllPosts[index].totalLiked = groupAllPosts[index].totalLiked! + 1;
    //   groupAllPosts[index].isLiked = true;
    // } else {
    //   groupAllPosts[index].totalLiked = groupAllPosts[index].totalLiked! - 1;
    //   groupAllPosts[index].isLiked = false;
    // }

    notifyListeners();
    await newsfeedRepo.addLikeONGroup(postID, groupID);
  }

  changeLikeStatus(int value, int index) async {
    // if (value == 1) {
    //   groupAllPosts[index].totalLiked = groupAllPosts[index].totalLiked! + 1;
    //   groupAllPosts[index].isLiked = true;
    // } else {
    //   groupAllPosts[index].totalLiked = groupAllPosts[index].totalLiked! - 1;
    //   groupAllPosts[index].isLiked = false;
    // }
    notifyListeners();
  }

  void updateCommentDataCount(int index) {
    groupAllPosts[index].totalComment = groupAllPosts[index].totalComment! + 1;
    notifyListeners();
  }

  addGroupPostToTimeLine(NewsFeedModel n) async {
    List<NewsFeedModel> groupPostLists = [];
    groupPostLists.addAll(groupAllPosts);
    groupAllPosts.clear();
    groupAllPosts = [];
    notifyListeners();
    groupAllPosts.add(n);
    groupAllPosts.addAll(groupPostLists);
    notifyListeners();
  }

  updatePostOnTimeLine(int index, NewsFeedModel n) async {
    groupAllPosts.removeAt(index);
    groupAllPosts.insert(0, n);
    notifyListeners();
  }

  // TODO: for Group members lists who's not member in this group
  List<Author> friendsList = [];
  List<Author> friendsListTemp = [];

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
        friendsList.add(Author.fromJson(element));
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
        if (element.fullName!.toLowerCase().toString().contains(query.toLowerCase().toString())) {
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

  bool isFromMySuggestedGroup = false;
  bool isFromMyGroup = false;

  trackJoinGroup(int value) {
    if (value == 0) {
      isFromMySuggestedGroup = true;
      isFromMyGroup = false;
    } else if (value == 1) {
      isFromMySuggestedGroup = false;
      isFromMyGroup = true;
    } else {
      isFromMySuggestedGroup = false;
      isFromMyGroup = false;
    }
    notifyListeners();
  }

  resetTrackJoinGroup() {
    isFromMySuggestedGroup = false;
    isFromMyGroup = false;
    joinedGroup = false;
    notifyListeners();
  }

  memberJoin(int groupID, {bool isFromDetails = false, int index = 0}) async {
    ApiResponse response = await groupRepo.memberJoin(groupID.toString());

    if (response.response.statusCode == 201) {
      Fluttertoast.showToast(msg: response.response.data['message']);
      if (isFromDetails) {
        groupDetailsModel.totalMember = groupDetailsModel.totalMember! + 1;
        groupDetailsModel.isMember = true;
      }
      if (isFromMyGroup) {
        myGroupList.add(AllGroupModel(
            id: groupDetailsModel.id as int,
            name: groupDetailsModel.name!,
            category: groupDetailsModel.category!,
            coverPhoto: groupDetailsModel.coverPhoto!,
            isPrivate: groupDetailsModel.isPrivate!,
            totalMember: groupDetailsModel.totalMember! as int));
      } else if (isFromMySuggestedGroup) {
        suggestedGroupList.removeAt(index);
      }
    } else {
      Fluttertoast.showToast(msg: response.response.statusMessage!);
    }
    notifyListeners();
  }

// TODO: for member Join
  leaveGroup(int groupID, int memberId, {int index = 0}) async {
    ApiResponse response = await groupRepo.leaveGroup(groupID.toString(), memberId);

    if (response.response.statusCode == 204) {
      Fluttertoast.showToast(msg: 'Successfully leave this group');
      groupDetailsModel.totalMember = groupDetailsModel.totalMember! - 1;
      groupDetailsModel.isMember = false;

      if (isFromMyGroup) {
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

  ///TODO: for create Page

  String groupName = '';
  String groupPrivacy = '';
  String groupDescription = '';
  String groupBio = '';
  String groupLocation = '';
  String groupAddress = '';
  File? pageCoverPhoto;

  updateInsertGroupInfo(int status,
      {String aGroupName = '',
      String aGroupBio = '',
      String aGroupDescription = '',
      String aGroupPrivacy = '',
      String aGroupLocation = '',
      String aAddress = '',
      File? aCoverPhoto}) {
    if (status == 0) {
      groupName = aGroupName;
      groupBio = aGroupBio;
      groupDescription = aGroupDescription;
    } else if (status == 1) {
      groupLocation = aGroupLocation;
      groupAddress = aAddress;
    } else {
      pageCoverPhoto = aCoverPhoto;
    }
    notifyListeners();
  }

  Future<bool> createGroupNew() async {
    isLoading = true;
    notifyListeners();
    bool isPrivate = false;
    ApiResponse apiResponse;
    if (privacy == "Public") {
      isPrivate = false;
    } else {
      isPrivate = true;
    }
    FormData formData = FormData();
    formData.files.add(MapEntry(
        'cover_photo',
        MultipartFile(pageCoverPhoto!.readAsBytes().asStream(), pageCoverPhoto!.lengthSync(),
            filename: pageCoverPhoto!.path.split("/").last)));
    formData.fields.add(MapEntry('name', groupName));
    formData.fields.add(MapEntry('bio', groupBio));
    formData.fields.add(MapEntry('description', groupDescription));
    formData.fields.add(MapEntry('category', categoryValue.id.toString()));
    formData.fields.add(MapEntry('is_private', isPrivate ? "true" : "false"));
    formData.fields.add(MapEntry('city', groupLocation));
    formData.fields.add(MapEntry('address', groupAddress));
    apiResponse = await groupRepo.createGroup(formData);
    if (apiResponse.response.statusCode == 201) {
      isLoading = false;
      notifyListeners();
      authorGroupLists.insert(
          0,
          AuthorGroupModel(
            id: apiResponse.response.data['id'],
            name: apiResponse.response.data['name'],
            coverPhoto: apiResponse.response.data['cover_photo'],
            totalMember: apiResponse.response.data['total_member'],
            visitGroupUrl: apiResponse.response.data['visit_group_url'],
            copyLinkUrl: apiResponse.response.data['copy_link_url'],
          ));
      Fluttertoast.showToast(msg: "Page Created successfully");
      return true;
    } else {
      Fluttertoast.showToast(msg: apiResponse.response.statusMessage!);
      notifyListeners();
      return false;
    }
  }

  //TODO: Get all author group
  updateAuthorPageNo() {
    selectPage++;
    initializeAuthorGroupLists(page: selectPage);
    notifyListeners();
  }

  List<AuthorGroupModel> authorGroupLists = [];

  initializeAuthorGroupLists({int page = 1, bool isFirstTime = true}) async {
    if (page == 1) {
      selectPage = 1;
      authorGroupLists.clear();
      authorGroupLists = [];
      isLoading = true;
      hasNextData = false;
      isBottomLoading = false;
      if (!isFirstTime) {
        notifyListeners();
      }
    } else {
      isBottomLoading = true;
      notifyListeners();
    }
    ApiResponse response = await groupRepo.getAllAuthorGroups(selectPage);
    isLoading = false;
    isBottomLoading = false;
    notifyListeners();
    if (response.response.statusCode == 200) {
      hasNextData = response.response.data['next'] != null ? true : false;
      response.response.data['results'].forEach((element) {
        authorGroupLists.add(AuthorGroupModel.fromJson(element));
      });
    } else {
      isLoading = false;
      Fluttertoast.showToast(msg: response.response.statusMessage!);
    }
    notifyListeners();
  }

  Future<bool> setupGroup(String name, String desc, String bio, String address) async {
    isLoading = true;
    notifyListeners();
    ApiResponse apiResponse;
    FormData formData = FormData();
    formData.fields.add(MapEntry("name", name));
    formData.fields.add(MapEntry("description", desc));
    formData.fields.add(MapEntry("bio", bio));
    formData.fields.add(MapEntry("address", address));
    apiResponse = await groupRepo.setupGroup(formData, groupDetailsModel.id.toString());
    if (apiResponse.response.statusCode == 200) {
      Fluttertoast.showToast(msg: "Group setup successfully!");
      initializeAuthorGroupLists();
      return true;
    } else {
      Fluttertoast.showToast(msg: apiResponse.response.statusMessage!);
      return false;
    }
  }

  //TODO: FOR GETTING INDIVIDUAL GROUP MEMBER
  List<GroupMembers> groupMembersList = [];
  bool isBottomGroupMemberLoading = false;
  bool hasNextDataGroupMembers = false;

  getGroupMembers(String groupId, {int page = 1, bool isFirstTime = true}) async {
    if (page == 1) {
      groupMembersList.clear();
      groupMembersList = [];
      if (!isFirstTime) {
        notifyListeners();
      }
    } else {
      isBottomGroupMemberLoading = true;
      notifyListeners();
    }
    isLoading = true;
    notifyListeners();
    ApiResponse apiResponse = await groupRepo.getGroupMembers(page, groupId);
    isLoading = false;
    notifyListeners();
    if (apiResponse.response.statusCode == 200) {
      hasNextDataGroupMembers = apiResponse.response.data['next'] != null ? true : false;
      apiResponse.response.data['results'].forEach((member) {
        groupMembersList.add(GroupMembers.fromJson(member));
      });
    } else {
      isLoading = false;
      notifyListeners();
      Fluttertoast.showToast(msg: apiResponse.response.statusMessage!);
    }
  }

//TODO: Get all joined group
  updateJoinedPageNo() {
    selectPage++;
    initializeJoinedGroupLists(page: selectPage);
    notifyListeners();
  }

  List<AuthorGroupModel> joinedGroupList = [];

  initializeJoinedGroupLists({int page = 1, bool isFirstTime = true}) async {
    if (page == 1) {
      selectPage = 1;
      joinedGroupList.clear();
      joinedGroupList = [];
      isLoading = true;
      hasNextData = false;
      isBottomLoading = false;
      if (!isFirstTime) {
        notifyListeners();
      }
    } else {
      isBottomLoading = true;
      notifyListeners();
    }
    ApiResponse response = await groupRepo.getAllJoinedGroups(selectPage);
    isLoading = false;
    isBottomLoading = false;
    notifyListeners();
    if (response.response.statusCode == 200) {
      hasNextData = response.response.data['next'] != null ? true : false;
      response.response.data['results'].forEach((element) {
        joinedGroupList.add(AuthorGroupModel.fromJson(element));
      });
    } else {
      isLoading = false;
      Fluttertoast.showToast(msg: response.response.statusMessage!);
    }
    notifyListeners();
  }

//TODO: Get all suggested group
  updateSuggestedPageNo() {
    selectPage++;
    initializeSuggestedGroupLists(page: selectPage);
    notifyListeners();
  }

  List<AuthorGroupModel> suggestedGroupList = [];

  initializeSuggestedGroupLists({int page = 1, bool isFirstTime = true}) async {
    if (page == 1) {
      selectPage = 1;
      suggestedGroupList.clear();
      suggestedGroupList = [];
      isLoading = true;
      hasNextData = false;
      isBottomLoading = false;
      if (!isFirstTime) {
        notifyListeners();
      }
    } else {
      isBottomLoading = true;
      notifyListeners();
    }
    ApiResponse response = await groupRepo.getALLSuggestedGroups(selectPage);
    isLoading = false;
    isBottomLoading = false;
    notifyListeners();
    if (response.response.statusCode == 200) {
      hasNextData = response.response.data['next'] != null ? true : false;
      response.response.data['results'].forEach((element) {
        suggestedGroupList.add(AuthorGroupModel.fromJson(element));
      });
    } else {
      isLoading = false;
      Fluttertoast.showToast(msg: response.response.statusMessage!);
    }
    notifyListeners();
  }

//TODO:find group
  updateFindPageNo() {
    selectPage++;
    initializeAuthorGroupLists(page: selectPage);
    notifyListeners();
  }

  List<FindGroupModel> findGroupModel = [];
  bool isLoadingFindGroup = false;
  bool isBottomLoadingFindGroup = false;

  updateFindGroupSearchNo(String query) {
    selectPage++;
    findGroup(query, page: selectPage);
    notifyListeners();
  }

  findGroup(String query, {int page = 1}) async {
    if (page == 1) {
      selectPage = 1;
      findGroupModel.clear();
      findGroupModel = [];
      isLoadingFindGroup = true;
      hasNextData = false;
      isBottomLoadingFindGroup = false;
      notifyListeners();
    } else {
      isBottomLoadingFindGroup = true;
      notifyListeners();
    }
    ApiResponse response = await groupRepo.findGroup(query, selectPage);
    isLoadingFindGroup = false;
    notifyListeners();
    if (response.response.statusCode == 200) {
      hasNextData = response.response.data['next'] != null ? true : false;
      response.response.data['results'].forEach((element) {
        findGroupModel.add(FindGroupModel.fromJson(element));
      });
    } else {
      isLoading = false;
      Fluttertoast.showToast(msg: response.response.statusMessage!);
    }
    notifyListeners();
  }

  bool isLoadingUpdateCover = false;

  Future<bool> uploadGroupCover(File? file, int groupID, int index) async {
    isLoadingUpdateCover = true;
    notifyListeners();
    ApiResponse response;
    FormData formData = FormData();
    formData.files.add(
        MapEntry('cover_photo', MultipartFile(file!.readAsBytes().asStream(), file.lengthSync(), filename: file.path.split("/").last)));
    response = await groupRepo.updateGroupCoverPhoto(formData, groupID.toString());
    isLoadingUpdateCover = false;
    notifyListeners();
    if (response.response.statusCode == 200) {
      groupDetailsModel = GroupDetailsModel.fromJson(response.response.data);
      authorGroupLists[index] =
          AuthorGroupModel(id: groupDetailsModel.id, coverPhoto: groupDetailsModel.coverPhoto, name: groupDetailsModel.name);

      Fluttertoast.showToast(msg: "Update successfully");
      notifyListeners();
      return true;
    } else {
      Fluttertoast.showToast(msg: 'Failed to update');
    }
    notifyListeners();
    return false;
  }

  bool isLoadingGroupDetails = false;

  //TODO: FOR GETTING INDIVIDUAL PHOTOS AND VIDEOS DETAILS
  bool isPhotosLoading = false;
  List<ImagesData> groupPhotosModel = [];
  List<VideosData> groupVideosModel = [];

  getForGetAllPhotosVideos() async {
    isLoading = true;
    notifyListeners();
    ApiResponse response = await groupRepo.callForGetAllPhotos(groupDetailsModel.photos!);
    if (response.response.statusCode == 200) {
      response.response.data['results'].forEach((element) {
        groupPhotosModel.add(ImagesData.fromJson(element));
      });
      isLoading = false;
      isPhotosLoading = false;
      notifyListeners();
      ApiResponse response1 = await groupRepo.callForGetAllVideos(groupDetailsModel.videos!);
      if (response1.response.statusCode == 200) {
        response1.response.data['results'].forEach((element) {
          groupVideosModel.add(VideosData.fromJson(element));
        });
      } else {
        Fluttertoast.showToast(msg: response1.response.statusMessage!);
      }
    } else {
      Fluttertoast.showToast(msg: response.response.statusMessage!);
    }
    isLoading = false;
    isPhotosLoading = false;
    notifyListeners();
  }

  //TODO: For Pin Group
  bool isLoadingForPin = false;
  bool isLoadingForPin2 = false;

  callForPinGroup() async {
    isLoadingForPin = true;
    notifyListeners();
    ApiResponse response = await groupRepo.pinGroup(groupDetailsModel.id! as int);
    isLoadingForPin = false;
    if (response.response.statusCode == 200) {
      Fluttertoast.showToast(msg: 'Pin group is successfully Added');
    } else {
      Fluttertoast.showToast(msg: response.response.statusMessage!);
    }
    notifyListeners();
  }

  updatePinGroupNo() {
    selectPage++;
    initializePinGroupLists(page: selectPage);
    notifyListeners();
  }

  List<AuthorGroupModel> pinGroupLists = [];

  initializePinGroupLists({int page = 1, bool isFirstTime = true}) async {
    if (page == 1) {
      selectPage = 1;
      pinGroupLists.clear();
      pinGroupLists = [];
      isLoadingForPin = true;
      hasNextData = false;
      isBottomLoading = false;
      if (!isFirstTime) {
        notifyListeners();
      }
    } else {
      isBottomLoading = true;
      notifyListeners();
    }
    ApiResponse response = await groupRepo.pinGroupList(selectPage);
    isLoadingForPin = false;
    isBottomLoading = false;
    notifyListeners();
    if (response.response.statusCode == 200) {
      hasNextData = response.response.data['next'] != null ? true : false;
      response.response.data['results'].forEach((element) {
        pinGroupLists.add(AuthorGroupModel.fromJson(element));
      });
    } else {
      isLoadingForPin = false;
      Fluttertoast.showToast(msg: response.response.statusMessage!);
    }
    notifyListeners();
  }

  deletePinGroup(int groupID, int index) async {
    isLoadingForPin2 = true;
    notifyListeners();
    ApiResponse response = await groupRepo.deletePinGroup(groupID);
    isLoadingForPin2 = false;
    if (response.response.statusCode == 200) {
      Fluttertoast.showToast(msg: 'Pin group is successfully Deleted');
      pinGroupLists.removeAt(index);
    } else {
      Fluttertoast.showToast(msg: response.response.statusMessage!);
    }
    notifyListeners();
  }

  //TODO: Get Group Invite Friends List
  int selectPageInviteFriend = 1;
  bool isLoadingInviteFriend = false;
  bool isLoadingInviteFriend2 = false;
  bool hasNextDataInviteFriend = false;
  bool isBottomLoadingInviteFriend = false;
  List<Author> invitePageAllLists = [];
  List<bool> invitePageFriendSelect = [];

  updateInviteFriendPageNo() {
    selectPage++;
    callForGetInviteFriendLists(page: selectPage);
    notifyListeners();
  }

  callForGetInviteFriendLists({int page = 1, bool isFirstTime = true}) async {
    if (page == 1) {
      selectPage = 1;
      invitePageAllLists.clear();
      invitePageAllLists = [];
      invitePageFriendSelect.clear();
      invitePageFriendSelect = [];
      isLoadingInviteFriend = true;
      hasNextDataInviteFriend = false;
      isBottomLoadingInviteFriend = false;
      if (!isFirstTime) {
        notifyListeners();
      }
    } else {
      isBottomLoadingInviteFriend = true;
      notifyListeners();
    }

    ApiResponse response = await groupRepo.getAllFriendsForInvite(groupDetailsModel.id.toString(), selectPage);

    isLoadingInviteFriend = false;
    if (response.response.statusCode == 200) {
      hasNextDataInviteFriend = response.response.data['next'] != null ? true : false;
      response.response.data['results'].forEach((element) {
        invitePageAllLists.add(Author.fromJson(element));
        invitePageFriendSelect.add(false);
      });
    } else {
      Fluttertoast.showToast(msg: response.response.statusMessage!);
    }
    notifyListeners();
  }

  changeInviteFriendSelectFriend(int index, bool value) {
    invitePageFriendSelect[index] = value;
    notifyListeners();
  }

  sentInviteFriend(int pageID) async {
    isLoadingInviteFriend2 = true;
    notifyListeners();
    List<int> users = [];
    for (int i = 0; i < invitePageAllLists.length; i++) {
      if (invitePageFriendSelect[i] == true) {
        users.add(invitePageAllLists[i].id as int);
      }
    }

    ApiResponse response = await groupRepo.invitationCreate(pageID, users);

    isLoadingInviteFriend2 = false;
    if (response.response.statusCode == 201) {
      showMessage(message: 'Invite Send Successfully!');
      invitePageAllLists.clear();
      invitePageAllLists = [];
      invitePageFriendSelect.clear();
      invitePageFriendSelect = [];
    } else {
      Fluttertoast.showToast(msg: response.response.statusMessage!);
    }
    notifyListeners();
  }

  //TODO: GET ALL INVITED GROUPS

  List<AuthorGroupModelWithID> invitedGroupList = [];
  bool isLoadingInvitedGroups = false;
  bool isLoadingInvitedGroups2 = false;
  bool isBottomLoadingInvitedGroup = false;
  bool hasInvitedGroupsNextData = false;

  updateInvitedGroupsPageNo() {
    selectPage++;
    getAllInvitedGroups(page: selectPage);
    notifyListeners();
  }

  getAllInvitedGroups({int page = 1, bool isFirstTime = true}) async {
    if (page == 1) {
      selectPage = 1;
      invitedGroupList.clear();
      invitedGroupList = [];
      isLoadingInvitedGroups = true;
      hasInvitedGroupsNextData = false;
      isBottomLoadingInvitedGroup = false;
      if (!isFirstTime) notifyListeners();
    } else {
      isBottomLoadingInvitedGroup = true;
      notifyListeners();
    }
    ApiResponse response = await groupRepo.getInvitedGroups(selectPage);
    isLoadingInvitedGroups = false;
    isBottomLoadingInvitedGroup = false;
    notifyListeners();
    if (response.response.statusCode == 200) {
      hasInvitedGroupsNextData = response.response.data['next'] != null ? true : false;
      response.response.data['results'].forEach((element) {
        invitedGroupList.add(AuthorGroupModelWithID.fromJson(element));
      });
    } else {
      Fluttertoast.showToast(msg: response.response.statusMessage!);
    }
    notifyListeners();
  }

  joinInviteGroup(String invitationID, String groupID, String userID, int index) async {
    isLoadingInvitedGroups2 = true;
    ApiResponse response = await groupRepo.acceptInvitation(invitationID, groupID, userID);
    isLoadingInvitedGroups2 = false;
    notifyListeners();
    if (response.response.statusCode == 201) {
      invitedGroupList.removeAt(index);
      Fluttertoast.showToast(msg: 'Joined successfully');
      notifyListeners();
    } else {
      Fluttertoast.showToast(msg: response.response.statusMessage!);
    }
    notifyListeners();
  }

  cancelInviteGroup(String invitationID, int index) async {
    isLoadingInvitedGroups2 = true;
    ApiResponse response = await groupRepo.cancelInvitation(invitationID);
    isLoadingInvitedGroups2 = false;
    notifyListeners();
    if (response.response.statusCode == 200) {
      invitedGroupList.removeAt(index);
      Fluttertoast.showToast(msg: 'Cancel Invitation Success');
      notifyListeners();
    } else {
      Fluttertoast.showToast(msg: response.response.statusMessage!);
    }
    notifyListeners();
  }

//TODO: Group Block And Unblock Systems
  List<AuthorGroupModel> blockGroupLists = [];
  int selectBlockGroup = 0;
  bool isBottomLoadingBlockGroup = false;
  bool isLoadingBlockGroup = false;
  bool isLoadingBlockGroup2 = false;
  bool hasNextDataBlockGroup = false;

  updateBlockGroupNo() {
    selectBlockGroup++;
    callForGetGroupBlockLists(page: selectBlockGroup);
    notifyListeners();
  }

  callForGetGroupBlockLists({int page = 1, bool isFirstTime = true}) async {
    if (page == 1) {
      selectBlockGroup = 1;
      blockGroupLists.clear();
      blockGroupLists = [];
      isLoadingBlockGroup = true;
      hasNextDataBlockGroup = false;
      isBottomLoadingBlockGroup = false;
      if (!isFirstTime) {
        notifyListeners();
      }
    } else {
      isBottomLoadingBlockGroup = true;
      notifyListeners();
    }

    ApiResponse response = await groupRepo.groupBlockLists(selectPage);

    isLoadingBlockGroup = false;
    isBottomLoadingBlockGroup = false;
    if (response.response.statusCode == 200) {
      hasNextDataBlockGroup = response.response.data['next'] != null ? true : false;
      response.response.data['results'].forEach((element) {
        blockGroupLists.add(AuthorGroupModel.fromJson(element));
      });
    } else {
      Fluttertoast.showToast(msg: response.response.statusMessage!);
    }
    notifyListeners();
  }

  Future<bool> createBlock() async {
    isLoadingBlockGroup2 = true;
    notifyListeners();
    ApiResponse response = await groupRepo.groupBlockCreate(groupDetailsModel.id as int);
    isLoadingBlockGroup2 = false;
    notifyListeners();
    if (response.response.statusCode == 200) {
      Fluttertoast.showToast(msg: 'Grouped Block added Successfully');
      return response.response.data['is_blocked'];
    } else {
      Fluttertoast.showToast(msg: response.response.statusMessage!);
      return false;
    }
  }

  createUnBlock(int pageID, int index) async {
    isLoadingBlockGroup2 = true;
    notifyListeners();
    ApiResponse response = await groupRepo.groupUnBlockCreate(pageID);
    isLoadingBlockGroup2 = false;
    if (response.response.statusCode == 200) {
      Fluttertoast.showToast(msg: 'Grouped UnBlock Successfully Complete');
      blockGroupLists.removeAt(index);
    } else {
      Fluttertoast.showToast(msg: response.response.statusMessage!);
    }
    notifyListeners();
  }

  //TODO: Get All Friends From List
  bool isLoadingFriends = false;
  bool isBottomLoadingFriends = false;
  List<FriendModel> friendsListModel = [];
  bool hasNextFriendData = false;
  List<bool> makeAdminFriendsSelect = [];

  updateAllFriendsPage() {
    selectPage++;
    callForGetAllFriendsPagination(page: selectPage);
    notifyListeners();
  }

  changeAddAdminSelectionValue(int index, bool value) {
    makeAdminFriendsSelect[index] = value;
    notifyListeners();
  }

  callForGetAllFriendsPagination({int page = 1}) async {
    if (page == 1) {
      selectPage = 1;
      friendsListModel.clear();
      friendsListModel = [];
      isLoadingFriends = true;
      isBottomLoadingFriends = false;
      makeAdminFriendsSelect.clear();
      makeAdminFriendsSelect = [];
      hasNextFriendData = false;
    } else {
      isBottomLoadingFriends = true;
      notifyListeners();
    }
    ApiResponse response = await groupRepo.getAllFriends(page);
    isLoadingFriends = false;
    isBottomLoadingFriends = false;
    notifyListeners();
    if (response.response.statusCode == 200) {
      hasNextFriendData = response.response.data['next'] != null ? true : false;
      response.response.data['results'].forEach((element) {
        friendsListModel.add(FriendModel.fromJson(element));
      });
    } else {
      isLoadingFriends = false;
      isBottomLoadingFriends = false;
      notifyListeners();
      Fluttertoast.showToast(msg: response.response.statusMessage!);
    }
    notifyListeners();
  }
}
