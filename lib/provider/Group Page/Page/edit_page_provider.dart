import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import '../../../../const/url.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditPageProvider extends ChangeNotifier {
  bool success = false;
  String? token;
  int pageId = 0;

  Future editPage(
    String name,
    String category,
  ) async {
    var apiUrl = "$baseUrl/page/$pageId/";
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
    } else {
      Fluttertoast.showToast(msg: "Something went wrong!");
    }
  }
}
