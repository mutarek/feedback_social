import 'package:als_frontend/data/model/response/base/api_response.dart';
import 'package:als_frontend/data/repository/test/search_repo1.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../data/model/response/search_model.dart';

class SearchProvider1 with ChangeNotifier{
  final SearchRepo1 searchRepo;

  SearchProvider1({required this.searchRepo});

  bool isLoading = false;
  SearchModel searchModel = SearchModel();

  searchQuery(String query) async {
    isLoading = true;
    searchModel = SearchModel();
    notifyListeners();
    ApiResponse response = await searchRepo.searchData(query);
    isLoading = false;
    isFirstTime = false;
    if (response.response.statusCode == 200 && response.response.data.isNotEmpty) {
      searchModel = SearchModel.fromJson(response.response.data);
    } else {
      Fluttertoast.showToast(msg: response.response.statusMessage!);
    }
    notifyListeners();
  }
  int value = 1;

  changeValue(int status) {
    value = status;
    notifyListeners();
  }

  bool isFirstTime = false;
  resetFirstTime(){
    isFirstTime = true;
  }
}