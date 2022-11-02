import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

import '../../../const/url.dart';
import '../../../model/model.dart';

class UserProfileProvider extends ChangeNotifier {
  bool loading = true;
  String token = "";
  int? id;
  UserProfileModel userprofileData = UserProfileModel();

  void getUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? '');
    id = (prefs.getInt('id') ?? '') as int?;
    var uri = Uri.parse("$baseUrl/accounts/profile/"),
        headers = {'Authorization': 'token $token'};
    var response = await http.get(uri, headers: headers);

    userprofileData = UserProfileModel.fromJson(json.decode(response.body));
    loading = false;
    notifyListeners();
  }
}
