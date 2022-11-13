
import 'package:als_frontend/old_code/const/url.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CreatePageProvider extends ChangeNotifier {
  List<String> items = [
    'Sports',
    'Education',
    'Animal',
    'Pet',
    'Music',
    'Entertainment',
    'Others',
  ];

  String catagoryValue = "Sports";

  String message = "";
  bool success = false;
  String? token;
  int? id;

  Future createpage(String pagename, pickup) async {
    var apiUrl = pageCreate;

    Map mappeddata = {
      "name": pagename,
      "category": pickup,
    };
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? '');
    var headers = {'Authorization': 'token $token'};
    http.Response response =
        await http.post(Uri.parse(apiUrl), body: mappeddata, headers: headers);

    if (response.statusCode == 201) {
      success = true;
      Fluttertoast.showToast(msg: "Created succesfully");
      notifyListeners();
    } else {
      Fluttertoast.showToast(msg: "Created succesfully");
      notifyListeners();
    }
  }
}