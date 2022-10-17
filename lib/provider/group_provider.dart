import 'package:als_frontend/data/model/response/group/all_group_model.dart';
import 'package:als_frontend/data/repository/group_repo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_connect/http/src/response/response.dart';

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

  createGroup(String groupName) async {
    isLoading = true;
    Response response = await groupRepo.createGroup({"name": groupName, "category": categoryValue});
    isLoading = false;
    if (response.statusCode == 201) {
      Fluttertoast.showToast(msg: "Created successfully");
    } else {
      Fluttertoast.showToast(msg: response.statusText!);
    }
    notifyListeners();
  }
}
