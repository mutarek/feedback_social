import 'package:als_frontend/model/settings/drrect_massages_model.dart';
import 'package:als_frontend/service/Get%20settings%20value/drect_massage_service.dart';
import 'package:flutter/material.dart';

class SettingsDrectMassagesProvider extends ChangeNotifier {
  DrectMassagesModel drectMassages = DrectMassagesModel();

  var isLoaded = false;
  bool connection = false;
  bool friendsListHasData = false;

  Future<void> getData() async {
    try {
      drectMassages = (await DrectMassagesService().getdrectmassageValue())!;
      notifyListeners();
      if (drectMassages == null) {
        isLoaded = true;
        notifyListeners();
      }
    } catch (e) {
      print("Friend request provider: $e");
    }
  }
}
