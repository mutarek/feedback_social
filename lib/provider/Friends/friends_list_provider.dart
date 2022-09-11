import 'package:als_frontend/service/profile/User/friends_list_service.dart';
import 'package:flutter/material.dart';

import '../../model/model.dart';

class FriendsListProvider extends ChangeNotifier {
  List<FriendListModel> friendsList = [];
  var isLoaded = false;
  bool connection = false;
  bool friendsListHasData = false;

  Future<void> getData() async {
    try {
      friendsList = (await FriendsListService().getFriendsList())!;
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
