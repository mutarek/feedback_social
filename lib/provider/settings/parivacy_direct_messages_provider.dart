import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../const/url.dart';

class ParivacyDirectMessagesProvider extends ChangeNotifier {
  String message = "";
  bool success = false;
  bool loading = false;
  String? token;

  bool alloweveryone = true;
  void alloweveryonebool() {
    alloweveryone = !alloweveryone;
    notifyListeners();
  }

  bool youFollow = true;
  void youFollowbool() {
    youFollow = !youFollow;
    notifyListeners();
  }

  bool yourFollower = true;
  void yourFollowerbool() {
    yourFollower = !yourFollower;
    notifyListeners();
  }

  Future<void> updatedirctmasge(
    String isAnyoneMessage,
    String isFollowerMessage,
    String isFollowingMassage,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? '');

    var uri = Uri.parse("$baseUrl/accounts/settings/direct-message/");

    Map<String, String> headers = <String, String>{
      "Authorization": 'token $token',
    };

    Map mappeddata = {
      "is_anyone_message": isAnyoneMessage,
      "is_follower_message": isFollowerMessage,
      "is_following_message": isFollowingMassage
    };

    http.Response response =
        await http.patch(uri, body: mappeddata, headers: headers);
    print(response.statusCode);
    print(response.body);
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
