import 'package:flutter/material.dart';

class AbilityProvider extends ChangeNotifier {
  bool increaseColor = true;
  void increaseColorbool() {
    increaseColor = !increaseColor;
    notifyListeners();
  }

  bool defult = true;
  void defultbool() {
    defult = !defult;
    notifyListeners();
  }

  bool dark = true;
  void darkbool() {
    dark = !dark;
    notifyListeners();
  }
}
