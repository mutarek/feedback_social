import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:http/http.dart' as http;
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../const/url.dart';
import '../../model/notification/notifications_model.dart';

class NotificationsProvider extends ChangeNotifier {
  late WebSocketChannel webSocketChannel;

  bool loading = true;
  List<Result> data = [];
  String token = "";
  int? id;
  int? userId;
  int? notificationId;
  int notificationCount = 0;
  NotificationModel notificationData = NotificationModel();

  void getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? '');
    userId = (prefs.getInt('id') ?? '') as int;
    var uri = Uri.parse("$baseUrl/notification/list/"),
        headers = {'Authorization': 'token $token'};
    var response = await http.get(uri, headers: headers);
    notificationData = NotificationModel.fromJson(json.decode(response.body));

    data = notificationData.results as List<Result>;
    
    loading = false;
    notifyListeners();
  }

  void notificationRead() async {
    var apiUrl = "$baseUrl/notification/counter/read/";

    Map mappeddata = {};

    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? '');
    var uri = Uri.parse(apiUrl), headers = {'Authorization': 'token $token'};
    var response = await http.post(uri, body: mappeddata, headers: headers);
  }

  void notificationUnread() async {
    var apiUrl = "$baseUrl/notification/count/unread/";

    Map mappeddata = {};

    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? '');
    var uri = Uri.parse(apiUrl), headers = {'Authorization': 'token $token'};
    var response = await http.post(uri, body: mappeddata, headers: headers);
    var body = jsonDecode(response.body);
    notificationCount = body['count'];
    notifyListeners();
  }

  void tappedOnNotification() async {
    var apiUrl = "$baseUrl/notification/read/$notificationId/";

    Map mappeddata = {};

    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? '');
    var uri = Uri.parse(apiUrl), headers = {'Authorization': 'token $token'};
    var response = await http.post(uri, body: mappeddata, headers: headers);
  }

  check() {
    webSocketChannel = WebSocketChannel.connect(
        Uri.parse("wss://als-social.com/ws/notifications/$token/"));
    webSocketChannel.stream.listen((event) {
      print("Notification user token : $token");
      notificationUnread();
      getData();
    }, onDone: () {
      check();
    });
    // webSocketChannel.sink.add(jsonEncode({
    //   'data': {
    //     'description': "nasdjnsdnasdnsa",
    //     'notice_type': "friend",
    //     'verb': "post",
    //     'url': "http://localhost:8000/admin/",
    //   },
    //   'action': "notification",
    // }));
  }
}
