import 'dart:io';

import 'package:als_frontend/data/model/response/settings/block_list_model.dart';
import 'package:als_frontend/data/model/response/settings/notification_model.dart';
import 'package:als_frontend/data/model/response/settings/other_settings_model.dart';
import 'package:als_frontend/data/model/response/settings/privcay_model.dart';
import 'package:als_frontend/data/repository/settings_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_connect/http/src/response/response.dart';

class SettingsProvider extends ChangeNotifier {
  final SettingsRepo settingsRepo;

  SettingsProvider({required this.settingsRepo});

  int selectPage = 1;
  bool success = false;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future passwordUpdate(String oldPassword, String newPassword, String confirmPassword) async {
    _isLoading = true;
    notifyListeners();
    Response response =
        await settingsRepo.passwordUpdate(oldPassword, newPassword, confirmPassword);
    if (response.statusCode == 200) {
      success = true;
      notifyListeners();
    } else {
      Fluttertoast.showToast(msg: response.statusText!);
    }
  }

  Future emailUpdate(String oldMail, String newMail, String confirmPassword) async {
    _isLoading = true;
    notifyListeners();
    Response response = await settingsRepo.emailUpdate(oldMail, newMail, confirmPassword);
    if (response.statusCode == 200) {
      success = true;
      notifyListeners();
    } else {
      Fluttertoast.showToast(msg: response.statusText!);
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

    Response response = await settingsRepo.blockList(page);
    _isLoading = false;
    isBottomLoading = false;
    if (response.statusCode == 200) {
      hasNextData = response.body['next'] != null ? true : false;
      response.body['results'].forEach((element) {
        blocklist.add(Result.fromJson(element));
      });
    } else {
      Fluttertoast.showToast(msg: response.statusText!);
    }
    notifyListeners();
  }

  // TODO: for Unblock section
  bool isUnblockLoading = false;

  unblockUser(int userID, int index) async {
    isUnblockLoading = true;
    notifyListeners();
    Response response = await settingsRepo.unBlockUser(userID);
    isUnblockLoading = false;
    if (response.statusCode == 200) {
      blocklist.removeAt(index);
    } else {
      Fluttertoast.showToast(msg: response.statusText!);
    }
    notifyListeners();
  }

  NotificationSettingsModel? notificationModel = NotificationSettingsModel();

  initializeNotificationSettingsValue() async {
    _isLoading = true;
    notificationModel = NotificationSettingsModel();
    Response response = await settingsRepo.notificationValue();
    _isLoading = false;
    if (response.statusCode == 200) {
      notificationModel = NotificationSettingsModel.fromJson(response.body);
    } else {
      Fluttertoast.showToast(msg: response.statusText!);
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
    Response response = await settingsRepo.updateOtherSettings(value, slNo);

    if (response.statusCode == 200) {
    } else {
      Fluttertoast.showToast(msg: response.statusText!);
    }
  }

  OtherSettingsModel? otherSettingsValue = OtherSettingsModel();

  initializeOtherSettingsValue() async {
    _isLoading = true;
    otherSettingsValue = OtherSettingsModel();
    Response response = await settingsRepo.otherSettingsValue();
    _isLoading = false;
    if (response.statusCode == 200) {
      otherSettingsValue = OtherSettingsModel.fromJson(response.body);
    } else {
      Fluttertoast.showToast(msg: response.statusText!);
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
    Response response = await settingsRepo.updateOtherSettings(value, slNo);

    if (response.statusCode == 200) {
    } else {
      Fluttertoast.showToast(msg: response.statusText!);
    }
  }

// TODO: for terms & section
  List<PrivacyPolicyModel> privacyPolicyModel = [];

  initializeTermsAndCondition() async {
    _isLoading = true;
    privacyPolicyModel.clear();
    privacyPolicyModel = [];
    Response response = await settingsRepo.termsAndCondition();
    _isLoading = false;
    if (response.statusCode == 200) {
      response.body.forEach((element) {
        privacyPolicyModel.add(PrivacyPolicyModel.fromJson(element));
      });
    } else {
      Fluttertoast.showToast(msg: response.statusText!);
    }
    notifyListeners();
  }

  //TODO: for add problems
  Future<bool> addMessageOnHelpDesk(String message, File problemsScreenshots) async {
    _isLoading = true;
    notifyListeners();
    Response response = await settingsRepo.addHelpDisk(message, problemsScreenshots);
    _isLoading = false;
    notifyListeners();
    if (response.statusCode == 200) {
      return true;
    } else {
      Fluttertoast.showToast(msg: response.statusText!);
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
  bool indexValue = false;
  int oldIndex = -1;

  updateSingleItem(int currentClick){
    oldIndex = currentClick;
    indexValue = true;
    notifyListeners();
  }


  // changeIndexValue(int currentClick) {
  //   oldIndex == currentClick;
  //   if (indexValue == false) {
  //     indexValue = true;
  //   } else {
  //     indexValue = false;
  //   }
  //   notifyListeners();
  // }
}
