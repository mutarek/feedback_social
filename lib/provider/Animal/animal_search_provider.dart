import 'package:flutter/material.dart';

import '../../model/model.dart';
import '../../service/services.dart';

class AnimalSearchProvider extends ChangeNotifier {
  String code = "";
  int searchIndex = 0;
  List<AnimalSearchResultModel>? searchResult = [];
  var loading = true;
  Future<void> getResultData() async {
    try {
      searchResult = (await SearchAnimalService(code).getSearchResult());
      notifyListeners();
      if (searchResult != null) {
        loading = false;
        notifyListeners();
      }
    } catch (e) {
      print("Animal search provider: $e");
    }
  }
}
