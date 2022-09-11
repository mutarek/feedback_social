import 'package:als_frontend/model/post/single_post_model.dart';
import 'package:als_frontend/service/post/single_post_service.dart';
import 'package:flutter/material.dart';

class SinglePostProvider extends ChangeNotifier {
  var post;
  Author? author;
  var loading = false;
  int id = 0;
  String url = "";
  String? description;
  Future<void> getUserData() async {
    post = (await SinglePostService(url: url).getData());
    author = post.author;
    notifyListeners();
    if (post != null) {
      loading = true;
      notifyListeners();
    }
  }
}
