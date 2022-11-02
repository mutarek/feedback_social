import 'package:als_frontend/old_code/screens/screens.dart';
import 'package:als_frontend/old_code/service/version/latest_vertion_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../screens/others/update_screen.dart';

class LatestVersionProvider extends ChangeNotifier {
  var latestVersion;
  String? latestVer;
  String oldVersion = "1.0.8";

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
    print("new version = ${latestVer}");

    if (latestVer == null || latestVer == oldVersion) {
      Get.off(const NavScreen());
    } else {
      Get.off(() => const UpdateScreen());
    }
  }
}
