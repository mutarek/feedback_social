import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../../const/url.dart';

class EmailVerifyProvider extends ChangeNotifier {
  String email = "";
  String phone = "";
  bool codeVerifySuccess = true;
  bool getCodeSuccess = true;
  String message = "";
  int minutes = 5;
  int seconds = 0;
  bool isEmail = true;
  late Timer _timer;

  bool otpSend = false;
  bool verifiedCheck = false;

  void emailLogin() {
    isEmail = !isEmail;
  }

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
    seconds = 0;
    minutes = 5;
    notifyListeners();
    startTimer();
  }

  Future verifyEmail(String email, code) async {
    var apiUrl = "$baseUrl/accounts/otp/verify/";

    Map mappeddata = {
      "email": email,
      "code": code,
    };

    http.Response response =
        await http.post(Uri.parse(apiUrl), body: mappeddata);

    if (response.statusCode == 200 || response.statusCode == 201) {
      codeVerifySuccess = true;
      verifiedCheck = false;
      message = "Email Verified";
      notifyListeners();
      Fluttertoast.showToast(msg: message);
    } else {
      verifiedCheck = false;
      codeVerifySuccess = false;
      message = "Invalid otp";
      notifyListeners();
      Fluttertoast.showToast(msg: message);
    }
  }

  Future verifyPhone(String phone, code) async {
    var apiUrl = "$baseUrl/accounts/otp/verify/";

    Map mappeddata = {
      "phone": phone,
      "code": code,
    };

    http.Response response =
        await http.post(Uri.parse(apiUrl), body: mappeddata);

    if (response.statusCode == 200 || response.statusCode == 201) {
      message = "Email Verified";
      verifiedCheck = false;
      codeVerifySuccess = true;
      notifyListeners();
      Fluttertoast.showToast(msg: message);
    } else {
      codeVerifySuccess = true;
      verifiedCheck = false;
      message = "Invalid otp";
      notifyListeners();
      Fluttertoast.showToast(msg: message);
    }
  }

  Future getCode(String email) async {
    var apiUrl = "$baseUrl/accounts/otp/send/";

    Map mappeddata = {
      "email": email,
    };

    http.Response response =
        await http.post(Uri.parse(apiUrl), body: mappeddata);
    notifyListeners();
    if (response.statusCode == 200) {
      otpSend = false;
      getCodeSuccess = true;
      startTimer();
      notifyListeners();
      Fluttertoast.showToast(
          msg: "succesfully send code please check your email");
    } else {
      otpSend = false;
      notifyListeners();
      Fluttertoast.showToast(msg: "Something went wrong!");
    }
  }

  Future getCode2(String phone) async {
    var apiUrl = "$baseUrl/accounts/otp/send/";

    Map mappeddata = {
      "phone": phone,
    };

    http.Response response =
        await http.post(Uri.parse(apiUrl), body: mappeddata);
    notifyListeners();
    if (response.statusCode == 200) {
      otpSend = false;
      getCodeSuccess = true;
      notifyListeners();
      startTimer();
      Fluttertoast.showToast(
          msg: "succesfully send code please check your message");
    } else {
      otpSend = false;
      notifyListeners();
      Fluttertoast.showToast(msg: "Something went wrong!");
    }
  }
}
