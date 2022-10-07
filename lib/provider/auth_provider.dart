
import 'package:als_frontend/data/repository/auth_repo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  final AuthRepo authRepo;
  final SharedPreferences sharedPreferences;

  AuthProvider({required this.authRepo, required this.sharedPreferences});

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  // for Sign in Section

  Future signIn(String email, String password, bool isRemember, Function callback) async {
    _isLoading = true;
    notifyListeners();
    Response response = await authRepo.login(email, password);
    _isLoading = false;

    // if (isRemember==true) {
    //   authRepo.saveUserEmailAndPassword(email, password);
    // } else {
    //   authRepo.clearUserEmailAndPassword();
    // }

    if (response.statusCode == 200) {
      if (authRepo.checkTokenExist()) {
        authRepo.clearUserInformation();
        authRepo.clearToken();
      }
      authRepo.saveUserToken(response.body['token'].toString());
      authRepo.saveUserInformation(
          response.body['id'].toString(),
          '${response.body['first_name']} ${response.body['last_name']}',
          '${response.body['profile_image']}',
          '${response.body['code']}',
          '${response.body['email']}');
      callback(true, 'Login Successfully');
    } else {
      print('khan ${response.statusText}');
      callback(false, response.statusText);
    }
    notifyListeners();
  }

// // for Guest  Section
//
// Future guestLogin(Function callback) async {
//   _isLoading = true;
//   notifyListeners();
//   ApiResponse apiResponse = await authRepo.guestLogin();
//   _isLoading = false;
//
//   if (apiResponse.response.statusCode == 200) {
//     print(apiResponse.response.data.toString());
//     callback(true, 'Guest Login successfully!');
//     if (authRepo.checkTokenExist()) {
//       clear();
//     }
//     authRepo.saveUserToken(apiResponse.response.data['value']['accessToken']);
//   } else {
//     callback(false, '${apiResponse.error.toString()}');
//   }
//   notifyListeners();
// }
//
// // for Forgot Password  Section
// bool isForgotPasswordLoading = false;
//
// Future forgotPassword(String email, Function callback) async {
//   isForgotPasswordLoading = true;
//   notifyListeners();
//   ApiResponse apiResponse = await authRepo.forgotPassword(email);
//   isForgotPasswordLoading = false;
//   if (apiResponse.response.statusCode == 200 || apiResponse.response.statusCode == 201) {
//     callback(true, apiResponse.response.data['message']);
//   } else {
//     if (apiResponse.error.toString() == "Connection to API server failed due to internet connection") {
//       callback(true, 'Please Check your mail Address');
//     } else {
//       callback(false, '${apiResponse.error.toString()}');
//     }
//   }
//   notifyListeners();
// }
//
// // for sign up section
//
// Future signUP(String firstName, String lastName, String phone, String email, String password, Function callback) async {
//   _isLoading = true;
//   notifyListeners();
//   ApiResponse apiResponse = await authRepo.signUp(firstName, lastName, phone, email, password);
//   _isLoading = false;
//
//   if (apiResponse.response.statusCode == 200) {
//     print(apiResponse.response.data.toString());
//     callback(true, '${apiResponse.response.data['message']}');
//     if (authRepo.checkTokenExist()) {
//       clear();
//
//     } else {
//
//     }
//     authRepo.addUser(User.fromJson(apiResponse.response.data['value']));
//     authRepo.saveUserToken(apiResponse.response.data['value']['accessToken']);
//     authRepo.saveUserID(apiResponse.response.data['value']['userId']);
//     authRepo.saveCustomerID(apiResponse.response.data['value']['userInfoId']);
//     // authRepo.saveUserRoleID(userDataModel.success!.user.roleId);
//     authRepo.saveUserNAME(apiResponse.response.data['value']['username']);
//     authRepo.clearFirstName();
//     authRepo.saveFirstName(apiResponse.response.data['value']['firstname']);
//     authRepo.saveUserEmail(apiResponse.response.data['value']['email']);
//   } else {
//     callback(false, '${apiResponse.error.toString()}');
//   }
//   notifyListeners();
// }
//
// // check User Roll
// bool isExistUserRoll() {
//   return sharedPreferences.containsKey(AppConstant.token) ? true : false;
// }
//
// int getUserID() {
//   return authRepo.getUserID();
// }
//
// int getCustomerID() {
//   return authRepo.getCustomerID();
// }
//
// // for Remember Me Section
//
// bool _isActiveRememberMe = false;
//
// bool get isActiveRememberMe => _isActiveRememberMe;
//
// toggleRememberMe() {
//   _isActiveRememberMe = !_isActiveRememberMe;
//   notifyListeners();
// }
//
// void saveUserEmailAndPassword(String email, String password) {
//   authRepo.saveUserEmailAndPassword(email, password);
// }
//
// String getUserEmail() {
//   return authRepo.getUserEmail();
// }
// String getFirstName() {
//   return authRepo.getFirstName();
// }
//
// Future<bool> clearUserEmailAndPassword() async {
//   return authRepo.clearUserEmailAndPassword();
// }
//
// String getUserPassword() {
//   return authRepo.getUserPassword();
// }
//
// // for user Section
// String getUserToken() {
//   return authRepo.getUserToken();
// }
//
// // for UserName
// String getUserName() {
//   return authRepo.getUserNAME();
// }
//
// // for Email
// String getEmail2() {
//   return authRepo.getUserEmail2();
// }
//
// bool isLoggedIn() {
//   return authRepo.isLoggedIn();
// }
//
// clear(){
//   clearCustomerID();
//   clearUserID();
//   clearSharedData();
// }
// clearSharedData() async {
//   if(authRepo.isLoggedIn())
//   await authRepo.clearToken();
// }
//
// clearUserID() async {
//   if(authRepo.isExistsCustomerID())
//   await authRepo.clearUserID();
// }
//
// clearCustomerID() async {
//   if(authRepo.isExistsCustomerID())
//   await authRepo.clearCustomerID();
// }
//
// // for country code
// List<CountryCodeModel> countryCodes = [];
// late CountryCodeModel selectCountryCodes;
//
// initCountryCodes() async {
//   if (countryCodes.length == 0) {
//     countryCodes.clear();
//     countryCodes = [];
//     countryCodeJson.forEach((element) {
//       countryCodes.add(CountryCodeModel.fromJson(element));
//     });
//     countryCodes.sort((a, b) => a.dialCode.compareTo(b.dialCode));
//     selectCountryCodes = countryCodes[96];
//   }
// }
//
// changeCountryCodes(CountryCodeModel values) async {
//   selectCountryCodes = values;
//   notifyListeners();
// }
//
// // get User
// User user() {
//   return authRepo.getUser();
// }
}
