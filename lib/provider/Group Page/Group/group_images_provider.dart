import 'package:flutter/material.dart';

import '../../../model/group page/group/group_images_model.dart';
import '../../../service/group page/group_images_service.dart';

class GroupImagesProvider extends ChangeNotifier {
  List<GroupImagesModel>? images = [];
  var isLoaded = false;
  int groupId = 0;
  Future<void> getData() async {
    images = (await GroupImagesService(groupId: groupId).getGroupImages())!;
    notifyListeners();
    if (images != null) {
      isLoaded = true;
      notifyListeners();
    }
  }
}
