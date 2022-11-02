import 'package:als_frontend/old_code/model/model.dart';
import 'package:als_frontend/old_code/service/group%20page/page_video_service.dart';
import 'package:flutter/material.dart';

class PageVideoProvider extends ChangeNotifier {
  List<ProfileVideoModel>? videos = [];
  var isLoaded = false;
  int pageId = 0;
  Future<void> getData() async {
    videos = (await PageVideoService(pageId: pageId).getPageImages())!;
    notifyListeners();
    if (videos != null) {
      isLoaded = true;
      notifyListeners();
    }
  }
}
