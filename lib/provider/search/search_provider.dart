import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

import '../../../const/url.dart';

class SearchProvider extends ChangeNotifier {
  bool loading = true;
  String token = "";
  int? id;
  int? userId;
  var searchData;

  int value = 1;

  void getSearchResult(String searchKey) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? '');
    userId = (prefs.getInt('id') ?? '') as int;
    var uri = Uri.parse("$baseUrl/search/?q=$searchKey"),
        headers = {'Authorization': 'token $token'};
    var response = await http.get(uri, headers: headers);
    searchData = json.decode(response.body);
    if (response.statusCode == 200) {
      loading = false;
    }
    notifyListeners();
  }
}
