import 'package:als_frontend/data/repository/splash_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/response/response.dart';

class SplashProvider with ChangeNotifier {
  final SplashRepo splashRepo;

  SplashProvider({required this.splashRepo});

  String? serverVersion;
  String currentVersion = "1.0.16";
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

  Future<bool> initializeVersion() async {
    isLoading = true;
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
      //Fluttertoast.showToast(msg: response.statusText!);
      return false;
    }
  }
}
