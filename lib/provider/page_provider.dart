import 'dart:io';

import 'package:als_frontend/data/model/response/base/api_response.dart';
import 'package:als_frontend/data/model/response/category_model.dart';
import 'package:als_frontend/data/model/response/group/find_page_model.dart';
import 'package:als_frontend/data/model/response/news_feed_model.dart';
import 'package:als_frontend/data/model/response/page/athour_pages_model.dart';
import 'package:als_frontend/data/model/response/page/page_details_model.dart';
import 'package:als_frontend/data/repository/auth_repo.dart';
import 'package:als_frontend/data/repository/newsfeed_repo.dart';
import 'package:als_frontend/data/repository/page_repo.dart';
import 'package:als_frontend/widgets/snackbar_message.dart';
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

  deleteSinglePage(String pageId, int index, Function callback) async {
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
  bool isLoadingMyPage = false;
  bool hasNextDataMyPage = false;
  int mySelectPageNo = 0;

  updateMyLikedPageNo() {
    mySelectPageNo++;
    initializeAuthorPageLists(page: mySelectPageNo);
    notifyListeners();
  }

  initializeLikedPageLists({int page = 1, bool isFirstTime = false}) async {
    if (page == 1) {
      mySelectPageNo = 1;
      likedPageLists.clear();
      likedPageLists = [];
      isLoadingMyPage = true;
      hasNextDataMyPage = false;
      isBottomLoading = false;
      if (!isFirstTime) {
        notifyListeners();
      }
    } else {
      isBottomLoading = true;
      notifyListeners();
    }
    ApiResponse response = await pageRepo.getAllLikedPageLists(mySelectPageNo);
    isLoadingMyPage = false;
    notifyListeners();
    if (response.response.statusCode == 200) {
      hasNextDataMyPage = response.response.data['next'] != null ? true : false;
      if (response.response.data['results'].isNotEmpty) {
        response.response.data['results'].forEach((element) {
          likedPageLists.add(AuthorPageModel.fromJson(element));
        });
      }
    } else {
      Fluttertoast.showToast(msg: response.response.statusMessage!);
    }
    notifyListeners();
  }

  //TODO: for get ALl Suggest Page
  List<AuthorPageModel> allSuggestPageList = [];
  bool isLoadingSuggested = false;

  initializeSuggestPage() async {
    isLoadingSuggested = true;
    ApiResponse response = await pageRepo.getAllSuggestedPage();
    isLoadingSuggested = false;
    if (response.response.statusCode == 200) {
      response.response.data['results'].forEach((element) {
        allSuggestPageList.add(AuthorPageModel.fromJson(element));
      });
    } else {
      Fluttertoast.showToast(msg: response.response.statusMessage!);
    }
    notifyListeners();
  }

  //TODO: for get ALl Author Page
  updateAuthorPageNo() {
    selectPage++;
    initializeAuthorPageLists(page: selectPage);
    notifyListeners();
  }

  List<AuthorPageModel> authorPageLists = [];
  int position = 0;

  initializeAuthorPageLists({int page = 1, bool isFirstTime = true}) async {
    if (page == 1) {
      selectPage = 1;
      authorPageLists.clear();
      authorPageLists = [];
      likedPageLists.clear();
      likedPageLists = [];
      allSuggestPageList.clear();
      allSuggestPageList = [];
      isLoading = true;
      hasNextData = false;
      isBottomLoading = false;
      position = 0;
      if (!isFirstTime) {
        notifyListeners();
      } else {
        pageSummery();
      }
    } else {
      isBottomLoading = true;
      notifyListeners();
    }
    ApiResponse response = await pageRepo.getAuthorPage(page);
    // initializeLikedPageLists();
    isLoading = false;
    isBottomLoading = false;
    notifyListeners();
    if (response.response.statusCode == 200) {
      hasNextData = response.response.data['next'] != null ? true : false;
      response.response.data['results'].forEach((element) {
        authorPageLists.add(AuthorPageModel.fromJson(element));
      });
    } else {
      isLoading = false;
      Fluttertoast.showToast(msg: response.response.statusMessage!);
    }
    notifyListeners();
  }

  acceptInvitation(String inviteId, int index) async {
    ApiResponse response = await pageRepo.acceptInvitation(inviteId);
    if (response.response.statusCode == 200) {
      invitedPageLists.removeAt(index);
      AuthorPageModel authorPageModel = AuthorPageModel();
      authorPageModel.id = invitedPageLists[index].id;
      authorPageModel.name = invitedPageLists[index].name;
      authorPageModel.avatar = invitedPageLists[index].avatar;
      notifyListeners();
    } else {
      Fluttertoast.showToast(msg: response.response.statusMessage!);
    }
  }

  cancelInvitation(String inviteId, int index) async {
    ApiResponse response = await pageRepo.cancelInvitation(inviteId);
    if (response.response.statusCode == 200) {
      invitedPageLists.removeAt(index);
    }
  }

  //TODO: For Getting all inviting page

  List<AuthorPageModel> invitedPageLists = [];

  getAllInvitedPages() async {
    isLoading = true;
    invitedPageLists.clear();
    ApiResponse response = await pageRepo.getInvitedPage();
    isLoading = false;
    if (response.response.statusCode == 200) {
      response.response.data['results'].forEach((element) {
        invitedPageLists.add(AuthorPageModel.fromJson(element));
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

  //TODO: FOR GETTING INDIVIDUAL PAGE DETAILS

  PageDetailsModel pageDetailsModel = PageDetailsModel();
  bool isLoadingPageDetails = false;

  callForGetPageInformation(String id) async {
    isLoadingPageDetails = true;
    isLoadingUpdateCover = false;
    pageDetailsModel = PageDetailsModel();
    // notifyListeners();
    ApiResponse response = await pageRepo.callForGetPageDetails(id);
    isLoadingPageDetails = false;
    if (response.response.statusCode == 200) {
      pageDetailsModel = PageDetailsModel.fromJson(response.response.data);
    } else {
      Fluttertoast.showToast(msg: response.response.statusMessage!);
    }

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
    pageAllPosts[index] = n;
    notifyListeners();
  }

  editPage(String name, String bio, String desc, String category, String number, String email, String website, String address,
      String pageId, int index, Function callBack) async {
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
    isLoading = false;
    if (response.response.statusCode == 200) {
      AuthorPageModel authorPageModel = authorPageLists[index];
      authorPageModel.name = response.response.data['name'];
      authorPageLists[index] = authorPageModel;
      isLoading = false;
      callBack(true);
      notifyListeners();
      Fluttertoast.showToast(msg: "Page Update Successfully");
    } else {
      isLoading = false;
      callBack(false);
      notifyListeners();
      Fluttertoast.showToast(msg: "Failed to update");
    }
  }

  bool isLoadingUpdateCover = false;

  Future<bool> updateCoverAndAvatar(File? file, int pageID, int index, bool isCover) async {
    isLoadingUpdateCover = true;
    notifyListeners();
    ApiResponse response;
    FormData formData = FormData();
    if (isCover) {
      formData.files.add(
          MapEntry('cover_photo', MultipartFile(file!.readAsBytes().asStream(), file.lengthSync(), filename: file.path.split("/").last)));
    } else {
      formData.files
          .add(MapEntry('avatar', MultipartFile(file!.readAsBytes().asStream(), file.lengthSync(), filename: file.path.split("/").last)));
    }
    response = await pageRepo.updatePageWithImageUpload(formData, pageID.toString());
    isLoadingUpdateCover = false;
    notifyListeners();
    if (response.response.statusCode == 200) {
      pageDetailsModel = PageDetailsModel.fromJson(response.response.data);
      authorPageLists[index] = AuthorPageModel(
          id: pageDetailsModel.id,
          coverPhoto: pageDetailsModel.coverPhoto,
          avatar: pageDetailsModel.avatar,
          name: pageDetailsModel.name,
          followers: pageDetailsModel.totalFollower);

      Fluttertoast.showToast(msg: "Update successfully");
      notifyListeners();
      return true;
    } else {
      Fluttertoast.showToast(msg: 'Failed to update');
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

  bool isFromMyPage = false;
  bool isFromSuggestedPage = false;
  bool isFromSearchPage = false;

  void changeSearchView(int value) {
    if (value == 0) {
      isFromMyPage = true;
      isFromSuggestedPage = false;
      isFromSearchPage = false;
    } else if (value == 1) {
      isFromMyPage = false;
      isFromSuggestedPage = true;
      isFromSearchPage = false;
    } else if (value == 2) {
      isFromMyPage = false;
      isFromSuggestedPage = false;
      isFromSearchPage = true;
    } else {
      isFromMyPage = false;
      isFromSuggestedPage = false;
      isFromSearchPage = false;
    }
    notifyListeners();
  }

  pageLikeUnlike(int pageID, bool isLiked, {int index = 0, bool isGoDetails = true}) async {
    ApiResponse response = await pageRepo.pageLikeUnlike(pageID.toString(), isLiked);
    if (response.response.statusCode == 200) {
      if (response.response.data['liked'] == true) {
        if (isGoDetails == true) {
          pageDetailsModel.totalLike = pageDetailsModel.totalLike! + 1;
          pageDetailsModel.totalFollower = pageDetailsModel.totalFollower! + 1;
          pageDetailsModel.isLiked = true;
        }

        if (isFromMyPage || isFromSuggestedPage || isFromSearchPage) {
          totalLikedPage += 1;
        }
      } else {
        if (isGoDetails == true) {
          pageDetailsModel.totalLike = pageDetailsModel.totalLike! - 1;
          pageDetailsModel.totalFollower = pageDetailsModel.totalFollower! - 1;
          pageDetailsModel.isLiked = false;
        }

        if (isFromMyPage || isFromSuggestedPage || isFromSearchPage) {
          totalLikedPage -= 1;
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

  bool statusInviteFriendButton = false;
  bool expandedYoursPages = false;
  bool adminAccessPage = false;
  bool allFollower = false;
  bool adminSectionAccess = false;
  bool moderatorSectionAccess = false;

  resetDashboardButton() {
    statusInviteFriendButton = false;
    expandedYoursPages = false;
    adminAccessPage = false;
    allFollower = false;
    adminSectionAccess = false;
    moderatorSectionAccess = false;
    isLoadingInviteFriend2 = false;
    notifyListeners();
  }

  changeModeratorSectionAccessExpanded() {
    moderatorSectionAccess = !moderatorSectionAccess;
    notifyListeners();
  }

  changeAllFollowerExpanded(String pageId) {
    allFollower = !allFollower;
    if (allFollower == true) {
      getAllFollowerList(pageId: pageId, isFirstTime: true, page: 1);
    }
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
    statusInviteFriendButton = !statusInviteFriendButton;
    if (statusInviteFriendButton == true) {
      callForGetInviteFriendLists(isFirstTime: false);
    }
    notifyListeners();
  }

  changeExpendedYourPages() {
    expandedYoursPages = !expandedYoursPages;
    notifyListeners();
  }

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

    ApiResponse response = await pageRepo.invitationFriend(selectPage);

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

    ApiResponse response = await pageRepo.invitationCreate(pageID, users);

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

  //TODO: GETTING ALL FOLLOWER LIST

  bool isBottomLoadingPageFollowerList = false;
  bool isPageFollowerList = false;
  bool hasNextDataPageFollowerList = false;
  List<Author> pageFollowersList = [];

  updateFollowerListPageNo() {
    selectPage++;
    getAllFollowerList(page: selectPage);
    notifyListeners();
  }

  getAllFollowerList({String pageId = "0", int page = 1, bool isFirstTime = true}) async {
    if (page == 1) {
      pageFollowersList.clear();
      pageFollowersList = [];
      isPageFollowerList = true;
      if (!isFirstTime) {
        notifyListeners();
      }
    } else {
      isBottomLoadingPageFollowerList = true;
      notifyListeners();
    }
    ApiResponse apiResponse = await pageRepo.getAllPageFolloweList(1, pageId);
    if (apiResponse.response.statusCode == 200) {
      isPageFollowerList = false;
      hasNextDataPageFollowerList = apiResponse.response.data['next'] != null ? true : false;
      apiResponse.response.data['results'].forEach((element) {
        pageFollowersList.add(Author.fromJson(element));
      });
      notifyListeners();
    } else {
      isPageFollowerList = false;
      notifyListeners();
      Fluttertoast.showToast(msg: apiResponse.response.statusMessage!);
    }
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

//TODO: page Photos api instigation
  List<ImagesData> pagePhotosModel = [];
  List<VideosData> videosLists = [];
  bool isPhotosLoading = true;

  pageAllPhotos() async {
    isPhotosLoading = true;
    pagePhotosModel.clear();
    pagePhotosModel = [];
    videosLists.clear();
    videosLists = [];
    ApiResponse response = await pageRepo.pageAllPhotosVideo(pageDetailsModel.photos!);
    if (response.response.statusCode == 200) {
      response.response.data.forEach((element) {
        pagePhotosModel.add(ImagesData.fromJson(element));
      });
      notifyListeners();
      ApiResponse response1 = await pageRepo.pageAllPhotosVideo(pageDetailsModel.videos!);
      isPhotosLoading = false;
      if (response1.response.statusCode == 200) {
        response1.response.data.forEach((element) {
          videosLists.add(VideosData.fromJson(element));
        });
      } else {
        Fluttertoast.showToast(msg: response1.response.statusMessage!);
      }
    } else {
      Fluttertoast.showToast(msg: response.response.statusMessage!);
    }
    isPhotosLoading = false;
    notifyListeners();
  }

//TODO: page Summery
  int totalLikedPage = 0;
  int totalInvitedPage = 0;

  pageSummery() async {
    ApiResponse response = await pageRepo.pageSummery();

    if (response.response.statusCode == 200) {
      totalLikedPage = response.response.data['total_liked_page'];
      totalInvitedPage = response.response.data['total_invited_page'];
    } else {
      Fluttertoast.showToast(msg: response.response.statusMessage!);
    }
    notifyListeners();
  }

//TODO: page Block And Unblock Systems
  List<AuthorPageModel> blockPageLists = [];
  int selectBlockPage = 0;
  bool isBottomLoadingBlockPage = false;
  bool isLoadingBlockPage = false;
  bool isLoadingBlockPage2 = false;
  bool hasNextDataBlockPage = false;

  updateBlockPageNo() {
    selectBlockPage++;
    callForGetPageBlockLists(page: selectBlockPage);
    notifyListeners();
  }

  callForGetPageBlockLists({int page = 1, bool isFirstTime = true}) async {
    if (page == 1) {
      selectBlockPage = 1;
      blockPageLists.clear();
      blockPageLists = [];
      isLoadingBlockPage = true;
      hasNextDataBlockPage = false;
      isBottomLoadingBlockPage = false;
      if (!isFirstTime) {
        notifyListeners();
      }
    } else {
      isBottomLoadingBlockPage = true;
      notifyListeners();
    }

    ApiResponse response = await pageRepo.pageBlockLists(selectPage);

    isLoadingBlockPage = false;
    isBottomLoadingBlockPage = false;
    if (response.response.statusCode == 200) {
      hasNextDataBlockPage = response.response.data['next'] != null ? true : false;
      response.response.data['results'].forEach((element) {
        blockPageLists.add(AuthorPageModel.fromJson(element));
      });
    } else {
      Fluttertoast.showToast(msg: response.response.statusMessage!);
    }
    notifyListeners();
  }

  Future<bool> createBlock(int pageID) async {
    isLoadingBlockPage2 = true;
    notifyListeners();
    ApiResponse response = await pageRepo.pageBlockCreate(pageID);
    isLoadingBlockPage2 = false;
    notifyListeners();
    if (response.response.statusCode == 200) {
      Fluttertoast.showToast(msg: 'Page Block added Successfully');
      return response.response.data['is_blocked'];
    } else {
      Fluttertoast.showToast(msg: response.response.statusMessage!);
      return false;
    }
  }

  createUnBlock(int pageID, int index) async {
    isLoadingBlockPage2 = true;
    notifyListeners();
    ApiResponse response = await pageRepo.pageUnBlockCreate(pageID);
    isLoadingBlockPage2 = false;
    if (response.response.statusCode == 200) {
      Fluttertoast.showToast(msg: 'Page UnBlock Successfully Complete');
      blockPageLists.removeAt(index);
    } else {
      Fluttertoast.showToast(msg: response.response.statusMessage!);
    }
    notifyListeners();
  }
}
