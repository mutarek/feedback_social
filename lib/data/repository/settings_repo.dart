import 'dart:io';
import 'package:http/http.dart' as http;

import 'package:als_frontend/data/datasource/api_client.dart';
import 'package:als_frontend/util/app_constant.dart';
import 'package:get/get_connect/http/src/response/response.dart';

class SettingsRepo {
  final ApiClient apiClient;

  SettingsRepo({required this.apiClient});

  Future<Response> passwordUpdate(String oldPassword, String newPassword, String confirmPassword) async {
    return await apiClient.putData(
        AppConstant.passwordUpdate, {"old_password": oldPassword, "new_password": newPassword, "confirm_password": confirmPassword});
  }

  Future<Response> emailUpdate(String oldMail, String newMail, String confirmPassword) async {
    return await apiClient.putData(AppConstant.emailUpdate, {"old_email": oldMail, "new_email": newMail, "password": confirmPassword});
  }

  Future<Response> blockList(int page) async {
    return await apiClient.getData(AppConstant.blocklist + "?page=$page");
  }

  Future<Response> unBlockUser(int userID) async {
    return await apiClient.deleteData("/settings/block/$userID/delete/");
  }

  Future<Response> notificationValue() async {
    return await apiClient.getData(AppConstant.getNotificationSettingsValueUri);
  }

  Future<Response> updateOtherSettings(bool status, int slNo) async {
    Map map = {};
    switch (slNo) {
      case 0:
        map['is_anyone_tag'] = status;
        break;
      case 1:
        map['is_follower_tag'] = status;
        break;
      case 2:
        map['is_following_tag'] = status;
        break;
      case 3:
        map['is_anyone_share'] = status;
        break;
      case 4:
        map['is_follower_share'] = status;
        break;
      case 5:
        map['is_following_share'] = status;
        break;
      case 6:
        map['is_anyone_message'] = status;
        break;
      case 7:
        map['is_follower_message'] = status;
        break;
      case 8:
        map['is_following_message'] = status;
        break;
    }
    return await apiClient.patchData(AppConstant.getOtherSettingsValue, map);
  }

  Future<Response> otherSettingsValue() async {
    return await apiClient.getData(AppConstant.getOtherSettingsValue);
  }

  Future<Response> updateNotificationSettings(bool status, int slNo) async {
    Map map = {};
    switch (slNo) {
      case 0:
        map['is_push'] = status;
        break;
      case 1:
        map['is_friend'] = status;
        break;
      case 2:
        map['is_follower'] = status;
        break;
      case 3:
        map['is_following'] = status;
        break;
      case 4:
        map['is_like'] = status;
        break;
      case 5:
        map['is_comment'] = status;
        break;
      case 6:
        map['is_share'] = status;
        break;
    }
    return await apiClient.patchData(AppConstant.getNotificationSettingsValueUri, map);
  }

  Future<Response> termsAndCondition() async {
    return await apiClient.getData(AppConstant.termsAndConditionUri);
  }

  Future<Response> addHelpDisk(String message, File problemsScreenshots) async {
    http.MultipartFile multipartFile = http.MultipartFile(
        'image', problemsScreenshots.readAsBytes().asStream(), problemsScreenshots.lengthSync(),
        filename: problemsScreenshots.path.split("/").last);
    return await apiClient.putMultipartData(AppConstant.helpDiskURI, {"text": message}, [multipartFile]);
  }
}
