import 'package:als_frontend/model/post/page_post_model.dart';
import 'package:als_frontend/service/post/page_post_service.dart';
import 'package:flutter/material.dart';

class PagePostProvider extends ChangeNotifier {
  List<PagePostModel>? pagePosts = [];
  var isLoaded = false;
  int id = 0;
  int index = 0;
  Future<void> getData() async {
    pagePosts = (await PagePostService(id: id).getPagePost());
    notifyListeners();
    if (pagePosts != null) {
      isLoaded = true;
      notifyListeners();
    }
  }
}
