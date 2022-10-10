import 'dart:convert';

import 'package:als_frontend/data/model/response/CommentModels.dart';
import 'package:als_frontend/data/repository/comment_repo.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class CommentProvider with ChangeNotifier {
  final CommentRepo commentRepo;

  CommentProvider({required this.commentRepo});

  List<CommentModels> comments = [];
  bool isLoading = false;

  void initializeCommentData(int postID) async {
    comments.clear();
    comments = [];
    isLoading = true;
    Response response = await commentRepo.getAllCommentData(postID);
    isLoading = false;
    if (response.statusCode == 200) {
      response.body.forEach((element) {
        CommentModels comment = CommentModels.fromJson(element);

        comments.add(comment);
      });
    } else {
      Fluttertoast.showToast(msg: response.statusText!);
    }
    notifyListeners();
  }

  Future<bool> addComment(String comment, String fullName, String profileImage, int postID, int userID) async {
    Response response = await commentRepo.addComment(postID, comment);
    if (response.statusCode == 201) {
      Fluttertoast.showToast(msg: "commented");
      CommentModels c = CommentModels(
          id: DateTime.now().microsecondsSinceEpoch,
          comment: comment,
          post: postID,
          replies: [],
          author: Author(id: userID, fullName: fullName, profileImage: profileImage));
      channel.sink.add(jsonEncode({"data": c.toJson()}));

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
      print("Connect: ${commentData.comment}");
      notifyListeners();
    }, onDone: () {
      print("disconected");
    });
  }

  channelDismiss() {
    channel.sink.close();
    notifyListeners();
  }

  initializeSocket(int postID) {
    channel = IOWebSocketChannel.connect('wss://als-social.com/ws/post/$postID/comment/timeline_post/');
    userPostComments();
  }
}
