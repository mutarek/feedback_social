import 'package:als_frontend/data/model/response/base/api_response.dart';
import 'package:als_frontend/data/model/response/notification_model.dart';
import 'package:als_frontend/data/repository/auth_repo.dart';
import 'package:als_frontend/data/repository/notification_repo.dart';
import 'package:als_frontend/util/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class NotificationProvider with ChangeNotifier {
  final NotificationRepo notificationRepo;
  final AuthRepo authRepo;

  NotificationProvider({required this.notificationRepo, required this.authRepo});

  bool isLoading = false;
  late WebSocketChannel webSocketChannel;
  int notificationCount = 0;

  void notificationUnread() async {
    ApiResponse response = await notificationRepo.getNotificationUnreadCount();
    if (response.response.statusCode == 200) {
      notificationCount = response.response.data['count'];
    } else {
      Fluttertoast.showToast(msg: response.response.statusMessage!);
    }
    notifyListeners();
  }

  void notificationRead() async {
    notificationCount = 0;
    ApiResponse response = await notificationRepo.getNotificationReadCount();
    if (response.response.statusCode == 200) {
      notificationCount = 0;
    } else {
      Fluttertoast.showToast(msg: response.response.statusMessage!);
    }
    notifyListeners();
  }

  check() {
    webSocketChannel = WebSocketChannel.connect(Uri.parse("${AppConstant.socketBaseUrl}ws/notifications/${authRepo.getUserToken()}/"));
    webSocketChannel.stream.listen((event) {
      notificationUnread();
      initializeNotification(isFirstTime: false, isDataAddLast: false);
    }, onDone: () async {
      await Future.delayed(const Duration(seconds: 5));
      check();
    }, onError: (e) async {
      debugPrint('Server error: $e');
      await Future.delayed(const Duration(seconds: 5));
      check();
    }, cancelOnError: true);
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

    ApiResponse response = await notificationRepo.getAllNotification(page);
    isLoading = false;
    isBottomLoading = false;
    if (response.response.statusCode == 200 && response.response.data.isNotEmpty) {
      hasNextData = response.response.data['next'] != null ? true : false;
      response.response.data['results'].forEach((element) {
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
    if (webSocketChannel.isBlank != null && webSocketChannel.isBlank!) {
      webSocketChannel.sink.close();
      notifyListeners();
    }
  }
}
