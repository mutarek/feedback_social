
import 'package:flutter/material.dart';

import '../../../../data/model/response/group/all_group_model.dart';
import '../../../service/services.dart';

class AllGroupProvider extends ChangeNotifier {
  List<AllGroupModel>? groups = [];
  var isLoaded = false;
  int pageIndex = 0;
  int singleImageIndex = 0;
  String postCaption = "";
  List<String> postImages = [];
  Future<void> getData() async {
    groups = (await AllGroupsService().getPages());
    notifyListeners();
    if (groups != null) {
      isLoaded = true;
      notifyListeners();
    }
  }
}