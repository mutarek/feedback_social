import 'package:als_frontend/model/settings/notidication.dart';
import 'package:flutter/material.dart';
import '../../../service/Get settings value/notiifiaction_service.dart';

class SettingsNotificationProvider extends ChangeNotifier {
  SettingsNotificationModel notifiaction = SettingsNotificationModel();

  var isLoaded = false;
  bool connection = false;
  bool friendsListHasData = false;

  Future<void> getData() async {
    try {
      notifiaction = (await GetNotificationService().getnotificationValue())!;
      notifyListeners();
      if (notifiaction == null) {
        isLoaded = true;
        notifyListeners();
      }
    } catch (e) {
      print("Friend request provider: $e");
    }
  }
}
