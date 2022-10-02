import 'dart:convert';

import 'package:als_frontend/model/comment/CommentModels.dart';
import 'package:als_frontend/service/comment/timeline_post_comment_service.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../const/url.dart';
import '../../model/comment/timeline_post_comment_model.dart';
import 'package:http/http.dart' as http;

class TimelinePostCommentProvider extends ChangeNotifier {
  List<CommentModels> comments = [];
  int postId = 0;
  String? token;
  bool success = false;

  Future<void> getData() async {
    try {
      comments = (await TimelinePostCommentService(postId: postId).getComments());
      notifyListeners();
    } catch (e) {
      print("Friend request provider: $e");
    }
  }

  Future<bool> comment(String description) async {
    var apiUrl = "$baseUrl/posts/$postId/comment/create/";

    Map mappeddata = {"comment": description};

    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? '');
    var uri = Uri.parse(apiUrl), headers = {'Authorization': 'token $token'};

    http.Response response = await http.post(uri, body: mappeddata, headers: headers);

    if (response.statusCode == 201) {
      success = true;
      var json = jsonDecode(response.body);
      print('json: $json');
      comments.add(CommentModels.fromJson(json));
      Fluttertoast.showToast(msg: "commented");
      notifyListeners();
      return true;
    } else {
      Fluttertoast.showToast(msg: "Something went wrong");
      return false;
    }
  }

  /////  ********    comment Web Socket
  WebSocketChannel channel = IOWebSocketChannel.connect('wss://als-social.com/ws/post/10/comment/timeline_post/');
  List socketComment = [];
  List<Map> newComment = [];

  userPostComments() {
    channel.stream.listen((data) {
      getData();
      CommentModels c = CommentModels.fromJson(data);
      print('akak ${c.comment}');
      print("data : $data");
    }, onDone: () {
      print("disconected");
    });
    notifyListeners();
  }

  channelDismiss({bool isDisposs = false}) {
    channel.sink.close();
    if (!isDisposs) notifyListeners();
  }

  initializeSocket() {
    channel = IOWebSocketChannel.connect('wss://als-social.com/ws/post/10/comment/timeline_post/');
    // notifyListeners();
  }
}
