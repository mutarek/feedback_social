import 'dart:io';

import 'package:als_frontend/data/model/response/group/all_group_model.dart';
import 'package:als_frontend/data/model/response/group/author_group_details_model.dart';
import 'package:als_frontend/data/model/response/group/group_memebers_model.dart';
import 'package:als_frontend/data/model/response/group/group_post_model.dart';
import 'package:als_frontend/data/model/response/news_feed_model.dart';
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

  //TODO: for get ALl Suggest Group
  List<AllGroupModel> allSuggestGroupList = [];

  initializeSuggestGroup() async {
    isLoading = true;
    allSuggestGroupList.clear();
    allSuggestGroupList = [];
    Response response = await groupRepo.getAllSuggestGroup();

    if (response.statusCode == 200) {
      initializeAuthorGroup();
      response.body.forEach((element) {
        allSuggestGroupList.add(AllGroupModel.fromJson(element));
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
    if (response.statusCode == 200) {
      response.body.forEach((element) {
        authorGroupList.add(AllGroupModel.fromJson(element));
      });
    } else {
      Fluttertoast.showToast(msg: response.statusText!);
    }
    notifyListeners();
  }

  //TODO: for Group Category
  List<String> items = ['Sports', 'Education', 'Animal', 'Pet', 'Music', 'Entertainment', 'Others'];
  String categoryValue = "Sports";

  changeGroupCategory(String value) {
    categoryValue = value;
    notifyListeners();
  }

  bool groupISPrivate = false;

  changeGroupPrivateStatus(bool value) {
    groupISPrivate = value;
    notifyListeners();
  }

  createGroup(String groupName, File? file, Function callback) async {
    isLoading = true;
    notifyListeners();
    Response response;
    if (file != null) {
      List<Http.MultipartFile> multipartFile = [];

      multipartFile
          .add(Http.MultipartFile('cover_photo', file.readAsBytes().asStream(), file.lengthSync(), filename: file.path.split("/").last));

      response = await groupRepo.createGroupWithImageUpload(
          {"name": groupName, "category": categoryValue, "is_private": groupISPrivate.toString()}, multipartFile);
    } else {
      response =
          await groupRepo.createGroupWithoutImageUpload({"name": groupName, "category": categoryValue, "is_private": groupISPrivate});
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

  //TODO: for User Group
  AuthorGroupDetailsModel groupDetailsModel = AuthorGroupDetailsModel();

  callForGetAllGroupInformation(String id) async {
    isLoading = true;
    groupDetailsModel = AuthorGroupDetailsModel();
    // notifyListeners();
    Response response = await groupRepo.callForGetGroupDetails(id);
    callForGetAllGroupMembers(id);
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
    callForGetAllGroupPosts(id);

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

  callForGetAllGroupPosts(String id) async {
    groupAllPosts.clear();
    groupAllPosts = [];
    Response response = await groupRepo.callForGetGroupAllPosts(id);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String userID = (prefs.getString('userID') ?? '0');
    int status = 0;
    isLoading = false;
    if (response.statusCode == 200) {
      response.body.forEach((element) {
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

        groupAllPosts.add(newsFeedData);
      });
    } else {
      Fluttertoast.showToast(msg: response.statusText!);
    }
    notifyListeners();
  }

  // for LIKE comment

  addLike(int postID, int index) async {
    Response response = await newsfeedRepo.addLike(postID);
    if (response.body['liked'] == true) {
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
    groupAllPosts.add(n);
    likesStatusAllData.add(0);
    notifyListeners();
  }
}
