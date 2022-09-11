import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../const/url.dart';

class UpdateAccountProvider extends ChangeNotifier {
  String message = "";
  bool success = false;
  bool loading = false;
  String? token;

  Future updateaccount(
      String firstName, lastName, number, dob, location) async {
    var apiUrl = "$baseUrl/accounts/settings/user-info/";

    Map mappeddata = {
      "first_name": firstName,
      "last_name": lastName,
      "date_of_birth": dob,
      "mobile": number,
      "location": location
    };
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? '');

    var uri = Uri.parse(apiUrl), headers = {'Authorization': 'token $token'};
    var response = await http.patch(uri, headers: headers, body: mappeddata);

    var data = jsonDecode(response.body);
    if (response.statusCode == 201) {
      success = true;
      loading = false;
      notifyListeners();
    } else {
      success = false;
      loading = false;

      message = "succesfullu changed";
      notifyListeners();
      Fluttertoast.showToast(msg: message);
    }
  }
}
