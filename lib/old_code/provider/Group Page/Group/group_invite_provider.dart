import 'package:als_frontend/old_code/const/url.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class GroupInviteProvider extends ChangeNotifier {
  String message = "";
  bool success = false;
  String? token;
  int? id;
  int groupId = 0;
  int userId = 0;

  Future sendInvitation() async {
    var apiUrl = "$baseUrl/group/$groupId/$userId/invitation-send/";
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
}
