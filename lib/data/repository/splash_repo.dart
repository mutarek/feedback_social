import 'dart:convert';
import 'package:als_frontend/util/app_constant.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashRepo {
  final SharedPreferences sharedPreferences;

  SplashRepo({required this.sharedPreferences});
  //
  // Future<ApiResponse> getConfig() async {
  //   Response response = Response(requestOptions: RequestOptions(path: ''));
  //   try {
  //     response = await dioClient.get(AppConstant.configUri);
  //     return ApiResponse.withSuccess(response);
  //   } catch (e) {
  //     return ApiResponse.withError(ApiErrorHandler.getMessage(e));
  //   }
  // }

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

  bool getThemeCondition() {
    return sharedPreferences.getBool(AppConstant.theme) ?? false;
  }

  Map<String, dynamic> getTheme(bool isLight) {
    return jsonDecode(sharedPreferences.getString(isLight ? AppConstant.light : AppConstant.dark) ?? "");
  }
}
