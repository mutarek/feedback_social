import 'package:flutter/material.dart';

import '../provider.dart';

class GetInfoFromDb extends ChangeNotifier {
  String firstName = "";
  String lastName = "";
  String image = "";
  String token = "";
  void info() {
    DatabaseProvider().getLastName().then((value) {
      
        lastName = value;
        notifyListeners();
  
    });

    DatabaseProvider().getFirstName().then((value) {
        firstName = value;
        notifyListeners();
      
    });

    DatabaseProvider().getProfileImage().then((value) {
        image = value;
        notifyListeners();
      
    });
  }
}
