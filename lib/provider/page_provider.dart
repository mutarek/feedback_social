import 'dart:io';

import 'package:als_frontend/data/model/response/base/api_response.dart';
import 'package:als_frontend/data/model/response/category_model.dart';
import 'package:als_frontend/data/model/response/news_feed_model.dart';
import 'package:als_frontend/data/model/response/page/athour_pages_model.dart';
import 'package:als_frontend/data/model/response/page/author_page_details_model.dart';
import 'package:als_frontend/data/repository/auth_repo.dart';
import 'package:als_frontend/data/repository/newsfeed_repo.dart';
import 'package:als_frontend/data/repository/page_repo.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PageProvider with ChangeNotifier {
  final PageRepo pageRepo;
  final NewsfeedRepo newsfeedRepo;
  final AuthRepo authRepo;

  PageProvider({required this.pageRepo, required this.newsfeedRepo, required this.authRepo});

  bool isLoading = false;

  //TODO: for get ALl Liked Page
  List<AuthorPageModel> likedPageLists = [];

  initializeLikedPageLists() async {
    ApiResponse response = await pageRepo.getAllLikedPageLists();
    isLoading = false;
    if (response.response.statusCode == 200) {
      response.response.data.forEach((element) {
        likedPageLists.add(AuthorPageModel.fromJson(element));
      });
    } else {
      Fluttertoast.showToast(msg: response.response.statusMessage!);
    }
    notifyListeners();
  }

  //TODO: for get ALl Suggest Page
  List<AuthorPageModel> allSuggestPageList = [];

  initializeSuggestPage() async {
    ApiResponse response = await pageRepo.getAllSuggestedPage();
    isLoading = false;
    if (response.response.statusCode == 200) {
      response.response.data.forEach((element) {
        allSuggestPageList.add(AuthorPageModel.fromJson(element));
      });
    } else {
      Fluttertoast.showToast(msg: response.response.statusMessage!);
    }
    notifyListeners();
  }

  //TODO: for get ALl Author Page
  List<AuthorPageModel> authorPageLists = [];

  initializeAuthorPageLists() async {
    isLoading = true;
    authorPageLists.clear();
    authorPageLists = [];
    likedPageLists.clear();
    likedPageLists = [];
    allSuggestPageList.clear();
    allSuggestPageList = [];
    ApiResponse response = await pageRepo.getAuthorPage();

    initializeLikedPageLists();
    initializeSuggestPage();
    isLoading = false;
    notifyListeners();
    if (response.response.statusCode == 200) {
      response.response.data.forEach((element) {
        authorPageLists.add(AuthorPageModel.fromJson(element));
      });
    } else {
      isLoading = false;
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
    ApiResponse response = await pageRepo.getCategory();
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

  CategoryModel categoryValue = CategoryModel();

  changeGroupCategory(CategoryModel value) {
    categoryValue = value;
    notifyListeners();
  }

  // TODO: for create and update Group
  createPage(String groupName, File? file, Function callback) async {
    isLoading = true;
    notifyListeners();
    ApiResponse response;
    if (file != null) {
      FormData formData = FormData();
      formData.files.add(
          MapEntry('cover_photo', MultipartFile(file.readAsBytes().asStream(), file.lengthSync(), filename: file.path.split("/").last)));
      formData.fields.add(MapEntry('name', groupName));
      formData.fields.add(MapEntry('category', categoryValue.id.toString()));
      response = await pageRepo.createPageWithImageUpload(formData);
    } else {
      response = await pageRepo.createPageWithoutImageUpload({"name": groupName, "category": categoryValue.id});
    }
    isLoading = false;
    if (response.response.statusCode == 201) {
      authorPageLists.insert(
          0,
          AuthorPageModel(
              id: response.response.data['id'],
              name: response.response.data['name'],
              category: response.response.data['category'],
              coverPhoto: response.response.data['cover_photo'],
              avatar: response.response.data['avatar'],
              followers: 0));

      Fluttertoast.showToast(msg: "Page Created successfully");
      callback(true);
    } else {
      callback(false);
      Fluttertoast.showToast(msg: response.response.statusMessage!);
    }
    notifyListeners();
  }

  AuthorPageDetailsModel? pageDetailsModel;

  callForGetPageInformation(String id) async {
    isLoading = true;

    pageDetailsModel = AuthorPageDetailsModel();
    // notifyListeners();
    ApiResponse response = await pageRepo.callForGetPageDetails(id);

    if (response.response.statusCode == 200) {
      pageDetailsModel = AuthorPageDetailsModel.fromJson(response.response.data);
    } else {
      Fluttertoast.showToast(msg: response.response.statusMessage!);
    }
    isLoading = false;
    notifyListeners();
  }

  // TODO:: for Page All Posts
  List<NewsFeedModel> pageAllPosts = [];
  bool isBottomLoading = false;
  int selectPage = 1;
  bool hasNextData = false;

  void deleteNewsfeedData(int index) {
    pageAllPosts.removeAt(index);
    notifyListeners();
  }

  updatePageNo(String id) {
    selectPage++;
    callForGetAllPagePosts(id, page: selectPage);
    notifyListeners();
  }

  callForGetAllPagePosts(String id, {int page = 1, bool isFirstTime = true}) async {
    if (page == 1) {
      selectPage = 1;
      pageAllPosts.clear();
      pageAllPosts = [];
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

    ApiResponse response = await pageRepo.callForGetPageAllPosts(id, selectPage);

    isLoading = false;
    if (response.response.statusCode == 200) {
      hasNextData = response.response.data['next'] != null ? true : false;
      response.response.data['results'].forEach((element) {
        pageAllPosts.add(NewsFeedModel.fromJson(element));
      });
    } else {
      Fluttertoast.showToast(msg: response.response.statusMessage!);
    }
    notifyListeners();
  }

  addPagePostToTimeLine(NewsFeedModel n) async {
    pageAllPosts.insert(0, n);
    notifyListeners();
  }

  updatePostOnTimeLine(int index, NewsFeedModel n) async {
    pageAllPosts.removeAt(index);
    pageAllPosts.insert(0, n);
    notifyListeners();
  }

  Future<bool> updatePage(String groupName, File? file, int pageID, int index) async {
    isLoading = true;
    notifyListeners();
    ApiResponse response;
    FormData formData = FormData();
    if (file != null) {
      formData.files.add(
          MapEntry('cover_photo', MultipartFile(file.readAsBytes().asStream(), file.lengthSync(), filename: file.path.split("/").last)));
      formData.fields.add(MapEntry('name', groupName));
      formData.fields.add(MapEntry('category', categoryValue.id.toString()));
      response = await pageRepo.updatePageWithImageUpload(formData, pageID);
    } else {
      response = await pageRepo.updatePageWithoutImageUpload({"name": groupName, "category": categoryValue.id}, pageID);
    }
    isLoading = false;
    if (response.response.statusCode == 200) {
      authorPageLists.removeAt(index);
      authorPageLists.insert(
          0,
          AuthorPageModel(
              id: response.response.data['id'],
              coverPhoto: response.response.data['cover_photo'],
              category: response.response.data['category'],
              avatar: response.response.data['avatar'],
              name: response.response.data['name'],
              followers: response.response.data['total_like']));
      Fluttertoast.showToast(msg: "Update successfully");
      notifyListeners();
      return true;
    } else {
      Fluttertoast.showToast(msg: response.response.statusMessage!);
    }
    notifyListeners();
    return false;
  }

  addLike(int pageID, int postID, int index) async {
    if (pageAllPosts[index].isLiked == false) {
      pageAllPosts[index].totalLiked = pageAllPosts[index].totalLiked! + 1;
      pageAllPosts[index].isLiked = true;
    } else {
      pageAllPosts[index].totalLiked = pageAllPosts[index].totalLiked! - 1;
      pageAllPosts[index].isLiked = false;
    }

    notifyListeners();
    await newsfeedRepo.addLikeONPage(postID, pageID);
  }

  changeLikeStatus(int value, int index) async {
    if (value == 1) {
      pageAllPosts[index].totalLiked = pageAllPosts[index].totalLiked! + 1;
      pageAllPosts[index].isLiked = true;
    } else {
      pageAllPosts[index].totalLiked = pageAllPosts[index].totalLiked! - 1;
      pageAllPosts[index].isLiked = false;
    }
    notifyListeners();
  }

  void updateCommentDataCount(int index) {
    pageAllPosts[index].totalComment = pageAllPosts[index].totalComment! + 1;
    notifyListeners();
  }

  loadingStart() {
    isLoading = true;
    notifyListeners();
  }

  pageLikeUnlike(int pageID, {bool isFromMyPageScreen = false, int index = 0, bool isFromSuggestedPage = false}) async {
    ApiResponse response = await pageRepo.pageLikeUnlike(pageID.toString());
    if (response.response.statusCode == 200) {
      if (response.response.data['liked'] == true) {
        pageDetailsModel!.totalLike = pageDetailsModel!.totalLike! + 1;
        pageDetailsModel!.like = true;
        if (isFromMyPageScreen) {
          authorPageLists[index].followers = authorPageLists[index].followers + 1;
          likedPageLists.insert(0, authorPageLists[index]);
          if (isFromSuggestedPage) {
            allSuggestPageList.removeAt(index);
          }
        }
      } else {
        pageDetailsModel!.totalLike = pageDetailsModel!.totalLike! - 1;
        pageDetailsModel!.like = false;
        if (isFromMyPageScreen) {
          authorPageLists[index].followers = authorPageLists[index].followers - 1;
          allSuggestPageList.insert(index, authorPageLists[index]);
          likedPageLists.removeAt(index);
        }
      }
      notifyListeners();
    }
  }

  //TODO for menu value
  int menuValue = 0;

  changeMenuValue(int value) {
    menuValue = value;
    notifyListeners();
  }
}
