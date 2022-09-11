import 'dart:convert';
import 'package:als_frontend/const/url.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DatasaveProvider extends ChangeNotifier {
  String message = "";
  bool success = false;
  bool loading = false;
  String? token;

  Future<void> updatedatasave(
    String datasave,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? '');

    var uri = Uri.parse("$baseUrl/accounts/settings/data-save/");

    Map<String, String> headers = <String, String>{
      "Authorization": 'token $token',
    };

    Map mappeddata = {"is_data_save": datasave};

    http.Response response =
        await http.patch(uri, body: mappeddata, headers: headers);
    print(response.statusCode);

    var data = jsonDecode(response.body);

    if (response.statusCode == 200) {
      success = true;
      message = "Succesfully changed";
      notifyListeners();
      Fluttertoast.showToast(msg: message);
    } else {
      success = false;
      message = "Something went rong";
      notifyListeners();
      Fluttertoast.showToast(msg: message);
    }
  }
}
