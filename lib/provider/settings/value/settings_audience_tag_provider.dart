import 'package:als_frontend/service/Get%20settings%20value/audience_tag_service.dart';
import 'package:flutter/material.dart';
import '../../../model/settings/audience_tag_model.dart';

class SettingsAudienceTagProvider extends ChangeNotifier {
  AudienceTagModel audienceTag = AudienceTagModel();

  var isLoaded = false;
  bool connection = false;
  bool friendsListHasData = false;

  Future<void> getData() async {
    try {
      audienceTag = (await AudienceTagService().getaudienceTagValue())!;
      notifyListeners();
      if (audienceTag == null) {
        isLoaded = true;
        notifyListeners();
      }
    } catch (e) {
      print("Friend request provider: $e");
    }
  }
}
