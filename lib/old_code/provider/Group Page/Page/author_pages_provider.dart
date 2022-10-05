import 'package:flutter/material.dart';

import '../../../model/model.dart';
import '../../../service/services.dart';

class AuthorPagesProvider extends ChangeNotifier {
  List<AuthorPageModel>? pages = [];
  var isLoaded = false;
  int pageIndex = 0;
  int singleImageIndex = 0;
  String postCaption = "";
  List<String> postImages = [];
  Future<void> getData() async {
    pages = (await AuthorPagesService().getPages());
    notifyListeners();
    if (pages != null) {
      isLoaded = true;
      notifyListeners();
    }
  }
}
