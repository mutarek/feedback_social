import 'package:flutter/material.dart';

import '../../../service/group page/author_page_details_service.dart';

class AuthorPageDetailsProvider extends ChangeNotifier {
  var pageDetails;
  var isLoaded = false;
  int pageIndex = 0;
  List<String> postImages = [];
  Future<void> getData() async {
    pageDetails = (await AuthorPageDetailsService(pageIndex: pageIndex).getPages());
    notifyListeners();
    if (pageDetails != null) {
      isLoaded = true;
      notifyListeners();
    }
  }
}
