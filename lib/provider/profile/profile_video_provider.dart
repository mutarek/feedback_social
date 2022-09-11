import 'package:als_frontend/service/profile/profile_videos_services.dart';
import 'package:flutter/material.dart';

import '../../model/model.dart';

class ProfileVideosProvider extends ChangeNotifier {
  List<ProfileVideoModel>? videos = [];
  var isLoaded = false;
  int userId = 0;
  String imageUrl = "";
  Future<void> getData() async {
    videos = (await ProfileVideosService(userId: userId).getProfileImages())!;
    notifyListeners();
    if (videos != null) {
      isLoaded = true;
      notifyListeners();
    }
  }
}
