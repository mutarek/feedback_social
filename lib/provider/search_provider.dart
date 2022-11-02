import 'package:als_frontend/data/model/response/search_model.dart';
import 'package:als_frontend/data/repository/search_repo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_connect/http/src/response/response.dart';

class SearchProvider with ChangeNotifier {
  final SearchRepo searchRepo;

  SearchProvider({required this.searchRepo});

  bool isLoading = false;
  SearchModel searchModel = SearchModel();

  searchQuery(String query) async {
    isLoading = true;
    searchModel = SearchModel();
    notifyListeners();
    Response response = await searchRepo.searchData(query);
    isLoading = false;
    isFirstTime = false;
    if (response.statusCode == 200 && response.body.isNotEmpty) {
      searchModel = SearchModel.fromJson(response.body);
    } else {
      Fluttertoast.showToast(msg: response.statusText!);
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
