import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

import '../../const/url.dart';
import '../../screens/screens.dart';
import '../provider.dart';

class LoginProvider extends ChangeNotifier {
  String email = "";
  String password = "";
  bool success = false;
  bool loading = false;
  String token = "";
  String profileImage = "";
  String image = "";
  String name = "";
  int? id;

  String message = "";
  void login(String email, password) async {
    loading = true;
    http.Response response = await http
        .post(Uri.parse(signIn), body: {'email': email, 'password': password});
    try {
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        success = true;
        //save data and go to gomepage after successful login
        final userId = data['id'];
        final token = data['token'];
        final lastName = data['last_name'];
        final firstName = data['first_name'];
        name = "$firstName $lastName";
        final code = data['code'];
        final image = data["profile_image"];
        profileImage = image;
        notifyListeners();

        DatabaseProvider().saveUserID(userId);
        DatabaseProvider().saveToken(token);
        DatabaseProvider().saveFirstName(firstName);
        DatabaseProvider().saveLastName(lastName);
        DatabaseProvider().saveCode(code);
        DatabaseProvider().saveProfileImage(image);
        Get.off(const NavScreen());
        loading = false;
        notifyListeners();
      } else {
        success = false;
        loading = false;
        notifyListeners();
        Fluttertoast.showToast(msg: "Incorrect email or password");
      }
    } on SocketException catch (_) {
      message = "Internet connection is not available";
      notifyListeners();
    } catch (e) {
      message = "Please try again";
      notifyListeners();
      print(e);
    }
  }

  void clear() {
    message = '';
    notifyListeners();
  }

  void navigate() {
    DatabaseProvider().getProfileImage().then((value) {
      image = value;
      notifyListeners();
    });
  }
}
