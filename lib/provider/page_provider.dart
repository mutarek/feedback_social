import 'dart:io';

import 'package:als_frontend/data/model/response/category_model.dart';
import 'package:als_frontend/data/model/response/group/friends_list_model.dart';
import 'package:als_frontend/data/model/response/group/group_images_model.dart';
import 'package:als_frontend/data/model/response/group/group_memebers_model.dart';
import 'package:als_frontend/data/model/response/news_feed_model.dart';
import 'package:als_frontend/data/model/response/page/athour_pages_model.dart';
import 'package:als_frontend/data/model/response/page/author_page_details_model.dart';
import 'package:als_frontend/data/model/response/profile_video_model.dart';
import 'package:als_frontend/data/repository/newsfeed_repo.dart';
import 'package:als_frontend/data/repository/page_repo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:http/http.dart' as Http;
import 'package:shared_preferences/shared_preferences.dart';

class PageProvider with ChangeNotifier {
  final PageRepo pageRepo;
  final NewsfeedRepo newsfeedRepo;

  PageProvider({required this.pageRepo, required this.newsfeedRepo});

  bool isLoading = false;

  //TODO: for get ALl Suggest Page
  List<AuthorPageModel> allSuggestPageList = [];

  initializeSuggestPage() async {
    allSuggestPageList.clear();
    allSuggestPageList = [];
    Response response = await pageRepo.getAllSuggestedPage();
    isLoading = false;
    if (response.statusCode == 200) {
      response.body.forEach((element) {
        allSuggestPageList.add(AuthorPageModel.fromJson(element));
      });
    } else {
      Fluttertoast.showToast(msg: response.statusText!);
    }
    notifyListeners();
  }

  //TODO: for get ALl Author Page
  List<AuthorPageModel> authorPageLists = [];

  initializeAuthorPageLists() async {
    isLoading = true;
    authorPageLists.clear();
    authorPageLists = [];
    Response response = await pageRepo.getAuthorPage();
    if (response.statusCode == 200) {
      initializeSuggestPage();
      isLoading = false;
      response.body.forEach((element) {
        authorPageLists.add(AuthorPageModel.fromJson(element));
      });
    } else {
      isLoading = false;
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
    Response response = await pageRepo.getCategory();
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

  CategoryModel categoryValue = CategoryModel();

  changeGroupCategory(CategoryModel value) {
    categoryValue = value;
    notifyListeners();
  }

  // TODO: for create and update Group
  createPage(String groupName, File? file, Function callback) async {
    isLoading = true;
    notifyListeners();
    Response response;
    if (file != null) {
      List<Http.MultipartFile> multipartFile = [];

      multipartFile
          .add(Http.MultipartFile('cover_photo', file.readAsBytes().asStream(), file.lengthSync(), filename: file.path.split("/").last));

      response = await pageRepo.createPageWithImageUpload({"name": groupName, "category": categoryValue.id.toString()}, multipartFile);
    } else {
      response = await pageRepo.createPageWithoutImageUpload({"name": groupName, "category": categoryValue.id});
    }
    isLoading = false;
    if (response.statusCode == 201) {
      authorPageLists.insert(
          0,
          AuthorPageModel(
              id: response.body['id'],
              name: response.body['name'],
              category: response.body['category'],
              coverPhoto: response.body['cover_photo'],
              avatar: response.body['avatar'],
              followers: 0));

      Fluttertoast.showToast(msg: "Page Created successfully");
      callback(true);
    } else {
      callback(false);
      Fluttertoast.showToast(msg: response.statusText!);
    }
    notifyListeners();
  }

  //TODO: for Group Details
  AuthorPageDetailsModel? pageDetailsModel;

  callForGetPageInformation(String id) async {
    isLoading = true;

    pageDetailsModel = AuthorPageDetailsModel();
    // notifyListeners();
    Response response = await pageRepo.callForGetPageDetails(id);
    callForGetAllPagePosts(id);
    isLoading = false;
    if (response.statusCode == 200) {
      pageDetailsModel = AuthorPageDetailsModel.fromJson(response.body);
    } else {
      Fluttertoast.showToast(msg: response.statusText!);
    }
    notifyListeners();
  }

  // TODO:: for group All Posts
  List<NewsFeedData> pageAllPosts = [];
  List<int> likesStatusAllData = [];
  int position = 0;

  callForGetAllPagePosts(String id) async {
    pageAllPosts.clear();
    pageAllPosts = [];
    Response response = await pageRepo.callForGetPageAllPosts(id);
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

        pageAllPosts.add(newsFeedData);
      });
    } else {
      Fluttertoast.showToast(msg: response.statusText!);
    }
    notifyListeners();
  }

  addPagePostToTimeLine(NewsFeedData n) async {
    pageAllPosts.insert(0, n);
    likesStatusAllData.insert(0, 0);
    notifyListeners();
  }
  updatePostOnTimeLine(int index, NewsFeedData n) async {
    likesStatusAllData.removeAt(index);
    pageAllPosts.removeAt(index);
    likesStatusAllData.insert(0, 0);
    pageAllPosts.insert(0, n);
    notifyListeners();
  }
// TODO: for update Page
  Future<bool> updatePage(String groupName, File? file, int pageID, int index) async {
    isLoading = true;
    notifyListeners();
    Response response;

    if (file != null) {
      List<Http.MultipartFile> multipartFile = [];

      multipartFile
          .add(Http.MultipartFile('cover_photo', file.readAsBytes().asStream(), file.lengthSync(), filename: file.path.split("/").last));

      response =
          await pageRepo.updatePageWithImageUpload({"name": groupName, "category": categoryValue.id.toString()}, multipartFile, pageID);
    } else {
      response = await pageRepo.updatePageWithoutImageUpload({"name": groupName, "category": categoryValue.id}, pageID);
    }
    isLoading = false;
    if (response.statusCode == 200) {
      authorPageLists.removeAt(index);
      authorPageLists.insert(
          0,
          AuthorPageModel(
              id: response.body['id'],
              coverPhoto: response.body['cover_photo'],
              category: response.body['category'],
              avatar: response.body['avatar'],
              name: response.body['name'],
              followers: response.body['total_like']));
      Fluttertoast.showToast(msg: "Update successfully");
      notifyListeners();
      return true;
    } else {
      Fluttertoast.showToast(msg: response.statusText!);
    }
    notifyListeners();
    return false;
  }

  // for LIKE comment

  addLike(int pageID, int postID, int index) async {
    Response response = await newsfeedRepo.addLikeONPage(postID, pageID);
    if (response.body['liked'] == true) {
      likesStatusAllData[index] = 1;
      pageAllPosts[index].totalLike = pageAllPosts[index].totalLike! + 1;
    } else {
      likesStatusAllData[index] = 0;
      pageAllPosts[index].totalLike = pageAllPosts[index].totalLike! - 1;
    }
    notifyListeners();
  }

  changeLikeStatus(int value, int index) async {
    if (value == 1) {
      likesStatusAllData[index] = 1;
      pageAllPosts[index].totalLike = pageAllPosts[index].totalLike! + 1;
    } else {
      likesStatusAllData[index] = 0;
      pageAllPosts[index].totalLike = pageAllPosts[index].totalLike! - 1;
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

//// ****************************************************

  pageLikeUnlike(int pageID, int index) async {
    Response response = await pageRepo.pageLikeUnlike(pageID.toString());
    if (response.statusCode == 200) {
      if (response.body['liked'] == true) {
        pageDetailsModel!.totalLike = pageDetailsModel!.totalLike! + 1;
        pageDetailsModel!.like = true;
        authorPageLists[index].followers = authorPageLists[index].followers + 1;
      } else {
        pageDetailsModel!.totalLike = pageDetailsModel!.totalLike! - 1;
        pageDetailsModel!.like = false;
        authorPageLists[index].followers = authorPageLists[index].followers - 1;
      }
      notifyListeners();
    }
  }
}
