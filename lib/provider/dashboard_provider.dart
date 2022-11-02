import 'package:flutter/foundation.dart';

class DashboardProvider with ChangeNotifier {
  int selectIndex = 0;

  changeSelectIndex(int value) {
    selectIndex = value;
    notifyListeners();
  }
}
