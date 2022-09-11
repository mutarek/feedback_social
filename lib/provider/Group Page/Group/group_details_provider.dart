import 'package:flutter/material.dart';

import '../../../service/group page/group_details_service.dart';

class GroupDetailsProvider extends ChangeNotifier {
  var groupDetails;
  var isLoaded = false;
  int groupIndex = 0;
  List<String> postImages = [];
  Future<void> getData() async {
    groupDetails =
        (await GroupDetailsService(groupIndex: groupIndex).getgroups());
    notifyListeners();
    if (groupDetails != null) {
      isLoaded = true;
      notifyListeners();
    }
  }
}
