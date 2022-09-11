import 'package:flutter/material.dart';

import '../../../model/model.dart';
import '../../../service/friends/search_group_friend_list._service.dart';

class GroupFriendSearchProvider extends ChangeNotifier {
  List<FriendListModel> friendsList = [];
  var isLoaded = false;
  bool connection = false;
  int groupId = 0;
  bool friendsListHasData = false;
  String value = "";

  Future<void> getData() async {
    try {
      friendsList = (await SearchGroupFriendListService(groupId: groupId, value: value)
          .getFriendsList())!;
      notifyListeners();
      if (friendsList.isNotEmpty) {
        isLoaded = true;
        notifyListeners();
      }
    } catch (e) {
      print("Friend request provider: $e");
    }
  }
}
