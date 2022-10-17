//constant key
import 'package:als_frontend/data/model/response/language_model.dart';

class AppConstant {
  // API BASE URL
  static const String baseUrl = 'https://als-social.com';
  static const String loginURI = '/accounts/signin/';
  static const String signupURI = '/accounts/signup/';
  static const String otpSendURI = '/accounts/otp/send/';
  static const String otpVerifyURI = '/accounts/otp/verify/';
  static const String newsFeedURI = '/posts/newsfeeds?page=';
  static const String postsUri = '/posts/';
  static const String animalUri = '/animal/';
  static const String animalOwnerURI = '/animal/owner/';
  static const String forgotPasswordURI = 'auth/forget-password';
  static const String sendFriendRequestURI = '/accounts/friends/send-friend-request/';
  static const String cancelFriendRequestURI = '/accounts/friends/cancel-friend-request/';
  static const String acceptFriendRequestURI = '/accounts/friends/accept-friend-request/';
  static const String unfriendURI = '/accounts/friends/unfriend/';
  static const String sendFriendRequestListURI = '/accounts/friends/friend-request/list/?size=10&page=';
  static const String friendListsURI = '/accounts/friends/list/?size=10&page=';
  static const String groupSuggestAllURI = '/group/suggest/all/';
  static const String groupCreatorAllURI = '/group/creator/';
  static const String profileURI = '/accounts/profile/';
  static const String uploadCoverImageURI = '/accounts/profile/update/cover-image/';
  static const String uploadProfileImageURI = '/accounts/profile/update/profile-image/';
  static const String editProfile = '/accounts/profile/update/';


  // Shared Key
  static const String theme = 'theme';
  static const String light = 'light';
  static const String dark = 'dark';
  static const String token = 'token';
  static const String countryCode = 'country_code';
  static const String languageCode = 'language_code';
  static const String userID = 'userID';
  static const String userProfileImage = 'userprofile_image';
  static const String userName = 'username';
  static const String usercode = 'usercode';
  static const String userEmail = 'useremail';

  static List<LanguageModel> languagesList = [
    LanguageModel(imageUrl: '', languageName: 'English', countryCode: 'US', languageCode: 'en'),
    LanguageModel(imageUrl: '', languageName: 'Bangla', countryCode: 'BD', languageCode: 'bn'),
  ];
}
