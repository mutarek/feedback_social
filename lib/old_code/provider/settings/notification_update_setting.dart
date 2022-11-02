import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../const/url.dart';

class NotificationUpdateProvider extends ChangeNotifier {
  String message = "";
  bool success = false;
  bool loading = false;
  String? token;

  bool likepost = true;
  void likebool() {
    likepost = !likepost;
    notifyListeners();
  }

  bool sharepost = true;
  void sharebool() {
    sharepost = !sharepost;
    notifyListeners();
  }

  bool commentpost = true;
  void commentbool() {
    commentpost = !commentpost;
    notifyListeners();
  }

  bool follow = true;
  void followbool() {
    follow = !follow;
    notifyListeners();
  }

  bool waiting = true;
  void waitingbool() {
    waiting = !waiting;
    notifyListeners();
  }

  bool friendpost = true;
  void friendpostBool() {
    friendpost = !friendpost;
    notifyListeners();
  }

  bool milstonealart = true;
  void mailstonealrtbool() {
    milstonealart = !milstonealart;
    notifyListeners();
  }

  bool winaword = true;
  void winawordbool() {
    winaword = !winaword;
    notifyListeners();
  }

  bool pointaword = true;
  void pointawordbool() {
    pointaword = !pointaword;
    notifyListeners();
  }

  Future<void> updateNotification(
    String isLikedPost,
    String isSharePost,
    String isCommentPost,
    String isFollowerAlert,
    String isWattingAlert,
    String isFriendPostAlert,
    String isMilestoneAward,
    String isIconWinsAward,
    String isPoinWinsAward,
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? '');

    var uri = Uri.parse("$baseUrl/accounts/settings/notification/");

    Map<String, String> headers = <String, String>{
      "Authorization": 'token $token',
    };

    Map mappeddata = {
      "is_like_post": isLikedPost,
      "is_share_post": isSharePost,
      "is_comment_post": isCommentPost,
      "is_follower_alert": isFollowerAlert,
      "is_waiting_alert": isWattingAlert,
      "is_friend_post_alert": isFriendPostAlert,
      "is_milestone_alert": isMilestoneAward,
      "is_icon_wins_award": isIconWinsAward,
      "is_point_wins_award": isPoinWinsAward
    };

    http.Response response =
        await http.patch(uri, body: mappeddata, headers: headers);
    print(response.statusCode);

    var data = jsonDecode(response.body);
    print(data);
    if (response.statusCode == 200) {
      success = true;
      notifyListeners();
    } else {
      success = false;
      notifyListeners();
    }

    // try {
    //   final request = http.MultipartRequest("PUT", uri)
    //     ..headers.addAll(headers)
    //     ..fields.addAll(requestBody);

    //   var response = await request.send();
    //   final respStr = await response.stream.bytesToString();
    //   spinner = false;
    //   notifyListeners();
    //   print(response.statusCode);
    //   print(respStr);
    // } catch (e) {
    //   debugPrint(e.toString());
    // }
  }
}
