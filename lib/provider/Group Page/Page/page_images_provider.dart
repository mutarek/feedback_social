import 'package:als_frontend/model/model.dart';
import 'package:als_frontend/service/group%20page/page_images_service.dart';
import 'package:flutter/material.dart';


class PageImagesProvider extends ChangeNotifier {
  List<PageImagesModel>? images = [];
  var isLoaded = false;
  int pageId = 0;
  Future<void> getData() async {
    images = (await PageImagesService(pageId: pageId).getPageImages())!;
    notifyListeners();
    if (images != null) {
      isLoaded = true;
      notifyListeners();
    }
  }
}
