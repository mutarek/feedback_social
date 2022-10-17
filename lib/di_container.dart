import 'package:als_frontend/data/datasource/api_client.dart';
import 'package:als_frontend/data/repository/animal_repo.dart';
import 'package:als_frontend/data/repository/auth_repo.dart';
import 'package:als_frontend/data/repository/comment_repo.dart';
import 'package:als_frontend/data/repository/group_repo.dart';
import 'package:als_frontend/data/repository/language_repo.dart';
import 'package:als_frontend/data/repository/newsfeed_repo.dart';
import 'package:als_frontend/data/repository/post_repo.dart';
import 'package:als_frontend/data/repository/profile_repo.dart';
import 'package:als_frontend/data/repository/splash_repo.dart';
import 'package:als_frontend/provider/animal_provider.dart';
import 'package:als_frontend/provider/auth_provider.dart';
import 'package:als_frontend/provider/comment_provider.dart';
import 'package:als_frontend/provider/dashboard_provider.dart';
import 'package:als_frontend/provider/group_provider.dart';
import 'package:als_frontend/provider/language_provider.dart';
import 'package:als_frontend/provider/localization_provider.dart';
import 'package:als_frontend/provider/newsfeed_provider.dart';
import 'package:als_frontend/provider/post_provider.dart';
import 'package:als_frontend/provider/profile_provider.dart';
import 'package:als_frontend/provider/public_profile_provider.dart';
import 'package:als_frontend/provider/splash_provider.dart';
import 'package:als_frontend/provider/theme_provider.dart';
import 'package:als_frontend/util/app_constant.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';


final sl = GetIt.instance;

Future<void> init() async {
  // Core
  sl.registerLazySingleton(() => ApiClient(appBaseUrl: AppConstant.baseUrl, sharedPreferences: sl()));

  // Repository
  sl.registerLazySingleton(() => LanguageRepo());
  sl.registerLazySingleton(() => CommentRepo(apiClient: sl()));
  sl.registerLazySingleton(() => AuthRepo(sharedPreferences: sl(),apiClient: sl()));
  sl.registerLazySingleton(() => ProfileRepo(apiClient: sl()));
  sl.registerLazySingleton(() => NewsfeedRepo(apiClient: sl()));
  sl.registerLazySingleton(() => PostRepo(apiClient: sl()));
  sl.registerLazySingleton(() => GroupRepo(apiClient: sl(),authRepo: sl()));
  sl.registerLazySingleton(() => AnimalRepo(apiClient: sl(),authRepo: sl()));
  sl.registerLazySingleton(() => SplashRepo(sharedPreferences: sl()));

  // Provider
  sl.registerFactory(() => ThemeProvider(sharedPreferences: sl(),splashRepo: sl()));
  sl.registerFactory(() => LocalizationProvider(sharedPreferences: sl()));
  sl.registerFactory(() => LanguageProvider(languageRepo: sl()));
  sl.registerFactory(() => AuthProvider(authRepo: sl(),sharedPreferences: sl()));
  sl.registerFactory(() => NewsFeedProvider(newsFeedRepo: sl()));
  sl.registerFactory(() => CommentProvider(commentRepo: sl()));
  sl.registerFactory(() => PostProvider(postRepo: sl()));
  sl.registerFactory(() => SplashProvider());
  sl.registerFactory(() => DashboardProvider());
  sl.registerFactory(() => GroupProvider(groupRepo: sl()));
  sl.registerFactory(() => AnimalProvider(animalRepo: sl()));
  sl.registerFactory(() => ProfileProvider(profileRepo: sl(),newsfeedRepo: sl(),authRepo: sl()));
  sl.registerFactory(() => PublicProfileProvider(profileRepo: sl(),newsfeedRepo: sl()));

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}
