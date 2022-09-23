import 'package:als_frontend/service/profile/profile_images_service.dart';
import 'package:flutter/material.dart';

import '../../model/model.dart';

class ProfileImagesProvider extends ChangeNotifier {
  List<ProfileImagesModel>? images = [];
  var isLoaded = false;
  int userId = 0;
  String imageUrl = "";
  Future<void> getData() async {
    images = (await ProfileImagesService(userId: userId).getProfileImages())!;
    notifyListeners();
    print(userId);
    if (images != null) {
      isLoaded = true;
      notifyListeners();
    }
  }
}
