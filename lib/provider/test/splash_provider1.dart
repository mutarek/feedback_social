import 'dart:convert';

import 'package:als_frontend/data/repository/test/splash_repo1.dart';
import 'package:als_frontend/util/app_constant.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

class SplashProvider1 with ChangeNotifier{
  final SplashRepo1 splashRepo;

  SplashProvider1({required this.splashRepo});

  String? serverVersion;
  String currentVersion = "1.0.24";

  bool isLoading = false;
  bool isExistsVersion = false;

  void checkVersion() {
    if (serverVersion == currentVersion) {
      isExistsVersion = true;
    } else {
      isExistsVersion = false;
    }
    notifyListeners();
  }

  int value = 0;

  Future initializeVersion() async {
    value = -2;
    isLoading = true;
    notifyListeners();
    http.Response _response = await http.get(Uri.parse(AppConstant.baseUrl + AppConstant.latestVersionUri),
        headers: {'Content-Type': 'application/json; charset=UTF-8'});
    isLoading = false;
    notifyListeners();
    if (_response.statusCode == 200) {
      serverVersion = jsonDecode(utf8.decode(_response.bodyBytes))['version'];
      checkVersion();
      notifyListeners();
      if (serverVersion == currentVersion) {
        value = 1;
      } else {
        value = 0;
      }
    } else {
      Fluttertoast.showToast(msg: 'Server error!');
      value = -1;
    }
    notifyListeners();
  }
}