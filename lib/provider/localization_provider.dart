import 'package:als_frontend/data/model/response/language_model.dart';
import 'package:als_frontend/util/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocalizationProvider extends ChangeNotifier {
  final SharedPreferences sharedPreferences;

  LocalizationProvider({required this.sharedPreferences}) {
    _loadCurrentLanguage();
  }

  Locale _locale = const Locale('en', 'US');
  bool _isLtr = true;

  Locale get locale => _locale;

  bool get isLtr => _isLtr;

  void setLanguage(Locale locale) {
    _locale = locale;
    if (_locale.languageCode == 'ar') {
      _isLtr = false;
    } else {
      _isLtr = true;
    }
    _saveLanguage(_locale);
    notifyListeners();
  }

  _loadCurrentLanguage() async {
    _locale =
        Locale(sharedPreferences.getString(AppConstant.languageCode) ?? 'en', sharedPreferences.getString(AppConstant.countryCode) ?? 'US');
    _isLtr = _locale.languageCode == 'en';

    if (_locale.countryCode == 'US') {
      languageModel = AppConstant.languagesList[0];
    } else {
      languageModel = AppConstant.languagesList[1];
    }
    notifyListeners();
  }

  _saveLanguage(Locale locale) async {
    sharedPreferences.setString(AppConstant.languageCode, locale.languageCode);
    sharedPreferences.setString(AppConstant.countryCode, locale.countryCode ?? '');
    _loadCurrentLanguage();
  }

  LanguageModel? languageModel;

  changeLanguage(LanguageModel l) {
    languageModel = l;
    notifyListeners();
  }
}
