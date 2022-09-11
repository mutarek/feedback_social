import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../const/url.dart';

class LikeCommentShareProvider extends ChangeNotifier {
  String message = "";
  bool success = false;
  String? token;
  String postId = "";
  bool isLiked = true;
  String result = "";

  Future like() async {
    var apiUrl = "$baseUrl/posts/$postId/like/";

    Map mappeddata = {};

    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? '');
    var uri = Uri.parse(apiUrl), headers = {'Authorization': 'token $token'};

    http.Response response =
        await http.post(uri, body: mappeddata, headers: headers);
    var data = jsonDecode(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      success = true;
      isLiked = data['liked'];

      notifyListeners();
    }
  }

  Future comment(String description) async {
    var apiUrl = "$baseUrl/posts/$postId/comment/create/";

    Map mappeddata = {
      "comment": description,
    };

    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? '');
    var uri = Uri.parse(apiUrl), headers = {'Authorization': 'token $token'};

    http.Response response =
        await http.post(uri, body: mappeddata, headers: headers);

    if (response.statusCode == 201) {
      success = true;
      message = "Commented";
      Fluttertoast.showToast(msg: message);
      notifyListeners();
    } else {
      Fluttertoast.showToast(msg: "Something went wrong");
    }
  }

}
