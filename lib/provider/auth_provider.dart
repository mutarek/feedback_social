import 'dart:async';

import 'package:als_frontend/data/repository/auth_repo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_connect/http/src/response/response.dart';

class CallBackResponse {
  bool status;
  String message;

  CallBackResponse({this.status = false, this.message = ''});
}

class AuthProvider with ChangeNotifier {
  final AuthRepo authRepo;

  AuthProvider({required this.authRepo});

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  //TODO:: for Sign Up Section

  Future signup(String firstName, String lastName, String password, Function callback) async {
    _isLoading = true;
    notifyListeners();
    String gender = '';
    if (genderLists[0] == selectGender) {
      gender = 'M';
    } else if (genderLists[1] == selectGender) {
      gender = 'F';
    } else {
      gender = '0';
    }
    Response response = await authRepo.signup(firstName, lastName, buttonText, gender, data, password);
    _isLoading = false;
    if (response.statusCode == 201) {
      if (authRepo.checkTokenExist()) {
        authRepo.clearUserInformation();
        authRepo.clearToken();
      }
      authRepo.saveUserToken(response.body['token'].toString());
      authRepo.saveUserInformation(response.body['id'].toString(), '${response.body['first_name']} ${response.body['last_name']}',
          '${response.body['profile_image']}', '${response.body['code']}', '${response.body['email']}');
      callback(true, 'Signup Successfully');
    } else {
      callback(false, response.statusText);
    }
    notifyListeners();
  }

  //TODO:: for Sign in Section

  Future<CallBackResponse> signIn(String email, String password) async {
    _isLoading = true;
    notifyListeners();
    Response response = await authRepo.login(email, password);
    _isLoading = false;

    if (response.statusCode == 200) {
      if (authRepo.checkTokenExist()) {
        authRepo.clearUserInformation();
        authRepo.clearToken();
      }
      authRepo.saveUserToken(response.body['token'].toString());
      authRepo.saveUserInformation(response.body['id'].toString(), '${response.body['first_name']} ${response.body['last_name']}',
          '${response.body['profile_image']}', '${response.body['code']}', '${response.body['email']}');
      name = '${response.body['first_name']} ${response.body['last_name']}';
      userID = '${response.body['id']}';
      userCode = '${response.body['code']}';
      profileImage = '${response.body['profile_image']}';
      notifyListeners();
      return CallBackResponse(status: true, message: 'Login Successfully');
    } else {
      notifyListeners();
      return CallBackResponse(status: false, message: response.statusText!);
    }
  }

  String data = '';
  bool isNumber = false;

  Future otpSend(String emailORPhone, bool isEmail, Function callback) async {
    _isLoading = true;
    data = emailORPhone;
    isNumber = isEmail;
    notifyListeners();
    Response response = await authRepo.otpSend(emailORPhone, isEmail);
    _isLoading = false;

    if (response.statusCode == 200) {
      startTimer();
      callback(true, response.body['message']);
    } else {
      callback(false, response.statusText);
    }
    notifyListeners();
  }

  otpVerify(String code, Function callback) async {
    _isLoading = true;
    notifyListeners();
    Response response = await authRepo.otpVerify(data, code, isNumber);
    _isLoading = false;

    if (response.statusCode == 200) {
      callback(true, 'Successfully Verified');
    } else {
      callback(false, response.statusText);
    }
    notifyListeners();
  }

  /////TODO: for time count

  int minutes = 5;
  int seconds = 0;
  bool isEmail = true;
  late Timer _timer;

  void startTimer() {
    seconds = 0;
    minutes = 5;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (seconds > 0) {
        seconds--;
        notifyListeners();
      } else {
        if (minutes > 0) {
          minutes--;
          seconds = 59;
          notifyListeners();
        } else {
          timer.cancel();
        }
      }
    });
  }

  void resetTime() {
    _timer.cancel();
    // seconds = 0;
    // minutes = 5;
    otpSend(data, isNumber, (bool status, String message) {
      if (status) {
        Fluttertoast.showToast(msg: message);
      } else {
        Fluttertoast.showToast(msg: message, backgroundColor: Colors.red);
      }
    });
    notifyListeners();
  }

  //// TODO: for send User Information
  DateTime _dateTime = DateTime.now();
  String dateTime = "";
  var buttonText = "Choose time";

  void showDateDialog(BuildContext context) {
    showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(60), lastDate: DateTime.now()).then((value) {
      _dateTime = value!;
      buttonText = "${_dateTime.year.toString()}-${_dateTime.month.toString()}-${_dateTime.day.toString()}";
      dateTime = buttonText;
      notifyListeners();
    });
  }

  List<String> genderLists = ["Male", "Female", "Other"];

  String selectGender = "Male";

  changeGenderStatus(String status) {
    selectGender = status;
    notifyListeners();
  }

  //TODO: for Logout
  Future<bool> logout() async {
    authRepo.clearToken();
    authRepo.clearUserInformation();
    return true;
  }

  //TODO: for Logout
  bool checkTokenExist() {
    return authRepo.checkTokenExist();
  }

  String getUserToken() {
    return authRepo.getUserToken();
  }

  // get User INFO:
  String name = '';
  String profileImage = '';
  String userID = '';
  String userCode = '';

  void getUserInfo() {
    name = authRepo.getUserName();
    profileImage = authRepo.getUserProfile();
    userID = authRepo.getUserID();
    userCode = authRepo.getUserCode();
    notifyListeners();
  }
}
