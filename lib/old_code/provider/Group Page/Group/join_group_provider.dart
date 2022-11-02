import 'package:als_frontend/old_code/const/url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class JoinGroupProvider extends ChangeNotifier {
  bool success = false;
  String? token;
  int groupId = 0;

  Future joinGroup() async {
    var apiUrl = "$baseUrl/group/$groupId/member/join/";
    Map mappeddata = {};
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? '');
    var headers = {'Authorization': 'token $token'};

    http.Response response =
        await http.post(Uri.parse(apiUrl), body: mappeddata, headers: headers);
    if (response.statusCode == 201) {
      success = true;
      notifyListeners();
    }
  }

  Future leaveGroup() async {
    var apiUrl = "$baseUrl/group/$groupId/member/leave/";
    Map mappeddata = {};
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? '');
    var headers = {'Authorization': 'token $token'};

    http.Response response = await http.delete(Uri.parse(apiUrl),
        body: mappeddata, headers: headers);
    print(response.statusCode);
    print(groupId);
    if (response.statusCode == 201) {
      success = true;
      notifyListeners();
    }
  }
}
