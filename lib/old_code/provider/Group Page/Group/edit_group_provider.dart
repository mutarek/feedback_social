import 'package:als_frontend/old_code/const/url.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class EditGroupProvider extends ChangeNotifier {
  bool success = false;
  String? token;
  int groupId = 0;

  Future editGroup(
    String name,
    String category,
  ) async {
    var apiUrl = "$baseUrl/group/$groupId/";
    Map mappeddata = {"name": name, "category": category};
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? '');
    var headers = {'Authorization': 'token $token'};

    http.Response response =
        await http.patch(Uri.parse(apiUrl), body: mappeddata, headers: headers);
    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: "Update");
      success = true;
      notifyListeners();
    }else{
      Fluttertoast.showToast(msg: "Something went wrong!");
    }
  }
}
