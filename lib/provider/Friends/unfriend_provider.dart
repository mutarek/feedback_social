import 'package:als_frontend/const/url.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UnFriendProvider extends ChangeNotifier {
  String message = "";
  bool success = false;
  String? token;
  int? id;

  Future unFriend() async {
    var apiUrl = "$baseUrl/accounts/friends/unfriend/$id/";

    Map mappeddata = {};

    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? '');
    var uri = Uri.parse(apiUrl), headers = {'Authorization': 'token $token'};

    http.Response response =
        await http.post(uri, body: mappeddata, headers: headers);
    if (response.statusCode == 200 || response.statusCode == 201) {
      success = true;
      Fluttertoast.showToast(msg: "Unfriend");
      notifyListeners();
    } else {
      Fluttertoast.showToast(msg: "Something went wrong!");
    }
  }
}
