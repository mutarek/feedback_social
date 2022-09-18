import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../const/url.dart';

class ConfirmFriendRequestProvider extends ChangeNotifier {
  String message = "";
  bool success = false;
  String? token;
  int? id;

  Future confirmRequest() async {
    var apiUrl = "$baseUrl/accounts/friends/accept-friend-request/$id/";

    Map mappeddata = {};

    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? '');
    var uri = Uri.parse(apiUrl), headers = {'Authorization': 'token $token'};

    http.Response response =
        await http.post(uri, body: mappeddata, headers: headers);
    print(response.statusCode);
    print(id);
    if (response.statusCode == 200 || response.statusCode == 201) {
      success = true;
      message = "Friend added successfully";
      Fluttertoast.showToast(msg: "Accepted");
      notifyListeners();
    } else {
      Fluttertoast.showToast(msg: "Something went wrong!");
    }
  }

  Future cancelRequest() async {
    var apiUrl = "$cancelFriendRequest/$id/";

    Map mappeddata = {};

    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? '');
    var uri = Uri.parse(apiUrl), headers = {'Authorization': 'token $token'};

    http.Response response =
        await http.delete(uri, body: mappeddata, headers: headers);
    if (response.statusCode == 204) {
      success = true;
      message = "Cancelled ";
      Fluttertoast.showToast(msg: "Cancelled");
      notifyListeners();
    } else {
      Fluttertoast.showToast(msg: "Something went wrong!");
    }
  }

  Future unSendRequest() async {
    var apiUrl = "$baseUrl/accounts/friends/cancel-friend-request/$id/";

    Map mappeddata = {};

    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? '');
    var uri = Uri.parse(apiUrl), headers = {'Authorization': 'token $token'};

    http.Response response =
        await http.delete(uri, body: mappeddata, headers: headers);
    print("Unsend friend request: ${response.statusCode}");
    if (response.statusCode == 204) {
      success = true;
      message = "Cancelled ";
      Fluttertoast.showToast(msg: "Cancelled");
      notifyListeners();
    } else {
      Fluttertoast.showToast(msg: "Something went wrong!");
    }
  }
}
