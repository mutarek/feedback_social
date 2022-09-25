import 'package:als_frontend/model/post/author_newsfeed_post_model.dart';
import 'package:als_frontend/service/post/author_newsfeed_post_service.dart';
import 'package:flutter/material.dart';

class PublicNewsfeedPostProvider extends ChangeNotifier {
  var authorPosts;
  List<Result> authorPostResults = [];
  bool hasdata = true;
  var isLoaded = false;
  int? id;
  int index = 0;
  int page = 1;
  Future<void> getData() async {
    authorPosts =
        (await AuthorNewsfeedPostService(id: id!).getAuthorPost(page));
    authorPostResults.addAll(authorPosts.results);
    if (authorPosts.length < 5) {
      hasdata = false;
    }
    page = page + 1;
    notifyListeners();

    if (authorPostResults != null) {
      isLoaded = true;
      notifyListeners();
    }
  }
}
