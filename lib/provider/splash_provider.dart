import 'package:als_frontend/data/repository/splash_repo.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_connect/http/src/response/response.dart';

class SplashProvider with ChangeNotifier {
  final SplashRepo splashRepo;

  SplashProvider({required this.splashRepo});

  String? serverVersion;
  String currentVersion = "1.0.19";
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

  Future<bool> initializeVersion() async {
    isLoading = true;
    notifyListeners();
    Response response = await splashRepo.getCurrentAppVersion();
    isLoading = false;
    notifyListeners();
    if (response.statusCode == 200) {
      serverVersion = response.body['version'];
      checkVersion();
      notifyListeners();
      if (serverVersion == currentVersion) {
        return true;
      } else {
        return false;
      }
    } else {
      if (value <= 3) {
        initializeVersion();
        value++;
      }
      Fluttertoast.showToast(msg: response.statusText!);
      return false;
    }
  }
}
