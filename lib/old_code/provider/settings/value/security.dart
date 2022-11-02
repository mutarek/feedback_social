
import 'package:als_frontend/old_code/model/settings/security_model.dart';
import 'package:flutter/material.dart';

import '../../../service/Get settings value/security_sevice.dart';

class SettingsSecurityProvider extends ChangeNotifier {
  SecurityModel security = SecurityModel();

  var isLoaded = false;
  bool connection = false;
  bool friendsListHasData = false;

  Future<void> getData() async {
    try {
      security = (await SecurityService().getsecurityValue())!;
      notifyListeners();
      if (security == null) {
        isLoaded = true;
        notifyListeners();
      }
    } catch (e) {
      print("Friend request provider: $e");
    }
  }
}
