import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../const/url.dart';

class ParivacyAudienceTagProvider extends ChangeNotifier {
  String message = "";
  bool success = false;
  bool loading = false;
  String? token;

  bool anyonetag = true;
  void anyonetagbool() {
    anyonetag = !anyonetag;
    notifyListeners();
  }

  bool onlyFollowPeopletag = true;
  void onlyFollowPeopletagbool() {
    onlyFollowPeopletag = !onlyFollowPeopletag;
    notifyListeners();
  }

  Future<void> updatetaging(
    String isAnyoneTag,
    String isPeopleFollowTage,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? '');

    var uri = Uri.parse("$baseUrl/accounts/settings/audience-tagging/");

    Map<String, String> headers = <String, String>{
      "Authorization": 'token $token',
    };

    Map mappeddata = {
      "is_anyone_tag": isAnyoneTag,
      "is_people_follow_tag": isPeopleFollowTage
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
