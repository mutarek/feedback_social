import 'dart:convert';

import 'package:als_frontend/model/comment/CommentModels.dart';
import 'package:als_frontend/service/comment/timeline_post_comment_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../const/url.dart';
// import '../../model/comment/timeline_post_comment_model.dart';

class TimelinePostCommentProvider extends ChangeNotifier {
  List<CommentModels> comments = [];
  // int postId = 0;
  String? token;
  bool success = false;

  Future<void> getData(int postID) async {
    try {
      comments = (await TimelinePostCommentService(postId: postID).getComments());
      notifyListeners();
    } catch (e) {
      print("Friend request provider: $e");
    }
  }

  Future<bool> addComment(String comment, String fullName, String profileImage, int postID, int userID) async {
    var apiUrl = "$baseUrl/posts/$postID/comment/create/";

    Map mappeddata = {"comment": comment};

    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? '');
    var uri = Uri.parse(apiUrl), headers = {'Authorization': 'token $token'};

    http.Response response = await http.post(uri, body: mappeddata, headers: headers);

    if (response.statusCode == 201) {
      success = true;
      var json = jsonDecode(response.body);
      print('json: $json');

      Fluttertoast.showToast(msg: "commented");
      CommentModels c = CommentModels(
          id: DateTime.now().microsecondsSinceEpoch,
          comment: comment,
          post: postID,
          replies: [],
          author: Author(id: userID, fullName: fullName, profileImage: profileImage));
      channel.sink.add(
        jsonEncode({"data": c.toJson()}),
      );

      notifyListeners();
      return true;
    } else {
      Fluttertoast.showToast(msg: "Something went wrong");
      return false;
    }
  }

  /////  ********    comment Web Socket
  WebSocketChannel channel = IOWebSocketChannel.connect('wss://als-social.com/ws/post/191/comment/timeline_post/');

  userPostComments() {
    channel.stream.listen((data) {
      CommentModels commentData = CommentModels.fromJson(jsonDecode(data)['comment_data']);
      comments.add(commentData);
      notifyListeners();
    }, onDone: () {
      print("disconected");
    });
  }

  initializeSocket(int postID) {
    channel = IOWebSocketChannel.connect('wss://als-social.com/ws/post/$postID/comment/timeline_post/');
    userPostComments();
  }
}
