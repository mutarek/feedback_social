import 'package:als_frontend/data/model/response/notification_model.dart';
import 'package:als_frontend/data/repository/auth_repo.dart';
import 'package:als_frontend/data/repository/notification_repo.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class NotificationProvider with ChangeNotifier {
  final NotificationRepo notificationRepo;
  final AuthRepo authRepo;

  NotificationProvider({required this.notificationRepo, required this.authRepo});

  bool isLoading = false;
  late WebSocketChannel webSocketChannel;
  int notificationCount = 0;

  void notificationUnread() async {
    Response response = await notificationRepo.getNotificationUnreadCount();
    if (response.statusCode == 200) {
      notificationCount = response.body['count'];
    } else {
      Fluttertoast.showToast(msg: response.statusText!);
    }
    notifyListeners();
  }

  void notificationRead() async {
    Response response = await notificationRepo.getNotificationReadCount();
    if (response.statusCode == 200) {
      notificationCount = 0;
    } else {
      Fluttertoast.showToast(msg: response.statusText!);
    }
    notifyListeners();
  }

  check() {
    webSocketChannel = WebSocketChannel.connect(Uri.parse("wss://feedback-social.com/ws/notifications/${authRepo.getUserToken()}/"));
    webSocketChannel.stream.listen((event) {
      notificationUnread();
      initializeNotification(isFirstTime: false, isDataAddLast: false);
    }, onDone: () {
      check();
    });
  }

  List<NotificationModel> notificationLists = [];

  bool hasNextData = false;
  bool isBottomLoading = false;
  int selectPage = 1;

  //TODO: for get All Notification Lists

  updatePageNo() {
    selectPage++;
    initializeNotification(page: selectPage, isFirstTime: false);
    notifyListeners();
  }

  initializeNotification({int page = 1, bool isFirstTime = true, bool isFirstTimeLoading = true, bool isDataAddLast = true}) async {
    if (page == 1 && isFirstTime) {
      selectPage = 1;
      notificationLists.clear();
      notificationLists = [];
      isLoading = true;
      isBottomLoading = false;
      hasNextData = false;
      if (!isFirstTimeLoading) {
        notifyListeners();
      }
    } else {
      isBottomLoading = true;
      notifyListeners();
    }

    Response response = await notificationRepo.getAllNotification(page);
    isLoading = false;
    isBottomLoading = false;
    if (response.statusCode == 200 && response.body.isNotEmpty) {
      hasNextData = response.body['next'] != null ? true : false;
      response.body['results'].forEach((element) {
        NotificationModel notificationModel = NotificationModel.fromJson(element);
        bool status = notificationLists.any((element) => element.id == notificationModel.id);
        if (!status) {
          if (isDataAddLast) {
            notificationLists.add(notificationModel);
          } else {
            notificationLists.insert(0, notificationModel);
          }
        }
      });
    } else {
      Fluttertoast.showToast(msg: 'No More Data..');
    }
    notifyListeners();
  }

  channelDismiss() {
    // if (webSocketChannel.sink.isBlank!) {
    //   webSocketChannel.sink.close();
    //   notifyListeners();
    // }
  }
}
