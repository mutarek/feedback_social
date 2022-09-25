import 'package:als_frontend/screens/screens.dart';
import 'package:als_frontend/service/version/latest_vertion_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../screens/others/update_screen.dart';

class LatestVersionProvider extends ChangeNotifier {
  var latestVersion;
  String? latestVer;
  String oldVersion = "1.0.5";

  Future<void> getData() async {
    try {
      latestVersion = (await LatestVersionService().getVersion())!;
      latestVer = latestVersion.version;
      notifyListeners();
    } catch (e) {
      print("Friend request provider: $e");
    }
    
  }
  void chekVersion() {
    if (latestVer == oldVersion) {
      Get.to(const NavScreen());

    } else {
      Get.to(() => const UpdateScreen());
    }
  }
}
