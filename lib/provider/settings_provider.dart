import 'package:als_frontend/data/model/response/settings/block_list_model.dart';
import 'package:als_frontend/data/model/response/settings/other_settings_model.dart';
import 'package:als_frontend/data/repository/settings_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_connect/http/src/response/response.dart';

class SettingsProvider extends ChangeNotifier {
  final SettingsRepo settingsRepo;

  SettingsProvider({required this.settingsRepo});

  bool darkModeOff = false;
  List<Result> blocklist = [];
  int position = 0;
  bool isBottomLoading = false;
  bool hasNextData = false;
  int selectPage = 1;
  String message = "";
  bool success = false;
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  Future passwordUpdate(String oldPassword, String newPassword, String confirmPassword) async {
    _isLoading = true;
    notifyListeners();
    Response response = await settingsRepo.passwordUpdate(oldPassword, newPassword, confirmPassword);
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
    initializeAllUserBlockData((bool status) {}, page: selectPage);
    notifyListeners();
  }

  initializeAllUserBlockData(Function callBackFunction, {int page = 1, bool isFirstTime = true}) async {
    if (page == 1) {
      selectPage = 1;
      blocklist.clear();
      blocklist = [];
      _isLoading = true;
      isBottomLoading = false;
      hasNextData = false;
      position = 0;

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
    callBackFunction(true);

    if (response.statusCode == 200) {
      hasNextData = response.body['next'] != null ? true : false;
      response.body['results'].forEach((element) {
        Result blocklist = Result.fromJson(element);
      });
    } else {
      Fluttertoast.showToast(msg: response.statusText!);
    }
    notifyListeners();
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
    }
    notifyListeners();
    Response response = await settingsRepo.updateOtherSettings(value, slNo);

    if (response.statusCode == 200) {
    } else {
      Fluttertoast.showToast(msg: response.statusText!);
    }
  }
}
