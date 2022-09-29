import 'package:als_frontend/const/url.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/model.dart';
import 'package:http/http.dart' as http;

class PostService {
  String? token;
  Future<NewsfeedModel?> getPosts(int page) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? '');
    var uri = Uri.parse("$baseUrl/posts/newsfeeds?page=$page"),
        headers = {'Authorization': 'token $token'};
    var response = await http.get(uri, headers: headers);
    print(response.statusCode);
    if (response.statusCode == 200) {
      var json = response.body;
      return newsfeedModelFromJson(json);
    }
    return null;
  }
}
