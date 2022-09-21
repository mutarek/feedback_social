import 'package:als_frontend/const/url.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ReportPostProvider extends ChangeNotifier {
  bool success = false;
  String? token;
  int? postId;
  String postFrom = "";
  Future reportPost(String reportNote) async {
    var apiUrl;
    if (postFrom == "newsfeed") {
      apiUrl = "$baseUrl/posts/post-report/$postId/";
    } else if (postFrom == "page") {
      apiUrl = "$baseUrl/posts/page-post-report/$postId/";
    } else if (postFrom == "group") {
      apiUrl = "$baseUrl/posts/group-post-report/$postId/";
    }

    Map mappeddata;
    if (postFrom == "newsfeed") {
      mappeddata = {"report_note": reportNote};
    } else {
      mappeddata = {"report_note": reportNote, "report_type": "1"};
    }

    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? '');
    var uri = Uri.parse(apiUrl), headers = {'Authorization': 'token $token'};

    http.Response response =
        await http.post(uri, body: mappeddata, headers: headers);
    print(response.body);
    print(apiUrl);
    if (response.statusCode == 201) {
      success = true;
      Fluttertoast.showToast(
          msg: "Reported. Thanks for making the community better.");
      notifyListeners();
    } else {
      Fluttertoast.showToast(msg: "Something went wrong!");
    }
  }
}
