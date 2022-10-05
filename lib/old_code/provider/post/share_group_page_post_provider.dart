import 'package:als_frontend/old_code/const/url.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ShareGroupPagePostProvider extends ChangeNotifier {
  bool success = false;
  String? token;
  int? postId;
  int? groupPageId;
  String? postType = "";

  Future sharePost(String description) async {
    var apiUrl = "$baseUrl/posts/$postType/$groupPageId/$postId/share/";

    Map mappeddata = {"description": description};

    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? '');
    var uri = Uri.parse(apiUrl), headers = {'Authorization': 'token $token'};

    http.Response response =
        await http.post(uri, body: mappeddata, headers: headers);
    print(response.statusCode);
    if (response.statusCode == 201) {
      success = true;
      Fluttertoast.showToast(msg: "Shared");
      notifyListeners();
    } else {
      Fluttertoast.showToast(msg: "Something went wrong!");
    }
  }
}
