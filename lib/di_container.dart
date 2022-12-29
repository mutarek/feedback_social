import 'package:als_frontend/data/datasource/remote/dio/dio_client.dart';
import 'package:als_frontend/data/datasource/remote/dio/logging_interceptor.dart';
import 'package:als_frontend/data/repository/animal_repo.dart';
import 'package:als_frontend/data/repository/auth_repo.dart';
import 'package:als_frontend/data/repository/chat_repo.dart';
import 'package:als_frontend/data/repository/comment_repo.dart';
import 'package:als_frontend/data/repository/group_repo.dart';
import 'package:als_frontend/data/repository/newsfeed_repo.dart';
import 'package:als_frontend/data/repository/notification_repo.dart';
import 'package:als_frontend/data/repository/page_repo.dart';
import 'package:als_frontend/data/repository/post_repo.dart';
import 'package:als_frontend/data/repository/profile_repo.dart';
import 'package:als_frontend/data/repository/search_repo.dart';
import 'package:als_frontend/data/repository/settings_repo.dart';
import 'package:als_frontend/data/repository/splash_repo.dart';
import 'package:als_frontend/data/repository/watch_repo.dart';
import 'package:als_frontend/provider/animal_provider.dart';
import 'package:als_frontend/provider/auth_provider.dart';
import 'package:als_frontend/provider/chat_provider.dart';
import 'package:als_frontend/provider/comment_provider.dart';
import 'package:als_frontend/provider/dashboard_provider.dart';
import 'package:als_frontend/provider/group_provider.dart';
import 'package:als_frontend/provider/newsfeed_provider.dart';
import 'package:als_frontend/provider/other_provider.dart';
import 'package:als_frontend/provider/page_provider.dart';
import 'package:als_frontend/provider/post_provider.dart';
import 'package:als_frontend/provider/profile_provider.dart';
import 'package:als_frontend/provider/public_profile_provider.dart';
import 'package:als_frontend/provider/search_provider.dart';
import 'package:als_frontend/provider/settings_provider.dart';
import 'package:als_frontend/provider/splash_provider.dart';
import 'package:als_frontend/provider/theme_provider.dart';
import 'package:als_frontend/provider/watch_provider.dart';
import 'package:als_frontend/util/app_constant.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'provider/notication_provider.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Core
  sl.registerLazySingleton(() => DioClient(AppConstant.baseUrl, sl(),
      sharedPreferences: sl(), loggingInterceptor: sl()));
  // Repository
  sl.registerLazySingleton(() => CommentRepo(dioClient: sl()));
  sl.registerLazySingleton(
      () => AuthRepo(sharedPreferences: sl(), dioClient: sl()));
  sl.registerLazySingleton(() => NewsfeedRepo(dioClient: sl()));
  sl.registerLazySingleton(() => GroupRepo(dioClient: sl(), authRepo1: sl()));
  sl.registerLazySingleton(() =>
      AnimalRepo(dioClient: sl(), authRepo1: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(() =>
      ChatRepo(dioClient: sl(), authRepo1: sl(), sharedPreferences: sl()));
  sl.registerLazySingleton(() => NotificationRepo(dioClient: sl()));
  sl.registerLazySingleton(() => PageRepo(dioClient: sl(), authRepo: sl()));
  sl.registerLazySingleton(() => PostRepo(dioClient: sl()));
  sl.registerLazySingleton(() => ProfileRepo(dioClient: sl(), authRepo: sl()));
  sl.registerLazySingleton(() => SearchRepo(dioClient: sl(), authRepo: sl()));
  sl.registerLazySingleton(() => SettingsRepo(dioClient: sl(), authRepo: sl()));
  sl.registerLazySingleton(() => SplashRepo(dioClient: sl(), authRepo: sl()));
  sl.registerLazySingleton(() => WatchRepo(dioClient: sl()));

  // Provider
  sl.registerFactory(
      () => ThemeProvider(sharedPreferences: sl(), splashRepo: sl()));
  sl.registerFactory(() => AuthProvider(authRepo: sl()));
  sl.registerFactory(
      () => NewsFeedProvider(newsFeedRepo1: sl(), authRepo1: sl()));
  sl.registerFactory(() => ChatProvider(chatRepo: sl(), authRepo: sl()));
  sl.registerFactory(() => CommentProvider(commentRepo: sl()));
  sl.registerFactory(() => DashboardProvider());
  sl.registerFactory(() => OtherProvider());
  sl.registerFactory(
      () => GroupProvider(groupRepo: sl(), newsfeedRepo: sl(), authRepo: sl()));
  sl.registerFactory(() => AnimalProvider(animalRepo: sl()));
  sl.registerFactory(
      () => NotificationProvider(notificationRepo: sl(), authRepo: sl()));
  sl.registerFactory(
      () => PageProvider(pageRepo: sl(), newsfeedRepo: sl(), authRepo: sl()));
  sl.registerFactory(() => PostProvider(postRepo: sl(), authRepo: sl()));
  sl.registerFactory(() =>
      ProfileProvider(profileRepo: sl(), newsfeedRepo: sl(), authRepo: sl()));
  sl.registerFactory(
      () => PublicProfileProvider(profileRepo: sl(), newsfeedRepo: sl()));
  sl.registerFactory(() => SearchProvider(searchRepo: sl()));
  sl.registerFactory(() => SettingsProvider(settingsRepo: sl()));
  sl.registerFactory(() => SplashProvider(splashRepo: sl()));
  sl.registerFactory(() => WatchProvider(watchRepo: sl()));

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => Dio());
  sl.registerLazySingleton(() => LoggingInterceptor());
}
