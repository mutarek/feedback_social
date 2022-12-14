import 'package:als_frontend/data/datasource/api_client.dart';
import 'package:als_frontend/data/datasource/remote/dio/dio_client.dart';
import 'package:als_frontend/data/datasource/remote/dio/logging_interceptor.dart';
import 'package:als_frontend/data/repository/animal_repo.dart';
import 'package:als_frontend/data/repository/auth_repo.dart';
import 'package:als_frontend/data/repository/chat_repo.dart';
import 'package:als_frontend/data/repository/comment_repo.dart';
import 'package:als_frontend/data/repository/group_repo.dart';
import 'package:als_frontend/data/repository/language_repo.dart';
import 'package:als_frontend/data/repository/newsfeed_repo.dart';
import 'package:als_frontend/data/repository/notification_repo.dart';
import 'package:als_frontend/data/repository/page_repo.dart';
import 'package:als_frontend/data/repository/post_repo.dart';
import 'package:als_frontend/data/repository/profile_repo.dart';
import 'package:als_frontend/data/repository/search_repo.dart';
import 'package:als_frontend/data/repository/settings_repo.dart';
import 'package:als_frontend/data/repository/splash_repo.dart';
import 'package:als_frontend/data/repository/test/animal_repo1.dart';
import 'package:als_frontend/data/repository/test/auth_repo1.dart';
import 'package:als_frontend/data/repository/test/chat_repo1.dart';
import 'package:als_frontend/data/repository/test/comment_repo1.dart';
import 'package:als_frontend/data/repository/test/group_repo1.dart';
import 'package:als_frontend/data/repository/test/language_repo1.dart';
import 'package:als_frontend/data/repository/test/newsfeed_repo1.dart';
import 'package:als_frontend/provider/animal_provider.dart';
import 'package:als_frontend/provider/auth_provider.dart';
import 'package:als_frontend/provider/chat_provider.dart';
import 'package:als_frontend/provider/comment_provider.dart';
import 'package:als_frontend/provider/dashboard_provider.dart';
import 'package:als_frontend/provider/group_provider.dart';
import 'package:als_frontend/provider/language_provider.dart';
import 'package:als_frontend/provider/localization_controller.dart';
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
import 'package:als_frontend/provider/test/newsfeed_provider1.dart';
import 'package:als_frontend/provider/test/post_provider1.dart';
import 'package:als_frontend/provider/theme_provider.dart';
import 'package:als_frontend/util/app_constant.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';


final sl = GetIt.instance;

Future<void> init() async {
  // Core
  sl.registerLazySingleton(() => ApiClient(appBaseUrl: AppConstant.baseUrl, sharedPreferences: sl()));
  sl.registerLazySingleton(() => DioClient(AppConstant.baseUrl, sl(), sharedPreferences: sl(), loggingInterceptor: sl()));
  // Repository
  sl.registerLazySingleton(() => LanguageRepo());
  sl.registerLazySingleton(() => LanguageRepo1());
  sl.registerLazySingleton(() => AuthRepo1(dioClient: sl(),sharedPreferences: sl()));
  sl.registerLazySingleton(() => CommentRepo(apiClient: sl()));
  sl.registerLazySingleton(() => CommentRepo1(dioClient: sl()));
  sl.registerLazySingleton(() => AuthRepo(sharedPreferences: sl(),apiClient: sl()));
  sl.registerLazySingleton(() => ProfileRepo(apiClient: sl()));
  sl.registerLazySingleton(() => NewsfeedRepo(apiClient: sl()));
  sl.registerLazySingleton(() => NewsfeedRepo1(dioClient: sl()));
  sl.registerLazySingleton(() => PostRepo(apiClient: sl()));
  sl.registerLazySingleton(() => NotificationRepo(apiClient: sl()));
  sl.registerLazySingleton(() => GroupRepo(apiClient: sl(),authRepo: sl()));
  sl.registerLazySingleton(() => GroupRepo1(dioClient: sl(),authRepo1: sl()));
  sl.registerLazySingleton(() => PageRepo(apiClient: sl(),authRepo: sl()));
  sl.registerLazySingleton(() => AnimalRepo(apiClient: sl(),authRepo: sl()));
  sl.registerLazySingleton(() => AnimalRepo1(dioClient: sl(),authRepo1: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(() => SplashRepo(apiClient: sl()));
  sl.registerLazySingleton(() => SettingsRepo( apiClient:sl()));
  sl.registerLazySingleton(() => SearchRepo( apiClient:sl()));
  sl.registerLazySingleton(() => ChatRepo( apiClient:sl(),authRepo: sl(),sharedPreferences: sl()));
  sl.registerLazySingleton(() => ChatRepo1( dioClient:sl(),authRepo1: sl(),sharedPreferences: sl()));


  // Provider
  sl.registerFactory(() => ThemeProvider(sharedPreferences: sl(),splashRepo: sl()));
  sl.registerFactory(() => LocalizationProvider(sharedPreferences: sl()));
  sl.registerFactory(() => LanguageProvider(languageRepo: sl()));
  sl.registerFactory(() => AuthProvider(authRepo: sl()));
  sl.registerFactory(() => AuthProvider1(authRepo: sl()));
  sl.registerFactory(() => NewsFeedProvider(newsFeedRepo: sl(),authRepo: sl()));
  sl.registerFactory(() => NewsFeedProvider1(newsFeedRepo1: sl(),authRepo1: sl()));
  sl.registerFactory(() => ChatProvider(chatRepo: sl(),authRepo: sl()));
  sl.registerFactory(() => ChatProvider1(chatRepo1: sl(),authRepo1: sl()));
  sl.registerFactory(() => CommentProvider(commentRepo: sl()));
  sl.registerFactory(() => CommentProvider1(commentRepo1: sl()));
  sl.registerFactory(() => PostProvider(postRepo: sl(),authRepo: sl()));
  sl.registerFactory(() => NotificationProvider(authRepo: sl(),notificationRepo: sl()));
  sl.registerFactory(() => SplashProvider(splashRepo: sl()));
  sl.registerFactory(() => DashboardProvider());
  sl.registerFactory(() => DashboardProvider1());
  sl.registerFactory(() => OtherProvider());
  sl.registerFactory(() => LocalizationController(sharedPreferences: sl()));
  sl.registerFactory(() => SearchProvider(searchRepo: sl()));
  sl.registerFactory(() => GroupProvider1(groupRepo1: sl(),newsfeedRepo1: sl(),authRepo1: sl()));
  sl.registerFactory(() => PageProvider(pageRepo: sl(),newsfeedRepo: sl(),authRepo: sl()));
  sl.registerFactory(() => AnimalProvider(animalRepo: sl()));
  sl.registerFactory(() => AnimalProvider1(animalRepo1: sl()));
  sl.registerFactory(() => ProfileProvider(profileRepo: sl(),newsfeedRepo: sl(),authRepo: sl()));
  sl.registerFactory(() => PublicProfileProvider(profileRepo: sl(),newsfeedRepo: sl()));
  sl.registerFactory(() => SettingsProvider(settingsRepo: sl()));

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => LoggingInterceptor());
}
