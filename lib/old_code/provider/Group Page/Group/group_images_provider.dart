import 'package:als_frontend/old_code/model/group%20page/group/group_images_model.dart';
import 'package:als_frontend/old_code/service/group%20page/group_images_service.dart';
import 'package:flutter/material.dart';

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
