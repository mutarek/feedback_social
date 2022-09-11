import 'package:als_frontend/model/post/author_newsfeed_post_model.dart';
import 'package:als_frontend/service/post/author_newsfeed_post_service.dart';

import 'package:flutter/material.dart';

class UserNewsfeedPostProvider extends ChangeNotifier {
  List<AuthorNewsFeedPostModel>? authorPosts = [];
  var isLoaded = false;
  int id = 0;
  int index = 0;
  Future<void> getData() async {
    authorPosts = (await AuthorNewsfeedPostService(id: id).getAuthorPost());
    notifyListeners();
    if (authorPosts != null) {
      isLoaded = true;
      notifyListeners();
    }
  }
}
