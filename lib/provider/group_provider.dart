import 'dart:io';

import 'package:als_frontend/data/model/response/group/all_group_model.dart';
import 'package:als_frontend/data/repository/group_repo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:http/http.dart' as Http;

class GroupProvider with ChangeNotifier {
  final GroupRepo groupRepo;

  GroupProvider({required this.groupRepo});

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

  createGroup(String groupName, File? file,Function callback) async {
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
}
