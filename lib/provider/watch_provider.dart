import 'dart:async';
import 'dart:math';
import 'package:als_frontend/data/model/response/base/api_response.dart';
import 'package:als_frontend/data/model/response/watch_list_model.dart';
import 'package:als_frontend/data/repository/watch_repo.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';

class WatchProvider with ChangeNotifier {
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

  getWatchList(
      {int page = 1,
      bool isFirstTime = true,
      WatchListModel? watchListModel}) async {
    if (page == 1) {
      selectPage = 1;
      watchLists.clear();
      watchLists = [];
      isLoading = true;
      hasNextData = false;
      isBottomLoading = false;
      position = 0;
      // notifyListeners();
      if (watchListModel != null) watchLists.add(watchListModel);
    }
    ApiResponse response = await watchRepo.getAllVideos(page);
    isLoading = false;
    isBottomLoading = false;
    if (response.response.statusCode == 200) {
      response.response.data['next'] != null ? true : false;
      response.response.data['results'].forEach((element) {
        watchLists.add(WatchListModel.fromJson(element));
      });
    } else {
      Fluttertoast.showToast(msg: response.response.statusMessage!);
    }
    notifyListeners();
  }

  late Timer _timer;
  late Random _random;
  String annotationValue = '80 %';
  double pointerValue = 50;

  void customProgress() {
    _random = Random();
    _timer = Timer.periodic(const Duration(milliseconds: 1200), (timer) {
      int value = _random.nextInt(100);
      if (value > 4 && value < 100) {
        pointerValue = value.toDouble();
        annotationValue = '$value %';
        notifyListeners();
      }
      notifyListeners();
    });
  }

  addLike(int postID, int index,
      {bool isFromPerson = true,
      bool isFromGroup = false,
      bool isFromPage = false,
      int groupPageId = 0}) async {
    if (watchLists[index].isLiked == false) {
      watchLists[index].totalLiked = watchLists[index].totalLiked! + 1;
      watchLists[index].isLiked = true;
      notifyListeners();
    } else {
      watchLists[index].totalLiked = watchLists[index].totalLiked! - 1;
      watchLists[index].isLiked = false;
      notifyListeners();
    }
    notifyListeners();
    await watchRepo.addLike(postID,
        isGroup: isFromGroup, isFromLike: isFromPage, groupPageID: groupPageId);
  }
}
