import 'package:als_frontend/old_code/model/Block/blocklist.dart';
import 'package:als_frontend/old_code/service/block/block_list_service.dart';
import 'package:flutter/material.dart';

class BlockUpProvider extends ChangeNotifier {
  List<BlocklistModel> blocklist = [];
  var isLoaded = false;
  bool connection = false;
  bool friendsListHasData = false;

  Future<void> getData() async {
    try {
      blocklist = (await BlockListService().getblocklistdata())!;
      notifyListeners();
      if (blocklist.isNotEmpty) {
        isLoaded = true;
        notifyListeners();
      }
    } catch (e) {
      print("Friend request provider: $e");
    }
  }
}
