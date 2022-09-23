import 'package:als_frontend/model/post/author_newsfeed_post_model.dart';
import 'package:als_frontend/service/post/author_newsfeed_post_service.dart';

import 'package:flutter/material.dart';

class UserNewsfeedPostProvider extends ChangeNotifier {
  var authorPosts;
  List<Result> authorPostResults = [];
  var isLoaded = false;
  int id = 0;
  int index = 0;
  int page = 1;
  Future<void> getData() async {
    authorPosts = (await AuthorNewsfeedPostService(id: id).getAuthorPost(page));
    authorPostResults.addAll(authorPosts.results);
    page = page + 1;
    print(page);
    notifyListeners();

    if (authorPostResults != null) {
      isLoaded = true;
      notifyListeners();
    }
  }
}
