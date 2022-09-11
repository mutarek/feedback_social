import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

import '../../../const/url.dart';

class PageLikeProvider extends ChangeNotifier {
  String? token;
  int pageId = 0;
  bool isLiked = true;
  String result = "";

  Future like() async {
    var apiUrl = "$baseUrl/page/$pageId/like/";

    Map mappeddata = {};

    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? '');
    var uri = Uri.parse(apiUrl), headers = {'Authorization': 'token $token'};

    await http.post(uri, body: mappeddata, headers: headers);
  }
}
