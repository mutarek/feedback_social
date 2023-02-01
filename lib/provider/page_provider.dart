import 'dart:io';

import 'package:als_frontend/data/model/indivulual_page_details_model.dart';
import 'package:als_frontend/data/model/response/base/api_response.dart';
import 'package:als_frontend/data/model/response/category_model.dart';
import 'package:als_frontend/data/model/response/group/find_page_model.dart';
import 'package:als_frontend/data/model/response/news_feed_model.dart';
import 'package:als_frontend/data/model/response/page/athour_pages_model.dart';
import 'package:als_frontend/data/model/response/page/author_page_details_model.dart';
import 'package:als_frontend/data/model/response/page/page_details_model.dart';
import 'package:als_frontend/data/repository/auth_repo.dart';
import 'package:als_frontend/data/repository/newsfeed_repo.dart';
import 'package:als_frontend/data/repository/page_repo.dart';
import 'package:country_picker/country_picker.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PageProvider with ChangeNotifier {
  final PageRepo pageRepo;
  final NewsfeedRepo newsfeedRepo;
  final AuthRepo authRepo;

  PageProvider({required this.pageRepo, required this.newsfeedRepo, required this.authRepo});

  bool isLoading = false;

  //TODO: FOR DELETE PAGE
  bool isButtonShow = false;

  changeButtonStatus(String query) {
    if (query == "MyPage") {
      isButtonShow = true;
      notifyListeners();
    } else {
      isButtonShow = false;
      notifyListeners();
    }
  }



  deleteSinglePage(String pageId,int index,Function callback) async {
    isLoading = true;
    notifyListeners();
    ApiResponse apiResponse = await pageRepo.deleteSinglePage(pageId);
    if (apiResponse.response.statusCode == 200) {
      authorPageLists.removeAt(index);
      isLoading = false;
      callback(true);
      Fluttertoast.showToast(msg: "Page Deleted Successfully");
      notifyListeners();
    } else {
      isLoading = false;
      callback(false);
      Fluttertoast.showToast(msg: apiResponse.response.statusMessage!);
      notifyListeners();
    }
  }

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

  //TODO: FOR GETTING INDIVIDUAL PAGE DETAILS
  IndividualPageDetailsModel? individualPageDetailsModel;

  callForGetIndividualPageDetails(String id) async {
    isLoading = true;
    individualPageDetailsModel = IndividualPageDetailsModel();
    ApiResponse response = await pageRepo.callForGetIndividualPageDetails(id);
    if (response.response.statusCode == 200) {
      individualPageDetailsModel = IndividualPageDetailsModel.fromJson(response.response.data);
    } else {
      Fluttertoast.showToast(msg: response.response.statusMessage!);
    }
    isLoading = false;
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
    List<NewsFeedModel> pagePostLists = [];
    pagePostLists.addAll(pageAllPosts);
    pageAllPosts.clear();
    pageAllPosts = [];
    notifyListeners();
    pageAllPosts.add(n);
    pageAllPosts.addAll(pagePostLists);
    notifyListeners();
  }

  updatePostOnTimeLine(int index, NewsFeedModel n) async {
    pageAllPosts.removeAt(index);
    pageAllPosts.insert(0, n);
    notifyListeners();
  }

  editPage(String name, String bio, String desc, String category, String number, String email, String website, String address,
      String pageId,int index, Function callBack) async {
    isLoading = true;
    notifyListeners();
    ApiResponse response;
    FormData formData = FormData();
    formData.fields.add(MapEntry('name', name));
    formData.fields.add(MapEntry('bio', bio));
    formData.fields.add(MapEntry('description', desc));
    formData.fields.add(MapEntry('category', category));
    formData.fields.add(MapEntry('contact', number));
    formData.fields.add(MapEntry('email', email));
    formData.fields.add(MapEntry('website', website));
    formData.fields.add(MapEntry('address', address));
    response = await pageRepo.updatePageWithImageUpload(formData, pageId);
    if (response.response.statusCode == 200) {
      AuthorPageModel authorPageModel = authorPageLists[index];
      authorPageModel.name = response.response.data['name'];
      authorPageModel.bio = response.response.data['bio'];
      authorPageModel.category = response.response.data['category'];
      authorPageModel.contact = response.response.data['contact'];
      authorPageModel.email = response.response.data['email'];
      authorPageModel.website = response.response.data['website'];
      authorPageModel.city = response.response.data['city'];
      authorPageModel.address = response.response.data['address'];
      authorPageLists[index] = authorPageModel;
      isLoading = false;
      callBack(true);
      notifyListeners();
      Fluttertoast.showToast(msg: "Page Update Successfully");
    } else {
      isLoading = false;
      callBack(false);
      notifyListeners();
      Fluttertoast.showToast(msg: response.response.statusMessage!);
    }
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
      response = await pageRepo.updatePageWithImageUpload(formData, pageID.toString());
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

  addLike(int reactStatusID, int index) async {
    if (reactStatusID == 1 || reactStatusID == 2 || reactStatusID == 3) {
      if (pageAllPosts[index].reaction == -1) pageAllPosts[index].totalReaction = pageAllPosts[index].totalReaction! + 1;

      if (reactStatusID == 1) {
        pageAllPosts[index].totalLiked = pageAllPosts[index].totalLiked! + 1;
        if (pageAllPosts[index].reaction! == 2) pageAllPosts[index].totalLoved = pageAllPosts[index].totalLoved! - 1;
        if (pageAllPosts[index].reaction! == 3) pageAllPosts[index].totalSad = pageAllPosts[index].totalSad! - 1;
      } else if (reactStatusID == 2) {
        pageAllPosts[index].totalLoved = pageAllPosts[index].totalLoved! + 1;
        if (pageAllPosts[index].reaction! == 1) pageAllPosts[index].totalLiked = pageAllPosts[index].totalLiked! - 1;
        if (pageAllPosts[index].reaction! == 3) pageAllPosts[index].totalSad = pageAllPosts[index].totalSad! - 1;
      } else {
        pageAllPosts[index].totalSad = pageAllPosts[index].totalSad! + 1;
        if (pageAllPosts[index].reaction! == 1) pageAllPosts[index].totalLiked = pageAllPosts[index].totalLiked! - 1;
        if (pageAllPosts[index].reaction! == 2) pageAllPosts[index].totalLoved = pageAllPosts[index].totalLoved! - 1;
      }

      pageAllPosts[index].reaction = reactStatusID;
    } else {
      pageAllPosts[index].totalReaction = pageAllPosts[index].totalReaction! - 1;
      pageAllPosts[index].reaction = reactStatusID;
    }
    notifyListeners();
  }

  changeLikeStatus(int index) async {
    if (pageAllPosts[index].reaction != -1) {
      pageAllPosts[index].totalReaction = pageAllPosts[index].totalReaction! - 1;
      if (pageAllPosts[index].reaction == 1) {
        pageAllPosts[index].totalLiked = pageAllPosts[index].totalLiked! - 1;
      } else if (pageAllPosts[index].reaction == 2) {
        pageAllPosts[index].totalLoved = pageAllPosts[index].totalLoved! - 1;
      } else {
        pageAllPosts[index].totalSad = pageAllPosts[index].totalSad! - 1;
      }
      pageAllPosts[index].reaction = -1;
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

  pageLikeOrUnlike (String pageID) async{
    ApiResponse response = await pageRepo.pageLikeOrUnlike(pageID.toString());
    if(response.response.statusCode == 200){
      Fluttertoast.showToast(msg: "Liked");
    }else{
      Fluttertoast.showToast(msg: response.response.statusMessage!);
    }
  }


  pageLikeUnlike(int pageID, {bool isFromMyPageScreen = false, int index = 0, bool isFromSuggestedPage = false}) async {
    ApiResponse response = await pageRepo.pageLikeUnlike(pageID.toString());
    if (response.response.statusCode == 200) {
      if (response.response.data['liked'] == true) {
        pageDetailsModel!.totalLike = pageDetailsModel!.totalLike! + 1;
        pageDetailsModel!.like = true;
        if (isFromMyPageScreen) {
          authorPageLists[index].followers = authorPageLists[index].followers! + 1;
          likedPageLists.insert(0, authorPageLists[index]);
          if (isFromSuggestedPage) {
            allSuggestPageList.removeAt(index);
          }
        }
      } else {
        pageDetailsModel!.totalLike = pageDetailsModel!.totalLike! - 1;
        pageDetailsModel!.like = false;
        if (isFromMyPageScreen) {
          authorPageLists[index].followers = authorPageLists[index].followers! - 1;
          allSuggestPageList.insert(index, authorPageLists[index]);
          likedPageLists.removeAt(index);
        }
      }
      notifyListeners();
    }
  }

  ////////////////////////// ********************************* NEW Design Page Code Write Here ********************************

  //TODO for menu value
  int menuValue = 0;

  changeMenuValue(int value) {
    menuValue = value;
    notifyListeners();
  }

  bool pageExpended = false;
  bool adminAccessPage = false;
  bool allFollower = false;
  bool adminSectionAccess = false;
  bool moderatorSectionAccess = false;

  changeModeratorSectionAccessExpanded() {
    moderatorSectionAccess = !moderatorSectionAccess;
    notifyListeners();
  }

  changeAllFollowerExpanded() {
    allFollower = !allFollower;
    notifyListeners();
  }

  changeAdminSectionAccessExpanded() {
    adminSectionAccess = !adminSectionAccess;
    notifyListeners();
  }

  changeAdminAccessExpanded() {
    adminAccessPage = !adminAccessPage;
    notifyListeners();
  }

  changeExpended() {
    pageExpended = !pageExpended;
    notifyListeners();
  }

  //TODO: FOR SELECTING COUNTRY FOR PAGE
  String countryName = "Bangladesh";

  void pickupCountry(BuildContext context) {
    showCountryPicker(
        context: context,
        showPhoneCode: false,
        countryListTheme: CountryListThemeData(
          flagSize: 25,
          backgroundColor: Colors.white,
          textStyle: const TextStyle(fontSize: 16, color: Colors.blueGrey),
          bottomSheetHeight: 500,
          borderRadius: const BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
          //Optional. Styles the search field.
          inputDecoration: InputDecoration(
            labelText: 'Search',
            hintText: 'Start typing to search',
            prefixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(borderSide: BorderSide(color: const Color(0xFF8C98A8).withOpacity(0.2))),
          ),
        ),
        onSelect: (Country country) {
          countryName = country.name;
          notifyListeners();
        });
  }

  bool showMoreText = true;

  changeTextValue() {
    showMoreText = !showMoreText;
    notifyListeners();
  }

  ///TODO: for create Page
  String pageName = '';
  String pageBio = '';
  String pageDescription = '';
  String pageContactNumber = '';
  String pageEmail = '';
  String pageWebsiteLink = '';
  String pageAddress = '';
  File? pageCoverPhoto;
  File? pageProfilePhoto;

  updateInsertPageInfo(int status,
      {String aPageName = '',
      String aPageBio = '',
      String aPageDescription = '',
      String aContactNumber = '',
      String aEmail = '',
      String aWebsiteLink = '',
      String aAddress = '',
      File? aCoverPhoto,
      File? aProfilePhoto}) {
    if (status == 0) {
      pageName = aPageName;
      pageBio = aPageBio;
      pageDescription = aPageDescription;
    } else if (status == 1) {
      pageContactNumber = aContactNumber;
      pageEmail = aEmail;
      pageWebsiteLink = aWebsiteLink;
      pageAddress = aAddress;
    } else {
      pageCoverPhoto = aCoverPhoto;
      pageProfilePhoto = aProfilePhoto;
    }
    notifyListeners();
  }

  // TODO: for create and update Group
  Future<bool> createPage1() async {
    isLoading = true;
    notifyListeners();
    ApiResponse response;
    if (pageCoverPhoto != null || pageProfilePhoto != null) {
      FormData formData = FormData();
      if (pageCoverPhoto != null && pageProfilePhoto == null) {
        formData.files.add(MapEntry(
            'cover_photo',
            MultipartFile(pageCoverPhoto!.readAsBytes().asStream(), pageCoverPhoto!.lengthSync(),
                filename: pageCoverPhoto!.path.split("/").last)));
      } else if (pageProfilePhoto != null && pageCoverPhoto == null) {
        formData.files.add(MapEntry(
            'avatar',
            MultipartFile(pageProfilePhoto!.readAsBytes().asStream(), pageProfilePhoto!.lengthSync(),
                filename: pageProfilePhoto!.path.split("/").last)));
      } else {
        formData.files.add(MapEntry(
            'cover_photo',
            MultipartFile(pageCoverPhoto!.readAsBytes().asStream(), pageCoverPhoto!.lengthSync(),
                filename: pageCoverPhoto!.path.split("/").last)));
        formData.files.add(MapEntry(
            'avatar',
            MultipartFile(pageProfilePhoto!.readAsBytes().asStream(), pageProfilePhoto!.lengthSync(),
                filename: pageProfilePhoto!.path.split("/").last)));
      }

      formData.fields.add(MapEntry('name', pageName));
      formData.fields.add(MapEntry('bio', pageBio));
      formData.fields.add(MapEntry('description', pageDescription));
      formData.fields.add(MapEntry('category', categoryValue.id.toString()));
      formData.fields.add(MapEntry('contact', pageContactNumber));
      formData.fields.add(MapEntry('email', pageEmail));
      formData.fields.add(MapEntry('website', pageWebsiteLink));
      formData.fields.add(MapEntry('city', countryName));
      formData.fields.add(MapEntry('address', pageAddress));
      response = await pageRepo.createPageWithImageUpload(formData);
    } else {
      response = await pageRepo.createPageWithoutImageUpload({"name": pageName, "category": categoryValue.id});
    }
    isLoading = false;

    if (response.response.statusCode == 201) {
      authorPageLists.insert(
          0,
          AuthorPageModel(
              id: response.response.data['id'],
              name: response.response.data['name'],
              category: response.response.data['category'],
              contact: response.response.data['contact'],
              email: response.response.data['email'],
              city: response.response.data['city'],
              address: response.response.data['address'],
              coverPhoto: response.response.data['cover_photo'],
              avatar: response.response.data['avatar'],
              followers: 0));

      Fluttertoast.showToast(msg: "Page Created successfully");
      notifyListeners();
      return true;
    } else {
      Fluttertoast.showToast(msg: response.response.statusMessage!);
      notifyListeners();
      return false;
    }
  }

  pageLikeUnlike1(int pageID, {bool isFromMyPageScreen = false, int index = 0, bool isFromSuggestedPage = false}) async {
    ApiResponse response = await pageRepo.pageLikeUnlike(pageID.toString());
    if (response.response.statusCode == 200) {
      if (response.response.data['liked'] == true) {
        if (isFromSuggestedPage) {
          allSuggestPageList.removeAt(index);
        } else {}
        // pageDetailsModel!.totalLike = pageDetailsModel!.totalLike! + 1;
        // pageDetailsModel!.like = true;
        // if (isFromMyPageScreen) {
        //   authorPageLists[index].followers = authorPageLists[index].followers! + 1;
        //   likedPageLists.insert(0, authorPageLists[index]);
        //
        // }
      } else {
        // pageDetailsModel!.totalLike = pageDetailsModel!.totalLike! - 1;
        // pageDetailsModel!.like = false;
        // if (isFromMyPageScreen) {
        //   authorPageLists[index].followers = authorPageLists[index].followers! - 1;
        //   allSuggestPageList.insert(index, authorPageLists[index]);
        //   likedPageLists.removeAt(index);
        // }
      }
      notifyListeners();
    }
  }

  List<FindPageModel> findPageModel = [];
  bool isLoadingFindPage = false;

  findPage(String pageName) async {
    isLoadingFindPage = true;
    findPageModel.clear();
    findPageModel = [];

    //notifyListeners();
    ApiResponse response = await pageRepo.findPage(pageName);
    isLoadingFindPage = false;
    if (response.response.statusCode == 200) {
      response.response.data["results"].forEach((element) {
        findPageModel.add(FindPageModel.fromJson(element));
        notifyListeners();
      });
    } else {
      Fluttertoast.showToast(msg: response.response.statusMessage!);
    }
    notifyListeners();
  }

  //TODO: page details api instigation
  PageDetailsModel? pageDetailsList;

  bool isLoadingPageDetails = false;

  pageDetails(int pageID) async {
    isLoadingPageDetails = true;

    //notifyListeners();
    ApiResponse response = await pageRepo.pageDetails(pageID);
    isLoadingPageDetails = false;
    if (response.response.statusCode == 200) {
      pageDetailsList = PageDetailsModel.fromJson(response.response.data);
      notifyListeners();
    } else {
      Fluttertoast.showToast(msg: response.response.statusMessage!);
    }
    notifyListeners();
  }
}
