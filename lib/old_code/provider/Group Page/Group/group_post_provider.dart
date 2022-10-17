import 'package:als_frontend/data/model/response/group/group_post_model.dart';
import 'package:als_frontend/old_code/service/post/group_post_provider_service.dart';

import 'package:flutter/material.dart';

class GroupPostProvider extends ChangeNotifier {
  List<GroupPostModel>? groupPosts = [];
  var isLoaded = false;
  int id = 0;
  int index = 0;

  Future<void> getData() async {
    groupPosts = (await GroupPostService(id: id).getGroupPost());
    notifyListeners();
    if (groupPosts != null) {
      isLoaded = true;
      notifyListeners();
    }
  }
}
