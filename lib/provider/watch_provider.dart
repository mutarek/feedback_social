import 'package:als_frontend/data/model/response/base/api_response.dart';
import 'package:als_frontend/data/model/response/watch_list_model.dart';
import 'package:als_frontend/data/repository/watch_repo.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';

class WatchProvider with ChangeNotifier{
  final WatchRepo watchRepo;
  WatchProvider({required this.watchRepo});

  int position = 0;
  List<WatchListModel> watchLists = [];
  bool isLoading = false;
  bool isBottomLoading = false;
  int selectPage = 1;
  bool hasNextData = false;

  updatePageNo() {
    selectPage++;
    getWatchList(page: selectPage);
    notifyListeners();
  }

  getWatchList({int page = 1, bool isFirstTime = true}) async {
    if (page == 1) {
      selectPage = 1;
      watchLists.clear();
      watchLists = [];
      isLoading = true;
      hasNextData = false;
      isBottomLoading = false;
      position = 0;
      notifyListeners();
      ApiResponse response = await watchRepo.getAllVideos(page);
      isLoading = false;
      isBottomLoading = false;
      if (response.response.statusCode == 200) {
        hasNextData = response.response.data['next'] != null ? true : false;
        response.response.data['results'].forEach((element) {
          watchLists.add(WatchListModel.fromJson(element));
        });
      } else {
        Fluttertoast.showToast(msg: response.response.statusMessage!);
      }
      notifyListeners();
    }
  }
}