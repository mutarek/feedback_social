import 'package:als_frontend/provider/animal_provider.dart';
import 'package:als_frontend/provider/auth_provider.dart';
import 'package:als_frontend/provider/chat_provider.dart';
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
import 'package:als_frontend/provider/test/animal_provider1.dart';
import 'package:als_frontend/provider/test/auth_provider1.dart';
import 'package:als_frontend/provider/test/chat_provider1.dart';
import 'package:als_frontend/provider/test/comment_provider1.dart';
import 'package:als_frontend/provider/test/dashbord_provider1.dart';
import 'package:als_frontend/provider/test/group_provider1.dart';
import 'package:als_frontend/provider/test/language_provider1.dart';
import 'package:als_frontend/provider/test/localization_provider1.dart';
import 'package:als_frontend/provider/test/newsfeed_provider1.dart';
import 'package:als_frontend/provider/theme_provider.dart';
import 'package:als_frontend/screens/splash/splash_screen.dart';
import 'package:als_frontend/translations/codegen_loader.g.dart';
import 'package:als_frontend/util/app_constant.dart';
import 'package:als_frontend/util/theme/app_theme.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

import 'di_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await EasyLocalization.ensureInitialized();
  runApp(EasyLocalization(
      path: 'assets/lang',
      supportedLocales: const [Locale('en'), Locale('bn')],
      fallbackLocale: const Locale('en'),
      assetLoader: const CodegenLoader(),
      child: MultiProvider(
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
          ChangeNotifierProvider(create: (context) => di.sl<ChatProvider>()),
          ChangeNotifierProvider(create: (context) => di.sl<AuthProvider1>()),
          //TODO: Dio provider initialized
          ChangeNotifierProvider(create: (context) => di.sl<AnimalProvider1>()),
          ChangeNotifierProvider(create: (context) => di.sl<ChatProvider1>()),
          ChangeNotifierProvider(create: (context) => di.sl<CommentProvider1>()),
          ChangeNotifierProvider(create: (context) => di.sl<DashboardProvider1>()),
          ChangeNotifierProvider(create: (context) => di.sl<GroupProvider1>()),
          ChangeNotifierProvider(create: (context) => di.sl<LanguageProvider1>()),
          ChangeNotifierProvider(create: (context) => di.sl<LocalizationProvider1>()),
          ChangeNotifierProvider(create: (context) => di.sl<NewsFeedProvider1>()),
        ],
        child: const MyApp(),
      )));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Provider.of<LanguageProvider>(context, listen: false).initializeAllLanguages();
    // List<Locale> _locals = [];
    // for (var language in AppConstant.languagesList) {
    //   _locals.add(Locale(language.languageCode, language.countryCode));
    // }

    return GetMaterialApp(
      title: 'Feedback',
      supportedLocales: context.supportedLocales,
      localizationsDelegates: context.localizationDelegates,
      locale: context.locale,
      theme: Provider.of<ThemeProvider>(context).darkTheme ? AppTheme.getDarkModeTheme() : AppTheme.getLightModeTheme(),
      debugShowCheckedModeBanner: false,
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        dragDevices: {PointerDeviceKind.mouse, PointerDeviceKind.touch},
      ),
      defaultTransition: Transition.topLevel,
      transitionDuration: const Duration(milliseconds: 500),
      // supportedLocales: _locals,
      home: const SplashScreen(),
    );
  }
}
