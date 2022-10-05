import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../../const/url.dart';

class WritePagePostProvider extends ChangeNotifier {
  int? id;
  String message = "";
  bool success = false;
  String token = "";

  Future createPost(String description) async {
    var apiUrl = "$baseUrl/page/post/$id/create/";

    Map mappeddata = {
      "description": description,
    };

    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? '');
    var headers = {'Authorization': 'token $token'};

    try {
      http.Response response =
          await http.post(Uri.parse(apiUrl), body: mappeddata, headers: headers);
      if (response.statusCode == 201) {
        success = true;
        notifyListeners();
      } else {
        success = false;
        message = "Something went wrong";
        notifyListeners();
        Fluttertoast.showToast(msg: message);
      }
    } catch (e) {
      print(e);
    }
  }
}
