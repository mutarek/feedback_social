import 'package:flutter/material.dart';

import '../../model/model.dart';
import '../../service/services.dart';

class PrivacyPolicyProvider extends ChangeNotifier {
  
  List<PrivacyPolicyModel>? privacyPolicy = [];
  var isLoaded = false;
  Future<void> getData() async {
    privacyPolicy = (await PrivacyPolicyService().getPrivacyPolicy())!;
    notifyListeners();
    if (privacyPolicy != null) {
      isLoaded = true;
      notifyListeners();
    }
  }
}
