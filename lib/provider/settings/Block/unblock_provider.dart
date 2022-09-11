import 'dart:convert';

import 'package:als_frontend/const/url.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class UnblockProvider extends ChangeNotifier {
  String message = "";
  bool success = false;
  bool loading = false;
  String? token;

  Future unblock(
    String oldpassword,
  ) async {
    var apiUrl = "$baseUrl/accounts/settings/block/$oldpassword/delete/";

    Map mappeddata = {};
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? '');

    var uri = Uri.parse(apiUrl), headers = {'Authorization': 'token $token'};
    var response = await http.delete(uri, headers: headers, body: mappeddata);

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
