import 'dart:convert';
import 'package:als_frontend/const/url.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ParivacyShareProvider extends ChangeNotifier {
  String message = "";
  bool success = false;
  bool loading = false;
  String? token;

  Future<void> updateshare(
    String isAnyoneshare,
    String isFollowershare,
    String isFollowingshare,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? '');

    var uri = Uri.parse("$baseUrl/accounts/settings/share-post/");

    Map<String, String> headers = <String, String>{
      "Authorization": 'token $token',
    };

    Map mappeddata = {
      "is_anyone_share": isAnyoneshare,
      "is_follower_share": isFollowershare,
      "is_following_share": isFollowingshare
    };

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
