import 'package:als_frontend/data/model/response/group/friends_list_model.dart';
import 'package:als_frontend/old_code/service/friends/search_group_friend_list._service.dart';
import 'package:flutter/material.dart';

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
