import 'dart:convert';

import 'package:als_frontend/const/url.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TimelinePostLikeService {
  static Future<bool> addLiked(int postID) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = (prefs.getString('token') ?? '');
    var uri = Uri.parse("$baseUrl/posts/$postID/like/"), headers = {'Authorization': 'token $token'};
    var response = await http.post(uri, headers: headers);
    print(response.statusCode);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      // print(json);
      return json['liked'];
    }
    return false;
  }
}
