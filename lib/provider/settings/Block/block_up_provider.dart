import 'package:flutter/material.dart';

import '../../../model/Block/blocklist.dart';
import '../../../service/block/block_list_service.dart';

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
