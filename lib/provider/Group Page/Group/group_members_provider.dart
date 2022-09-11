import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../model/model.dart';
import '../../../service/services.dart';

class GroupMembersProvider extends ChangeNotifier {
  List<GroupMembersModel>? members = [];
  var isLoaded = false;
  int pageIndex = 0;
  int? id;
  int? userId;

  Future<void> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = (prefs.getInt('id') ?? '') as int?;
    members = (await GroupMembersService(id).getMembers());
    notifyListeners();
    if (members != null) {
      isLoaded = true;
      notifyListeners();
    }
  }
}
