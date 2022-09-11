import 'dart:io';

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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    id = (prefs.getInt('id') ?? '') as int;

    posts = (await PostService().getPosts())!;
    results = posts.results;
    notifyListeners();
    if (posts != null) {
      isLoaded = true;
      notifyListeners();
    }
  }

  Future<void> refresh() async {
    getData();
  }
}
