import 'package:als_frontend/data/model/response/language_model.dart';
import 'package:als_frontend/util/app_constant.dart';
import 'package:flutter/material.dart';

class LanguageRepo {
  List<LanguageModel> getAllLanguages({BuildContext? context}) {
    return AppConstant.languagesList;
  }
}