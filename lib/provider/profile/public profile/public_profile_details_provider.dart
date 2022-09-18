
import 'package:als_frontend/model/model.dart';
import 'package:als_frontend/service/profile/Public/public_profile_details_service.dart';
import 'package:flutter/material.dart';

class PublicProfileDetailsProvider extends ChangeNotifier {
  UserProfileModel? userprofileData;
  var loading = false;
  int id = 0;
  List<String> postImages = [];
  Future<void> getUserData() async {
    userprofileData =
        (await PublicProfileDetailsService(profileId: id).getData());
    notifyListeners();
    if (userprofileData != null) {
      loading = true;
      notifyListeners();
    }
  }
}
