import 'package:als_frontend/model/post/author_newsfeed_post_model.dart';
import 'package:als_frontend/service/like/timeline_post_like_service.dart';
import 'package:als_frontend/service/post/author_newsfeed_post_service.dart';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserNewsfeedPostProvider extends ChangeNotifier {
  var authorPosts;
  List<NewsfeedModels> authorPostResults = [];
  var isLoaded = false;
  int id = 0;
  int index = 0;
  int page = 1;

  List<int> likesStatusAllData = [];

  Future<void> getData() async {
    authorPosts = (await AuthorNewsfeedPostService(id: id).getAuthorPost(page));
    authorPostResults.addAll(authorPosts.results);
    initializeLikedData();
    page = page + 1;
    notifyListeners();

    if (authorPostResults != null) {
      isLoaded = true;
      notifyListeners();
    }
  }

  initializeLikedData() async {
    likesStatusAllData = [];
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int id = (prefs.getInt('id') ?? 0);
    int status = 0;
    for (int i = 0; i < authorPostResults.length; i++) {
      status = 0;
      likesStatusAllData.add(0);
      authorPostResults[i].likedBy!.forEach((e) {
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
    authorPostResults[index].totalComment = authorPostResults[index].totalComment! + 1;
    notifyListeners();
  }

  addLike(int postID, int index) async {
    bool status = await TimelinePostLikeService.addLiked(postID);
    if (status == true) {
      likesStatusAllData[index] = 1;
      authorPostResults[index].totalLike = authorPostResults[index].totalLike! + 1;
    } else {
      likesStatusAllData[index] = 0;
      authorPostResults[index].totalLike = authorPostResults[index].totalLike! - 1;
    }
    notifyListeners();
  }
}
