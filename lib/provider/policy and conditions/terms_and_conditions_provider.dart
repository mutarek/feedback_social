import 'package:flutter/material.dart';

import '../../model/model.dart';
import '../../service/services.dart';

class TermsAndConditionsProvider extends ChangeNotifier {
  List<PrivacyPolicyModel>? termsAndConditions = [];
  var isLoaded = false;
  Future<void> getData() async {
    termsAndConditions = (await TermsAndConditionsService().getTermsAndConditions())!;
    notifyListeners();
    if (termsAndConditions != null) {
      isLoaded = true;
      notifyListeners();
    }
  }
}
