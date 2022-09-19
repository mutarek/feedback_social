import 'dart:convert';

import 'package:als_frontend/provider/authentication/login_provider.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../../const/url.dart';
import '../../screens/screens.dart';

class RegistrationProvider extends ChangeNotifier {
  List<String> items = ["Male", "Female", "Other"];

  String drondownValue = "Male";

  String message = "";
  bool success = false;
  bool loading = false;

  String email = "";
  String phone = "";
  String password = "";

  Future registration(
      String firstName, lastName, email, dob, gender, password) async {
    var apiUrl = signUp;

    Map mappeddata = {
      "first_name": firstName,
      "last_name": lastName,
      "email": email,
      "password": password,
      "date_of_birth": dob,
      "gender": gender,
    };

    http.Response response =
        await http.post(Uri.parse(apiUrl), body: mappeddata);
    var data = jsonDecode(response.body);
    if (response.statusCode == 201) {
      success = true;
      loading = false;
      notifyListeners();
      LoginProvider().login(email, password);
      print(email);
      print(password);
      Get.to(const SplashScreen());
    } else {
      success = false;
      loading = false;
      message = "Email is already used or ${data["email"][0]}";
      notifyListeners();
      Fluttertoast.showToast(msg: message);
    }
  }

  Future registrationWithPhone(
      String firstName, lastName, phone, dob, gender, password) async {
    var apiUrl = signUp;

    Map mappeddata = {
      "first_name": firstName,
      "last_name": lastName,
      "phone": phone,
      "password": password,
      "date_of_birth": dob,
      "gender": gender,
    };

    http.Response response =
        await http.post(Uri.parse(apiUrl), body: mappeddata);
    var data = jsonDecode(response.body);
    if (response.statusCode == 201) {
      success = true;
      loading = false;
      notifyListeners();
      LoginProvider().login(phone, password);
      print(phone);
      print(password);
      Get.to(const SplashScreen());
    } else {
      success = false;
      loading = false;
      message = "Number is already used or ${data["email"][0]}";
      notifyListeners();
      Fluttertoast.showToast(msg: message);
    }
  }
}
