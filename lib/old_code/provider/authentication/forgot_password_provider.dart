import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart' as http;

import '../../const/url.dart';
import '../../screens/screens.dart';

class ForgotPasswordProvider extends ChangeNotifier {
  String email = "";
  bool emailSent = false;
  bool success = false;
  bool success2 = false;
  String message = "";
  int minutes = 5;
  int seconds = 0;

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
    seconds = 0;
    minutes = 5;
    notifyListeners();
    startTimer();
  }

  Future getOtp(String email) async {
    var apiUrl = "$baseUrl/accounts/password/reset/";

    Map mappeddata = {
      "email": email,
    };

    http.Response response =
        await http.post(Uri.parse(apiUrl), body: mappeddata);

    if (response.statusCode == 200 || response.statusCode == 500) {
      success = true;
      emailSent = success;
      message = "An OTP has been sent to your email";
      notifyListeners();
      Fluttertoast.showToast(msg: message);
      
    } else {
      success = false;
      message = "Email is not registered";
      notifyListeners();
      Fluttertoast.showToast(msg: message);
    }
  }

  Future changePassword(String otp, newPassword) async {
    var apiUrl = "$baseUrl/accounts/password/reset/confirm/";

    Map mappeddata = {"email": email, "otp": otp, "new_password": newPassword};

    http.Response response =
        await http.put(Uri.parse(apiUrl), body: mappeddata);
    if (response.statusCode == 200) {
      success2 = true;
      Get.to(() => const LoginScreen());
      notifyListeners();
    }
  }
}
