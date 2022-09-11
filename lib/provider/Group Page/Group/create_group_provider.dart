import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../../../../const/url.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CreateGroupProvider extends ChangeNotifier {
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

  Future creategroup(String pagename, pickup) async {
    var apiUrl = groupCreate;

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
      message = "Data send successful";
      notifyListeners();
    } else {
      message = "faild to send";
      notifyListeners();
    }
  }
}
