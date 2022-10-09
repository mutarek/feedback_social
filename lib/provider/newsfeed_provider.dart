import 'package:als_frontend/data/repository/newsfeed_repo.dart';
import 'package:als_frontend/old_code/model/post/news_feed_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_connect/http/src/response/response.dart';

class NewsFeedProvider with ChangeNotifier {
  final NewsfeedRepo newsFeedRepo;

  NewsFeedProvider({required this.newsFeedRepo});

  List<NewsFeedData> newsFeedLists = [];
  bool isLoading = false;
  bool isBottomLoading = false;
  int selectPage = 1;

  updatePageNo() {
    selectPage++;
    initializeAllFeedData((bool status){},page: selectPage);
    notifyListeners();
  }

  initializeAllFeedData(Function callBackFunction,{int page = 1}) async {
    if (page == 1) {
      selectPage = 1;
      newsFeedLists.clear();
      newsFeedLists = [];
      isLoading = true;
      isBottomLoading = false;
    } else {
      isBottomLoading = true;
      notifyListeners();
    }

    Response response = await newsFeedRepo.getNewsFeedData(page);
    isLoading = false;
    isBottomLoading = false;
    callBackFunction(true);
    if (response.statusCode == 200) {
      response.body['results'].forEach((element) {
        newsFeedLists.add(NewsFeedData.fromJson(element));
      });
    } else {
      Fluttertoast.showToast(msg: response.statusText!);
    }
    notifyListeners();
  }
}
