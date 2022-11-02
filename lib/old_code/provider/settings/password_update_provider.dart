import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../const/url.dart';

class PasswordUpdateProviders extends ChangeNotifier {
  String message = "";
  bool success = false;
  bool loading = false;
  String? token;

  Future updatepassword(String oldpassword, newpassword, repetpassword) async {
    var apiUrl = "$baseUrl/accounts/password/change/";

    Map mappeddata = {
      "old_password": oldpassword,
      "new_password": newpassword,
      "confirm_password": repetpassword
    };
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? '');

    var uri = Uri.parse(apiUrl), headers = {'Authorization': 'token $token'};
    var response = await http.put(uri, headers: headers, body: mappeddata);

    var data = jsonDecode(response.body);
    if (response.statusCode == 200) {
      success = true;
      loading = false;
      notifyListeners();
    } else {
      success = false;
      loading = false;

      message = "Succesfully changed";
      notifyListeners();
      Fluttertoast.showToast(msg: message);
    }
  }
}
