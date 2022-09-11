import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../../const/url.dart';

class EditProfileProvider extends ChangeNotifier {
  bool spinner = false;
  int? id;
  String? token;

  String message = "";
  bool success = false;
  List<String> gender = ["Male", "Female"];
  String drondownValue = "Male";

  Future<void> saveData(String firstName, lastName, company, education, gender,
      religion, liveInAdress, fromAdress) async {
    spinner = true;
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? '');
    id = (prefs.getInt('id') ?? '') as int;

    var uri = Uri.parse("$baseUrl/accounts/profile/update/");

    Map<String, String> headers = <String, String>{
      "Authorization": 'token $token',
    };

    Map mappeddata = {
      'first_name': firstName,
      'last_name': lastName,
      'gender': gender,
      'lives_in_address': liveInAdress,
      'from_address': fromAdress,
      'religion': religion,
      'company': company,
      'education': education,
    };

    http.Response response =
        await http.put(uri, body: mappeddata, headers: headers);

    if (response.statusCode == 200) {
      success = true;
      notifyListeners();
      Fluttertoast.showToast(msg: "Updated");
    } else {
      Fluttertoast.showToast(msg: "Something went wrong!");
      success = false;
      notifyListeners();
    }

    // try {
    //   final request = http.MultipartRequest("PUT", uri)
    //     ..headers.addAll(headers)
    //     ..fields.addAll(requestBody);

    //   var response = await request.send();
    //   final respStr = await response.stream.bytesToString();
    //   spinner = false;
    //   notifyListeners();
    //   print(response.statusCode);
    //   print(respStr);
    // } catch (e) {
    //   debugPrint(e.toString());
    // }
  }
}
