//constant key
import 'package:als_frontend/data/model/response/language_model.dart';

class AppConstant {
  // API BASE URL
  static const String baseUrl = 'http://38.242.227.190:8080/dyqantaxi/api/';
  static const String configUri = 'appSettings';
  static const String loginURI = 'auth/login';
  static const String signUPURI = 'auth/signup';
  static const String guestLoginURI = 'auth/login-guest';
  static const String forgotPasswordURI = 'auth/forget-password';
  static const String homeActiveURI = 'home/active';
  static const String homeMenuOrdered = 'homeMenu/ordered';
  static const String recommendedOrdered = 'recommended/ordered';
  static const String wishlistURI = 'wishList/';
  static const String photoUploadURI = 's3-storage/upload';

  // Shared Key
  static const String theme = 'theme';
  static const String light = 'light';
  static const String dark = 'dark';
  static const String token = 'token';
  static const String countryCode = 'country_code';
  static const String languageCode = 'language_code';
  static const String user = 'user';
  static const String userEmail = 'user_email';
  static const String userEmail2 = 'user_email2';
  static const String userPassword = 'user_password';
  static const String userID = 'userID';
  static const String customerID = 'customerID';
  static const String userName = 'userName';
  static const String firstName = 'firstName';
  static const String phoneNumber = 'phoneNumber';
  static const String variant = 'variant';


  static List<LanguageModel> languagesList = [
    LanguageModel(imageUrl: '', languageName: 'English', countryCode: 'US', languageCode: 'en'),
    LanguageModel(imageUrl: '', languageName: 'Bangla', countryCode: 'BD', languageCode: 'bn'),
  ];
}
