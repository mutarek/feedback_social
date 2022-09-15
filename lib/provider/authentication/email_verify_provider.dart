import 'dart:async';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart' as http;

import '../../const/url.dart';
import '../../screens/screens.dart';

class EmailVerifyProvider extends ChangeNotifier {
  String email = "";
  String phone = "";
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

  Future verifyEmail(String email, code) async {
    var apiUrl = "$baseUrl/accounts/otp/verify/";

    Map mappeddata = {
      "email": email,
      "code": code,
    };

    http.Response response =
        await http.post(Uri.parse(apiUrl), body: mappeddata);

    if (response.statusCode == 200 || response.statusCode == 201) {
      success = true;
      message = "Email Verified";
      notifyListeners();
      Fluttertoast.showToast(msg: message);
      Get.off(const RegistrationScreen());
    } else {
      success = false;
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
    print(email);
    print("email:${response.statusCode}");
    notifyListeners();
    if (response.statusCode == 200) {
      success2 = true;
      notifyListeners();
    }
  }

  Future getCode2(String phone) async {
    var apiUrl = "$baseUrl/accounts/otp/send/";
    
    Map mappeddata = {
      "phone": phone,
    };

    http.Response response =
        await http.post(Uri.parse(apiUrl), body: mappeddata);
    print(phone);
    print("phone:${response.statusCode}");
    notifyListeners();
    if (response.statusCode == 200) {
      success2 = true;
      notifyListeners();
    }
  }
}
