import 'dart:convert';

import 'package:als_frontend/const/url.dart';
import 'package:als_frontend/model/comment/CommentModels.dart';
import 'package:als_frontend/model/comment/timeline_post_comment_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class TimelinePostCommentService {
  TimelinePostCommentService({required this.postId});

  String? token;
  int? postId;

  Future<List<CommentModels>> getComments() async {
    List<CommentModels>? comments = [];

    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? '');
    var uri = Uri.parse("$baseUrl/posts/$postId/comment/"), headers = {'Authorization': 'token $token'};
    var response = await http.get(uri, headers: headers);
    print(response.statusCode);
    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      json.forEach((element) {
        comments.add(CommentModels.fromJson(element));
      });

    }
    return comments;
  }
}
