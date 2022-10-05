import 'dart:convert';

import 'package:als_frontend/data/datasource/remote/dio/dio_client.dart';
import 'package:als_frontend/data/datasource/remote/exception/api_error_handler.dart';
import 'package:als_frontend/data/model/response/base/api_response.dart';
import 'package:als_frontend/util/app_constant.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashRepo {
  final DioClient dioClient;
  final SharedPreferences sharedPreferences;

  SplashRepo({required this.dioClient, required this.sharedPreferences});

  Future<ApiResponse> getConfig() async {
    Response response = Response(requestOptions: RequestOptions(path: ''));
    try {
      response = await dioClient.get(AppConstant.configUri);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<bool> initSharedData() {
    if (!sharedPreferences.containsKey(AppConstant.theme)) {
      return sharedPreferences.setBool(AppConstant.theme, false);
    }
    return Future.value(true);
  }

  void saveTheme(bool isLight, Map<String, dynamic> data) {
    if (isLight) {
      sharedPreferences.setString(AppConstant.light, jsonEncode(data));
    } else {
      sharedPreferences.setString(AppConstant.dark, jsonEncode(data));
    }
  }

  void saveVariantID(int variant) async {
    sharedPreferences.setInt(AppConstant.variant, variant);
  }

  int getVariant() {
    return sharedPreferences.getInt(AppConstant.variant) ?? 0;
  }

  bool getThemeCondition() {
    return sharedPreferences.getBool(AppConstant.theme) ?? false;
  }

  Map<String, dynamic> getTheme(bool isLight) {
    return jsonDecode(sharedPreferences.getString(isLight ? AppConstant.light : AppConstant.dark) ?? "");
  }
}
