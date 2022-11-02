import 'package:als_frontend/old_code/model/model.dart';
import 'package:als_frontend/old_code/service/group%20page/group_videos_service.dart';
import 'package:flutter/material.dart';

class GroupVideoProvider extends ChangeNotifier {
  List<ProfileVideoModel>? videos = [];
  var isLoaded = false;
  int groupId = 0;
  Future<void> getData() async {
    videos = (await GroupVideosService(groupId: groupId).getGroupImages())!;
    notifyListeners();
    if (videos != null) {
      isLoaded = true;
      notifyListeners();
    }
  }
}
