import 'package:als_frontend/const/url.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddFriendProvider extends ChangeNotifier {
  String message = "";
  bool success = false;
  String? token;
  int? id;

  Future addSuggestedFriend() async {
    var apiUrl = "$addFriend/$id/";

    Map mappeddata = {};

    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? '');
    var uri = Uri.parse(apiUrl), headers = {'Authorization': 'token $token'};

    http.Response response =
        await http.post(uri, body: mappeddata, headers: headers);
    if (response.statusCode == 200 || response.statusCode == 201) {
      success = true;
      message = "Friend request sent";
      Fluttertoast.showToast(msg: "Friend request sent");
      notifyListeners();
    } else {
      Fluttertoast.showToast(msg: "Something went wrong!");
    }
  }
}
