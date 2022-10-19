import 'package:als_frontend/data/datasource/api_client.dart';
import 'package:als_frontend/util/app_constant.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepo {
  final ApiClient apiClient;
  final SharedPreferences sharedPreferences;

  AuthRepo({required this.sharedPreferences, required this.apiClient});

  Future<Response> login(String email, String password) async {
    return await apiClient.postData(AppConstant.loginURI, {'email': email, 'password': password});
  }

  Future<Response> signup(String firstName, String lastName, String dob, String gender, String email, String password) async {
    return await apiClient.postData(AppConstant.signupURI,
        {"first_name": firstName, "last_name": lastName, "email": email, "password": password, "date_of_birth": dob, "gender": gender},
        headers: {'Content-Type': 'application/json; charset=UTF-8'});
  }

  Future<Response> otpSend(String emailOrPhone, bool isEmail) async {
    Map map = {};
    if (isEmail) {
      map = {"email": emailOrPhone};
    } else {
      map = {"phone": emailOrPhone};
    }
    return await apiClient.postData(AppConstant.otpSendURI, map, headers: {'Content-Type': 'application/json; charset=UTF-8'});
  }

  Future<Response> otpVerify(String emailOrPhone, String code, bool isEmail) async {
    Map map = {};
    if (isEmail) {
      map = {"email": emailOrPhone, "code": code};
    } else {
      map = {"phone": emailOrPhone, "code": code};
    }
    return await apiClient.postData(AppConstant.otpVerifyURI, map, headers: {'Content-Type': 'application/json; charset=UTF-8'});
  }

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

  Future<void> changeUserImage(String image) async {
    try {
      await sharedPreferences.setString(AppConstant.userProfileImage, image);
    } catch (e) {
      rethrow;
    }
  }
  Future<void> changeUserName(String value) async {
    try {
      await sharedPreferences.setString(AppConstant.userName, value);
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
    try {
      apiClient.token = token;
      apiClient.updateHeader(token);
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
