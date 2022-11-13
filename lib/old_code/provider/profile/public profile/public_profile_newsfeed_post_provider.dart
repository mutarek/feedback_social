import 'package:als_frontend/old_code/model/post/author_newsfeed_post_model.dart';
import 'package:als_frontend/old_code/service/post/author_newsfeed_post_service.dart';
import 'package:flutter/material.dart';

class PublicNewsfeedPostProvider extends ChangeNotifier {
  var authorPosts;
  List<NewsfeedModels> authorPostResults = [];
  bool hasdata = true;
  var isLoaded = false;
  int? id;
  int index = 0;
  int page = 1;

  Future<void> getData() async {
    authorPosts = (await AuthorNewsfeedPostService(id: id!).getAuthorPost(page));
    authorPostResults.addAll(authorPosts.publicNewsFeedLists);
    if (authorPostResults.length < 5) {
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