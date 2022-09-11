import 'package:flutter/material.dart';

class DataUsesvalueProvider extends ChangeNotifier {
  bool onCellular = true;
  void onCellularbool() {
    onCellular = !onCellular;
    notifyListeners();
  }

  bool wifi = true;
  void wifibool() {
    wifi = !wifi;
    notifyListeners();
  }

  bool dataserver = true;
  void dataserverbool() {
    dataserver = !dataserver;
    notifyListeners();
  }
}
