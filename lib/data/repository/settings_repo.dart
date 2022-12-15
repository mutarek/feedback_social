import 'dart:io';

import 'package:als_frontend/data/datasource/remote/dio/dio_client.dart';
import 'package:als_frontend/data/datasource/remote/exception/api_error_handler.dart';
import 'package:als_frontend/data/model/response/base/api_response.dart';
import 'package:als_frontend/data/repository/auth_repo.dart';
import 'package:als_frontend/util/app_constant.dart';
import 'package:dio/dio.dart';

class SettingsRepo{
  final DioClient dioClient;
  final AuthRepo authRepo;

  SettingsRepo({required this.dioClient,required this.authRepo});

  Future<ApiResponse> passwordUpdate(String oldPassword, String newPassword, String confirmPassword) async {
    Response response = Response(requestOptions: RequestOptions(path: '22222'));
    try {
      response = await dioClient.put(AppConstant.passwordUpdate,data:{"old_password": oldPassword, "new_password": newPassword, "confirm_password": confirmPassword} );
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> emailUpdate(String oldMail, String newMail, String confirmPassword) async {
    Response response = Response(requestOptions: RequestOptions(path: '22222'));
    try {
      response = await dioClient.put(AppConstant.emailUpdate,data: {"old_email": oldMail, "new_email": newMail, "password": confirmPassword});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> blockList(int page) async {
    Response response = Response(requestOptions: RequestOptions(path: '22222'));
    try {
      response = await dioClient.get("${AppConstant.blocklist}?page=$page");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> unBlockUser(int userID) async {
    Response response = Response(requestOptions: RequestOptions(path: '22222'));
    try {
      response = await dioClient.delete("/settings/block/$userID/delete/");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> notificationValue() async {
    Response response = Response(requestOptions: RequestOptions(path: '22222'));
    try {
      response = await dioClient.get(AppConstant.getNotificationSettingsValueUri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> updateOtherSettings(bool status, int slNo) async {
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
    Response response = Response(requestOptions: RequestOptions(path: '22222'));
    try {
      response = await dioClient.patch(AppConstant.getOtherSettingsValue,data: map);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> otherSettingsValue() async {
    Response response = Response(requestOptions: RequestOptions(path: '22222'));
    try {
      response = await dioClient.get(AppConstant.getOtherSettingsValue);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> updateNotificationSettings(bool status, int slNo) async {
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
    Response response = Response(requestOptions: RequestOptions(path: '22222'));
    try {
      response = await dioClient.patch(AppConstant.getNotificationSettingsValueUri,data: map);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> termsAndCondition() async {
    Response response = Response(requestOptions: RequestOptions(path: '22222'));
    try {
      response = await dioClient.patch(AppConstant.termsAndConditionUri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }
  ///TODO: Faq question list get
  Future<ApiResponse> faqQuestionDataGet() async {
    Response response = Response(requestOptions: RequestOptions(path: '22222'));
    try {
      response = await dioClient.get(AppConstant.faqQuestionUri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> addHelpDisk(String message, File problemsScreenshots) async {
    Response response = Response(requestOptions: RequestOptions(path: '22222'));
    try {
      FormData formData = FormData();
      formData.fields.add(MapEntry('text',message));
      formData.files.add(MapEntry(
          'image',
          MultipartFile(problemsScreenshots.readAsBytes().asStream(), problemsScreenshots.lengthSync(),
              filename: problemsScreenshots.path.split("/").last)));
      response = await dioClient.post(AppConstant.helpDiskURI,data: formData);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }
}