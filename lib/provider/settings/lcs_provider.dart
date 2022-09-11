import 'package:flutter/material.dart';

class LcsProvider extends ChangeNotifier {
  bool likepostAnyone = true;
  void likepostAnyonebool() {
    likepostAnyone = !likepostAnyone;
    notifyListeners();
  }

  bool likepostUFollow = true;
  void likepostUFollowbool() {
    likepostUFollow = !likepostUFollow;
    notifyListeners();
  }

  bool likepostYourFollow = true;
  void likepostYourFollowbool() {
    likepostYourFollow = !likepostYourFollow;
    notifyListeners();
  }

  bool cmntpostAnyone = true;
  void cmntpostAnyonebool() {
    cmntpostAnyone = !cmntpostAnyone;
    notifyListeners();
  }

  bool cmntpostUFollow = true;
  void cmntpostUFollowbool() {
    cmntpostUFollow = !cmntpostUFollow;
    notifyListeners();
  }

  bool cmntpostYourFollow = true;
  void cmntpostYourFollowbool() {
    cmntpostYourFollow = !cmntpostYourFollow;
    notifyListeners();
  }

  bool sharepostAnyone = true;
  void sharepostAnyonebool() {
    sharepostAnyone = !sharepostAnyone;
    notifyListeners();
  }

  bool sharepostUFollow = true;
  void sharepostUFollowbool() {
    sharepostUFollow = !sharepostUFollow;
    notifyListeners();
  }

  bool sharepostYourFollow = true;
  void sharepostYourFollowbool() {
    sharepostYourFollow = !sharepostYourFollow;
    notifyListeners();
  }
}
