import 'dart:io';

import 'package:als_frontend/service/like/timeline_post_like_service.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/model.dart';
import '../../service/post/post_services.dart';

class NewsFeedPostProvider extends ChangeNotifier {
  // ignore: prefer_typing_uninitialized_variables
  var posts;
  List<Result> results = [];
  var isLoaded = false;
  int index = 0;
  int singleImageIndex = 0;
  String postCaption = "";
  List<String> postImages = [];
  bool connection = false;
  int? id;
  int page = 1;
  List<int> likesStatusAllData = [];
  void checkConnection() async {
    try {
      final result = await InternetAddress.lookup('www.google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        connection = true;
        notifyListeners();
      }
    } on SocketException catch (_) {
      connection = false;
      notifyListeners();
    }
  }

  Future<void> getData() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      id = (prefs.getInt('id') ?? '') as int;

      posts = (await PostService().getPosts(page))!;
      results.addAll(posts.results);
      initializeLikedData();
      page = page + 1;
      notifyListeners();
      if (posts != null) {
        isLoaded = true;
        notifyListeners();
      }
    } catch (e) {
      print("Newsfeed exception : $e");
    }
  }

  Future<void> refresh() async {
    getData();
  }

  initializeLikedData() async {
    likesStatusAllData = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int id = (prefs.getInt('id') ?? 0);
    int status = 0;
    for (int i = 0; i < results.length; i++) {
      status = 0;
      likesStatusAllData.add(0);
      results[i].likedBy!.forEach((e) {
        if (e.id == id) {
          status = 1;
          return;
        }
      });
      if (status == 0) {
        likesStatusAllData[i] = 0;
      } else {
        likesStatusAllData[i] = 1;
      }
    }
    likesStatusAllData.add(0);
    notifyListeners();
  }


  void updateCommentDataCount(int index) {
    results[index].totalComment = results[index].totalComment! + 1;
    notifyListeners();
  }

  addLike(int postID, int index) async {
    bool status = await TimelinePostLikeService.addLiked(postID);
    if (status == true) {
      likesStatusAllData[index] = 1;
      results[index].totalLike = results[index].totalLike! + 1;
    } else {
      likesStatusAllData[index] = 0;
      results[index].totalLike = results[index].totalLike! - 1;
    }
    notifyListeners();
  }

}
