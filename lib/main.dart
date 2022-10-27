import 'package:als_frontend/localization/app_localization.dart';
import 'package:als_frontend/old_code/screens/screens.dart';
import 'package:als_frontend/provider/animal_provider.dart';
import 'package:als_frontend/provider/auth_provider.dart';
import 'package:als_frontend/provider/comment_provider.dart';
import 'package:als_frontend/provider/dashboard_provider.dart';
import 'package:als_frontend/provider/group_provider.dart';
import 'package:als_frontend/provider/language_provider.dart';
import 'package:als_frontend/provider/localization_provider.dart';
import 'package:als_frontend/provider/newsfeed_provider.dart';
import 'package:als_frontend/provider/notication_provider.dart';
import 'package:als_frontend/provider/other_provider.dart';
import 'package:als_frontend/provider/page_provider.dart';
import 'package:als_frontend/provider/post_provider.dart';
import 'package:als_frontend/provider/profile_provider.dart';
import 'package:als_frontend/provider/public_profile_provider.dart';
import 'package:als_frontend/provider/search_provider.dart';
import 'package:als_frontend/provider/settings_provider.dart';
import 'package:als_frontend/provider/splash_provider.dart';
import 'package:als_frontend/provider/theme_provider.dart';
import 'package:als_frontend/util/app_constant.dart';
import 'package:als_frontend/util/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';

import 'di_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => di.sl<LocalizationProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<LanguageProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<ThemeProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<AuthProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<SplashProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<ProfileProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<DashboardProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<NewsFeedProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<CommentProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<PostProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<PublicProfileProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<AnimalProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<GroupProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<OtherProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<NotificationProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<SettingsProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<PageProvider>()),
      ChangeNotifierProvider(create: (context) => di.sl<SearchProvider>()),

      //
      // ChangeNotifierProvider(create: (_) => LoginProvider()),
      // ChangeNotifierProvider(create: (_) => RegistrationProvider()),
      // ChangeNotifierProvider(create: (_) => ShowPasswordProvider()),
      // ChangeNotifierProvider(create: (_) => DatabaseProvider()),
      // ChangeNotifierProvider(create: (_) => OldNotificationsProvider()),
      // ChangeNotifierProvider(create: (_) => NewsFeedPostProvider()),
      // ChangeNotifierProvider(create: (_) => LikeCommentShareProvider()),
      // ChangeNotifierProvider(create: (_) => GetInfoFromDb()),
      // ChangeNotifierProvider(create: (_) => AddAnimalProvider()),
      // ChangeNotifierProvider(create: (_) => UserProfileProvider()),
      // ChangeNotifierProvider(create: (_) => FriendRequestProvider()),
      // ChangeNotifierProvider(create: (_) => ConfirmFriendRequestProvider()),
      // ChangeNotifierProvider(create: (_) => AddFriendProvider()),
      // ChangeNotifierProvider(create: (_) => CreatePageProvider()),
      // ChangeNotifierProvider(create: (_) => AllPageProvider()),
      // ChangeNotifierProvider(create: (_) => CreateGroupProvider()),
      // ChangeNotifierProvider(create: (_) => AllGroupProvider()),
      // ChangeNotifierProvider(create: (_) => AuthorPagesProvider()),
      // ChangeNotifierProvider(create: (_) => EmailVerifyProvider()),
      // ChangeNotifierProvider(create: (_) => AuthorGroupProvider()),
      // ChangeNotifierProvider(create: (_) => WritePagePostProvider()),
      // ChangeNotifierProvider(create: (_) => OwnerAnimalProvider()),
      // ChangeNotifierProvider(create: (_) => AnimalSearchProvider()),
      // ChangeNotifierProvider(create: (_) => EditProfileProvider()),
      // ChangeNotifierProvider(create: (_) => CreatePostProvider()),
      // ChangeNotifierProvider(create: (_) => SinglePostProvider()),
      // ChangeNotifierProvider(create: (_) => ProfileDetailsProvider()),
      // ChangeNotifierProvider(create: (_) => UpdateCoverPhotProvider()),
      // ChangeNotifierProvider(create: (_) => UpdateProfileImageProvider()),
      // ChangeNotifierProvider(create: (_) => UpdatePageProfileImageProvider()),
      // // ChangeNotifierProvider(create: (_) => ProfileNewsFeedPostProvider()),
      // // ChangeNotifierProvider(create: (_) => OtherProfileNewsFeedPostProvider()),
      // ChangeNotifierProvider(create: (_) => ForgotPasswordProvider()),
      // ChangeNotifierProvider(create: (_) => GroupMembersProvider()),
      // ChangeNotifierProvider(create: (_) => ShareTimeLinePostProvider()),
      // ChangeNotifierProvider(create: (_) => FriendsListProvider()),
      // ChangeNotifierProvider(create: (_) => PublicProfileDetailsProvider()),
      // ChangeNotifierProvider(create: (_) => AuthorPageDetailsProvider()),
      // ChangeNotifierProvider(create: (_) => SuggestedPageDetailsProvider()),
      // ChangeNotifierProvider(create: (_) => GroupDetailsProvider()),
      // ChangeNotifierProvider(create: (_) => UnFriendProvider()),
      // ChangeNotifierProvider(create: (_) => PrivacyPolicyProvider()),
      // ChangeNotifierProvider(create: (_) => TermsAndConditionsProvider()),
      // ChangeNotifierProvider(create: (_) => PagePostProvider()),
      // ChangeNotifierProvider(create: (_) => PageLikePostShareProvider()),
      // ChangeNotifierProvider(create: (_) => CreatePagePost()),
      // ChangeNotifierProvider(create: (_) => GroupPostProvider()),
      // ChangeNotifierProvider(create: (_) => CreateGroupPost()),
      // ChangeNotifierProvider(create: (_) => UserNewsfeedPostProvider()),
      // ChangeNotifierProvider(create: (_) => PageLikeProvider()),
      // ChangeNotifierProvider(create: (_) => ProfileImagesProvider()),
      // ChangeNotifierProvider(create: (_) => GroupImagesProvider()),
      // ChangeNotifierProvider(create: (_) => PageImagesProvider()),
      // ChangeNotifierProvider(create: (_) => GroupInviteProvider()),
      // ChangeNotifierProvider(create: (_) => GroupInviteFriendListProvider()),
      // ChangeNotifierProvider(create: (_) => GroupFriendSearchProvider()),
      // ChangeNotifierProvider(create: (_) => JoinGroupProvider()),
      // ChangeNotifierProvider(create: (_) => GroupPostLikeCommentProvider()),
      // ChangeNotifierProvider(create: (_) => EditGroupProvider()),
      // ChangeNotifierProvider(create: (_) => EditPageProvider()),
      // ChangeNotifierProvider(create: (_) => PostImagesPreviewProvider()),
      // ChangeNotifierProvider(create: (_) => SingleVideoShowProvider()),
      // ChangeNotifierProvider(create: (_) => ProfileVideosProvider()),
      // ChangeNotifierProvider(create: (_) => PageVideoProvider()),
      // ChangeNotifierProvider(create: (_) => GroupVideoProvider()),
      //
      // ChangeNotifierProvider(create: (_) => UpdateAccountProvider()),
      // ChangeNotifierProvider(create: (_) => PasswordUpdateProviders()),
      // ChangeNotifierProvider(create: (_) => NotificationUpdateProvider()),
      // ChangeNotifierProvider(create: (_) => SecurityUpdateProvider()),
      // ChangeNotifierProvider(create: (_) => SecurityGmailUpdateProvider()),
      // ChangeNotifierProvider(create: (_) => ParivacyAudienceTagProvider()),
      // ChangeNotifierProvider(create: (_) => ParivacyDirectMessagesProvider()),
      // ChangeNotifierProvider(create: (_) => LcsProvider()),
      // ChangeNotifierProvider(create: (_) => PLikeProvider()),
      // ChangeNotifierProvider(create: (_) => ParivacyCommnetProvider()),
      // ChangeNotifierProvider(create: (_) => ParivacyShareProvider()),
      // ChangeNotifierProvider(create: (_) => BlockUpProvider()),
      // ChangeNotifierProvider(create: (_) => UnblockProvider()),
      // ChangeNotifierProvider(create: (_) => DiscoversbilityProvider()),
      // ChangeNotifierProvider(create: (_) => AbilityProvider()),
      // ChangeNotifierProvider(create: (_) => colorUpProvider()),
      // ChangeNotifierProvider(create: (_) => DisplayProvider()),
      // ChangeNotifierProvider(create: (_) => DataUsesvalueProvider()),
      // ChangeNotifierProvider(create: (_) => AutoplayProvider()),
      // ChangeNotifierProvider(create: (_) => DatasaveProvider()),
      // ChangeNotifierProvider(create: (_) => SettingsNotificationProvider()),
      // ChangeNotifierProvider(create: (_) => SettingsSecurityProvider()),
      // ChangeNotifierProvider(create: (_) => SettingsAudienceTagProvider()),
      // ChangeNotifierProvider(create: (_) => SettingsDrectMassagesProvider()),
      // ChangeNotifierProvider(create: (_) => ReportPostProvider()),
      // ChangeNotifierProvider(create: (_) => LatestVersionProvider()),
      // ChangeNotifierProvider(create: (_) => PublicNewsfeedPostProvider()),
      // ChangeNotifierProvider(create: (_) => TimelinePostCommentProvider()),
      // ChangeNotifierProvider(create: (_) => ShareGroupPagePostProvider()),
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Locale> _locals = [];
    for (var language in AppConstant.languagesList) {
      _locals.add(Locale(language.languageCode, language.countryCode));
    }

    return GetMaterialApp(
      title: 'Feedback',
      locale: Provider.of<LocalizationProvider>(context).locale,
      theme: Provider.of<ThemeProvider>(context).darkTheme ? AppTheme.getDarkModeTheme() : AppTheme.getLightModeTheme(),
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        AppLocalization.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: _locals,
      home: const SplashScreen(),
    );
  }
}
