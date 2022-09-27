import 'package:als_frontend/service/comment/timeline_post_comment_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../const/url.dart';
import '../../model/comment/timeline_post_comment_model.dart';
import 'package:http/http.dart' as http;

class TimelinePostCommentProvider extends ChangeNotifier {
  List<TimelinePostCommentModel> comments = [];
  int postId = 0;
  String? token;
  bool success = false;

  Future<void> getData() async {
    try {
      comments =
          (await TimelinePostCommentService(postId: postId).getComments())!;
      print(comments.length);
      notifyListeners();
    } catch (e) {
      print("Friend request provider: $e");
    }
  }

  Future comment(String description) async {
    var apiUrl = "$baseUrl/posts/$postId/comment/create/";

    Map mappeddata = {
      "comment": description,
    };

    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? '');
    var uri = Uri.parse(apiUrl), headers = {'Authorization': 'token $token'};

    http.Response response =
        await http.post(uri, body: mappeddata, headers: headers);

    if (response.statusCode == 201) {
      success = true;
      Fluttertoast.showToast(msg: "commented");
      notifyListeners();
    } else {
      Fluttertoast.showToast(msg: "Something went wrong");
    }
  }
}
