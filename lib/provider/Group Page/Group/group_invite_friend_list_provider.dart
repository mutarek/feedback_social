import 'package:als_frontend/service/profile/User/friends_list_service.dart';
import 'package:als_frontend/service/services.dart';
import 'package:flutter/material.dart';

import '../../../model/model.dart';

class GroupInviteFriendListProvider extends ChangeNotifier {
  List<FriendListModel> friendsList = [];
  var isLoaded = false;
  bool connection = false;
  int groupId = 0;
  bool friendsListHasData = false;

  Future<void> getData() async {
    friendsList = [];
    isLoaded = false;
    
    print(isLoaded);
    try {
      friendsList = (await GroupInviteFriendListService(groupId: groupId)
          .getFriendsList())!;
      notifyListeners();
      if (friendsList.isNotEmpty) {
        isLoaded = true;
        notifyListeners();
      }
    } catch (e) {
      print("Friend request provider: $e");
    }
    print(isLoaded);
  }
}
