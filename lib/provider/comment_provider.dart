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
  List<bool> isOpenComment = [];

  void initializeCommentData(String url) async {
    comments.clear();
    comments = [];
    isLoading = true;
    Response response = await commentRepo.getAllCommentData(url);
    isLoading = false;
    if (response.statusCode == 200) {
      response.body.forEach((element) {
        CommentModels comment = CommentModels.fromJson(element);

        comments.insert(0, comment);
        isOpenComment.insert(0, false);
      });
    } else {
      Fluttertoast.showToast(msg: response.statusText!);
    }
    notifyListeners();
  }

  void initializeGroupCommentData(int postID, int groupID) async {
    comments.clear();
    comments = [];
    isLoading = true;
    Response response = await commentRepo.getAllGroupCommentData(postID, groupID);
    isLoading = false;
    if (response.statusCode == 200) {
      response.body.forEach((element) {
        CommentModels comment = CommentModels.fromJson(element);

        comments.insert(0, comment);
      });
    } else {
      Fluttertoast.showToast(msg: response.statusText!);
    }
    notifyListeners();
  }

  bool isCommentLoading = false;

  Future<bool> addComment(String comment, String fullName, String profileImage, int postID, int userID, String url) async {
    isCommentLoading = true;
    Response response = await commentRepo.addComment(url, comment);
    isCommentLoading = false;
    if (response.statusCode == 201) {
      Fluttertoast.showToast(msg: "commented");

      CommentModels c = CommentModels.fromJson(response.body);
      debugPrint(jsonEncode({"data": c.toJson()}));
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
  WebSocketChannel replyChannel = IOWebSocketChannel.connect('wss://als-social.com/ws/post/191/comment/timeline_post/');

  userPostComments() {
    channel.stream.listen((data) {
      CommentModels commentData = CommentModels.fromJson(jsonDecode(data)['comment_data']);
      comments.insert(0, commentData);
      isOpenComment.insert(0, false);
      debugPrint("Connect: ${commentData.comment}");
      notifyListeners();
    }, onDone: () {
      debugPrint("disconnected");
    });
  }

  userReplyComments(int index) {
    replyChannel.stream.listen((data) {
      Replies reply = Replies.fromJson(jsonDecode(data)['comment_data']);
      comments[index].replies!.insert(0, reply);
      notifyListeners();
    }, onDone: () {
      debugPrint("Reply Socket disconnected");
    });
  }

  channelDismiss() {
    channel.sink.close();
    notifyListeners();
  }

  replyChannelDismiss() {
    replyChannel.sink.close();
    notifyListeners();
  }

  initializeSocket(int postID) {
    channel = IOWebSocketChannel.connect('wss://als-social.com/ws/post/$postID/comment/timeline_post/');
    userPostComments();
  }

  initializeSinglePostSocket(String url) {
    channel = IOWebSocketChannel.connect('wss://als-social.com/ws${url.replaceAll('posts', 'post')}comment/timeline_post/');
    userPostComments();
  }

  initializeReplySocket(int postID, int index) {
    replyChannel = IOWebSocketChannel.connect('wss://als-social.com/ws/post/$postID/comment/timeline_post/');
    userReplyComments(index);
  }

  changeExpandedForOpen(int index, int postID, int commentID) {
    isOpenComment[index] = !isOpenComment[index];
    if (isOpenComment[index]) {
      initializeReplySocket(postID + commentID, index);
    } else {
      replyChannelDismiss();
    }
    for (int i = 0; i < isOpenComment.length; i++) {
      if (i == index) continue;
      isOpenComment[i] = false;
    }
    notifyListeners();
  }

  bool isReplyButtonLoading = false;

  Future<bool> addReply(String comment, String url, int index) async {
    isReplyButtonLoading = true;
    Response response = await commentRepo.addReply(url, comments[index].id.toString(), comment);
    isReplyButtonLoading = false;
    if (response.statusCode == 201) {
      Replies c = Replies(
        id: response.body['id'],
        comment: response.body['comment'],
        post: response.body['post'],
        parent: response.body['parent'],
        author: Author(
            id: response.body['author']['id'],
            fullName: response.body['author']['full_name'],
            profileImage: response.body['author']['profile_image']),
      );
      debugPrint(jsonEncode({"data": c.toJson()}));
      replyChannel.sink.add(jsonEncode({"data": c.toJson()}));
      notifyListeners();
      return true;
    } else {
      Fluttertoast.showToast(msg: "Something went wrong");
      return false;
    }
  }
}
