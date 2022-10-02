import 'package:als_frontend/const/url.dart';

import 'package:als_frontend/model/post/author_newsfeed_post_model.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;

class AuthorNewsfeedPostService {
  String? token;
  int id;

  AuthorNewsfeedPostService({required this.id});


  Future<AuthorNewsFeedPostModel?> getAuthorPost(int page) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? '');
    var uri = Uri.parse("$baseUrl/posts/$id/list?page=$page"),
        headers = {'Authorization': 'token $token'};
    var response = await http.get(uri, headers: headers);
    if (response.statusCode == 200) {
      var json = response.body;

      return authorNewsFeedPostModelFromJson(json);
    }
    return null;
  }
}
