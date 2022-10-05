import 'package:flutter/material.dart';
import '../../model/model.dart';
import '../../service/services.dart';

class FriendRequestProvider extends ChangeNotifier {
  List<FriendsRequestModel> friendRequests = [];
  List<FriendsSuggetionsModel> friendsSuggetions = [];
  bool hasData = false;
  bool suggetionsHasData = false;
  int index = 0;
  int singleImageIndex = 0;
  String postCaption = "";
  List<String> postImages = [];

  bool showSuggetions = false;

  void friendRequest() {
    showSuggetions = false;
    notifyListeners();
  }

  void friendSuggestion() {
    showSuggetions = true;
    notifyListeners();
  }

  Future<void> getData() async {
    try {
      friendRequests = (await FriendRequestService().getFriendRequests())!;
      notifyListeners();
      if (friendRequests.isNotEmpty) {
        hasData = true;
        notifyListeners();
      }
    } catch (e) {
      print("Friend Request Provider: $e");
    }
  }

  Future<void> getSuggetionsData() async {
    try {
      friendsSuggetions =
          (await FriendSuggetionsService().getFriendsSuggetions())!;
      notifyListeners();
      if (friendRequests.isNotEmpty) {
        suggetionsHasData = true;
        notifyListeners();
      }
    } catch (e) {
      print("Friend request provider: $e");
    }
  }
}
