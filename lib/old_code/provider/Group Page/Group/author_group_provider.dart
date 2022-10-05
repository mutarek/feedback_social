import 'package:flutter/material.dart';

import '../../../model/model.dart';
import '../../../service/services.dart';

class AuthorGroupProvider extends ChangeNotifier {
  List<AuthorGroupModel>? groups = [];
  var isLoaded = false;
  int pageIndex = 0;
  int singleImageIndex = 0;
  String postCaption = "";
  List<String> postImages = [];
  Future<void> getData() async {
    groups = (await AuthorGroupService().getGroups());
    notifyListeners();
    if (groups != null) {

      isLoaded = true;
      notifyListeners();
    }
  }
}
