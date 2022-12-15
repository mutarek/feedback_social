import 'dart:io';

import 'package:als_frontend/data/model/response/base/api_response.dart';
import 'package:als_frontend/data/model/response/settings/block_list_model.dart';
import 'package:als_frontend/data/model/response/settings/faq_model.dart';
import 'package:als_frontend/data/model/response/settings/notification_model.dart';
import 'package:als_frontend/data/model/response/settings/other_settings_model.dart';
import 'package:als_frontend/data/repository/settings_repo.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../data/model/response/settings/privcay_model.dart';

class SettingsProvider with ChangeNotifier{
  final SettingsRepo settingsRepo;

  SettingsProvider({required this.settingsRepo});

  int selectPage = 1;
  bool success = false;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future passwordUpdate(String oldPassword, String newPassword, String confirmPassword) async {
    _isLoading = true;
    notifyListeners();
    ApiResponse response = await settingsRepo.passwordUpdate(oldPassword, newPassword, confirmPassword);
    if (response.response.statusCode == 200) {
      success = true;
      notifyListeners();
    } else {
      Fluttertoast.showToast(msg: response.response.statusMessage!);
    }
  }

  Future emailUpdate(String oldMail, String newMail, String confirmPassword) async {
    _isLoading = true;
    notifyListeners();
    ApiResponse response = await settingsRepo.emailUpdate(oldMail, newMail, confirmPassword);
    if (response.response.statusCode == 200) {
      success = true;
      notifyListeners();
    } else {
      Fluttertoast.showToast(msg: response.response.statusMessage!);
    }
  }

  updatePageNo() {
    selectPage++;
    initializeAllUserBlockData(page: selectPage);
    notifyListeners();
  }

  /////TODO: for block list
  List<Result> blocklist = [];
  bool isBottomLoading = false;
  bool hasNextData = false;

  initializeAllUserBlockData({int page = 1, bool isFirstTime = true}) async {
    if (page == 1) {
      selectPage = 1;
      blocklist.clear();
      blocklist = [];
      _isLoading = true;
      isBottomLoading = false;
      hasNextData = false;
      if (!isFirstTime) {
        notifyListeners();
      }
    } else {
      isBottomLoading = true;
      notifyListeners();
    }

    ApiResponse response = await settingsRepo.blockList(page);
    _isLoading = false;
    isBottomLoading = false;
    if (response.response.statusCode == 200) {
      hasNextData = response.response.data['next'] != null ? true : false;
      response.response.data['results'].forEach((element) {
        blocklist.add(Result.fromJson(element));
      });
    } else {
      Fluttertoast.showToast(msg: response.response.statusMessage!);
    }
    notifyListeners();
  }

  // TODO: for Unblock section
  bool isUnblockLoading = false;

  unblockUser(int userID, int index) async {
    isUnblockLoading = true;
    notifyListeners();
    ApiResponse response = await settingsRepo.unBlockUser(userID);
    isUnblockLoading = false;
    if (response.response.statusCode == 200) {
      blocklist.removeAt(index);
    } else {
      Fluttertoast.showToast(msg: response.response.statusMessage!);
    }
    notifyListeners();
  }

  NotificationSettingsModel? notificationModel = NotificationSettingsModel();

  initializeNotificationSettingsValue() async {
    _isLoading = true;
    notificationModel = NotificationSettingsModel();
    ApiResponse response = await settingsRepo.notificationValue();
    _isLoading = false;
    if (response.response.statusCode == 200) {
      notificationModel = NotificationSettingsModel.fromJson(response.response.data);
    } else {
      Fluttertoast.showToast(msg: response.response.statusMessage!);
    }
    notifyListeners();
  }

  changeNotificationSettingsStatus(bool value, int slNo) async {
    switch (slNo) {
      case 0:
        notificationModel!.isPush = value;
        break;
      case 1:
        notificationModel!.isFriend = value;
        break;
      case 2:
        notificationModel!.isFollower = value;
        break;
      case 3:
        notificationModel!.isFollowing = value;
        break;
      case 4:
        notificationModel!.isLike = value;
        break;
      case 5:
        notificationModel!.isComment = value;
        break;
      case 6:
        notificationModel!.isShare = value;
        break;
    }
    notifyListeners();
    ApiResponse response = await settingsRepo.updateOtherSettings(value, slNo);

    if (response.response.statusCode == 200) {
    } else {
      Fluttertoast.showToast(msg: response.response.statusMessage!);
    }
  }

  OtherSettingsModel? otherSettingsValue = OtherSettingsModel();

  initializeOtherSettingsValue() async {
    _isLoading = true;
    otherSettingsValue = OtherSettingsModel();
    ApiResponse response = await settingsRepo.otherSettingsValue();
    _isLoading = false;
    if (response.response.statusCode == 200) {
      otherSettingsValue = OtherSettingsModel.fromJson(response.response.data);
    } else {
      Fluttertoast.showToast(msg: response.response.statusMessage!);
    }
    notifyListeners();
  }

  bool darkModeOff = false;

  changeDarkModeStatus(bool value) {
    darkModeOff = value;
    notifyListeners();
  }

  changeOtherSettingsStatus(bool value, int slNo) async {
    switch (slNo) {
      case 0:
        otherSettingsValue!.isAnyoneTag = value;
        break;
      case 1:
        otherSettingsValue!.isFollowerTag = value;
        break;
      case 2:
        otherSettingsValue!.isFollowingTag = value;
        break;
      case 3:
        otherSettingsValue!.isAnyoneShare = value;
        break;
      case 4:
        otherSettingsValue!.isFollowerShare = value;
        break;
      case 5:
        otherSettingsValue!.isFollowingShare = value;
        break;
      case 6:
        otherSettingsValue!.isAnyoneMessage = value;
        break;
      case 7:
        otherSettingsValue!.isFollowerMessage = value;
        break;
      case 8:
        otherSettingsValue!.isFollowingMessage = value;
        break;
    }
    notifyListeners();
    ApiResponse response = await settingsRepo.updateOtherSettings(value, slNo);

    if (response.response.statusCode == 200) {
    } else {
      Fluttertoast.showToast(msg: response.response.statusMessage!);
    }
  }

  // TODO: for terms & section
  List<PrivacyPolicyModel> privacyPolicyModel = [];

  initializeTermsAndCondition() async {
    _isLoading = true;
    privacyPolicyModel.clear();
    privacyPolicyModel = [];
    ApiResponse response = await settingsRepo.termsAndCondition();
    _isLoading = false;
    if (response.response.statusCode == 200) {
      response.response.data.forEach((element) {
        privacyPolicyModel.add(PrivacyPolicyModel.fromJson(element));
      });
    } else {
      Fluttertoast.showToast(msg: response.response.statusMessage!);
    }
    notifyListeners();
  }

  //TODO: for add problems
  Future<bool> addMessageOnHelpDesk(String message, File problemsScreenshots) async {
    _isLoading = true;
    notifyListeners();
    ApiResponse response = await settingsRepo.addHelpDisk(message, problemsScreenshots);
    _isLoading = false;
    notifyListeners();
    if (response.response.statusCode == 200) {
      return true;
    } else {
      Fluttertoast.showToast(msg: response.response.statusMessage!);
      return false;
    }
  }

  //TODO for menu value
  int menuValue = 0;

  changeMenuValue(int value) {
    menuValue = value;
    notifyListeners();
  }

  //TODO for index value

  int oldIndex = -1;

  updateSingleItem(int currentClick) {
    if (oldIndex == currentClick) {
      oldIndex = -1;
    } else {
      oldIndex = currentClick;
    }
    notifyListeners();
  }

  ////TODO: for faq question list
  List<FaqModel> faqLists = [];
  List<FaqModel> faqListTemp = [];

  initializeFaqQuestion() async {
    _isLoading = true;
    faqLists.clear();
    faqLists = [];
    faqListTemp.clear();
    faqListTemp = [];
    ApiResponse response = await settingsRepo.faqQuestionDataGet();
    _isLoading = false;
    if (response.response.statusCode == 200) {
      response.response.data.forEach((element) {
        faqLists.add(FaqModel.fromJson(element));
      });
      faqListTemp.addAll(faqLists);
    } else {
      Fluttertoast.showToast(msg: response.response
      .statusMessage!);
    }
    notifyListeners();
  }

////TODO: for faq question list scarch

  initializeSearch(String query) {
    faqLists.clear();
    faqLists = [];
    if (query.isEmpty) {
      faqLists.addAll(faqListTemp);
    } else {
      for (var element in faqListTemp) {
        if (element.question!.toLowerCase().contains(query.toLowerCase())) {
          faqLists.add(element);
        }
      }
    }
    notifyListeners();
  }

}