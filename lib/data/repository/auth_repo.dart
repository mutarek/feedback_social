import 'package:als_frontend/data/datasource/api_client.dart';
import 'package:als_frontend/util/app_constant.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  AuthRepo({required this.sharedPreferences, required this.apiClient});

  //
  // Future<ApiResponse> signUp(String firstName, String lastName, String phone, String email, String password) async {
  //   Response response = Response(requestOptions: RequestOptions(path: '22222'));
  //   try {
  //     response = await dioClient.post('${AppConstant.baseUrl}${AppConstant.signUPURI}', data: {
  //       "password": password,
  //       "email": email,
  //       "firstname": firstName,
  //       "lastname": lastName,
  //       "age": "0",
  //       "phone": phone,
  //       "fax": phone,
  //       "currencyID": 0,
  //       "pushNotifications": true,
  //       "website": "string",
  //       "mobile": phone,
  //       "secondMobile": phone,
  //       "darkMode": true,
  //       "disable": false
  //     });
  //     return ApiResponse.withSuccess(response);
  //   } catch (e) {
  //     return ApiResponse.withError(ApiErrorHandler.getMessage(e));
  //   }
  // }

  Future<Response> login(String email, String password) async {
    return await apiClient.postData(AppConstant.loginURI, {'email': email, 'password': password},
        headers: {'Content-Type': 'application/json; charset=UTF-8'});
  }

  //
  // Future<ApiResponse> signIn(String email, String password) async {
  //   Response response = Response(requestOptions: RequestOptions(path: '22222'));
  //   try {
  //     response = await dioClient.post(AppConstant.loginURI, data: {'email': email, 'password': password});
  //     return ApiResponse.withSuccess(response);
  //   } catch (e) {
  //     print('apap ${e.toString()}');
  //     return ApiResponse.withError(
  //       ApiErrorHandler.getMessage(e),
  //     );
  //   }
  // }
  //
  // Future<ApiResponse> forgotPassword(String emailAddress) async {
  //   Response response = Response(requestOptions: RequestOptions(path: '22222'));
  //   try {
  //     response = await dioClient.post(AppConstant.forgotPasswordURI, data: {"email": emailAddress});
  //     return ApiResponse.withSuccess(response);
  //   } catch (e) {
  //     return ApiResponse.withError(ApiErrorHandler.getMessage(e));
  //   }
  // }
  //
  // Future<ApiResponse> guestLogin() async {
  //   Response response = Response(requestOptions: RequestOptions(path: '22222'));
  //   try {
  //     response = await dioClient.post('${AppConstant.baseUrl}${AppConstant.guestLoginURI}');
  //     return ApiResponse.withSuccess(response);
  //   } catch (e) {
  //     return ApiResponse.withError(ApiErrorHandler.getMessage(e));
  //   }
  // }

  //TODO: for save User Information
  Future<void> saveUserInformation(String userID, String name, String image, String code, String email) async {
    try {
      await sharedPreferences.setString(AppConstant.userID, userID);
      await sharedPreferences.setString(AppConstant.userEmail, email);
      await sharedPreferences.setString(AppConstant.usercode, code);
      await sharedPreferences.setString(AppConstant.userName, name);
      await sharedPreferences.setString(AppConstant.userProfileImage, image);
    } catch (e) {
      rethrow;
    }
  }

  //TODO:: for get User Information
  String getUserID() {
    return sharedPreferences.getString(AppConstant.userID) ?? "";
  }

  String getUserName() {
    return sharedPreferences.getString(AppConstant.userName) ?? "";
  }

  String getUserEmail() {
    return sharedPreferences.getString(AppConstant.userEmail) ?? "";
  }

  String getUserCode() {
    return sharedPreferences.getString(AppConstant.usercode) ?? "";
  }

  String getUserProfile() {
    return sharedPreferences.getString(AppConstant.userProfileImage) ?? "";
  }

  // TODO; clear all user Information
  Future<bool> clearUserInformation() async {
    await sharedPreferences.remove(AppConstant.userID);
    await sharedPreferences.remove(AppConstant.userName);
    await sharedPreferences.remove(AppConstant.userEmail);
    await sharedPreferences.remove(AppConstant.usercode);
    return await sharedPreferences.remove(AppConstant.userProfileImage);
  }

  // for  user token
  Future<void> saveUserToken(String token) async {
    // dioClient.token = token;
    // dioClient.dio!.options.headers = {'Content-Type': 'application/json', 'Authorization': 'Bearer $token'};

    try {
      await sharedPreferences.setString(AppConstant.token, token);
    } catch (e) {
      rethrow;
    }
  }

  bool checkTokenExist() {
    return sharedPreferences.containsKey(AppConstant.token);
  }

  String getUserToken() {
    return sharedPreferences.getString(AppConstant.token) ?? "";
  }

  bool isLoggedIn() {
    return sharedPreferences.containsKey(AppConstant.token);
  }

  Future<bool> clearToken() async {
    return sharedPreferences.remove(AppConstant.token);
  }
}
