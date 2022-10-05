
import 'package:flutter/material.dart';

class SplashProvider with ChangeNotifier {
  // final SplashRepo splashRepo;
  //
  // SplashProvider({required this.splashRepo});
  //
  // ConfigModel? _configModel;
  //
  // DateTime _currentTime = DateTime.now();
  //
  // ConfigModel get configModel => _configModel!;
  //
  // DateTime get currentTime => _currentTime;
  //
  // Future<bool> initConfig(GlobalKey<ScaffoldMessengerState> globalKey) async {
  //   ApiResponse apiResponse = await splashRepo.getConfig();
  //   bool isSuccess;
  //   if (apiResponse.response.statusCode == 200) {
  //     _configModel = ConfigModel.fromJson(apiResponse.response.data['value'][0]);
  //     splashRepo.saveTheme(true, _configModel!.lightMode!.toJson());
  //     splashRepo.saveTheme(false, _configModel!.darkMode!.toJson());
  //     splashRepo.saveVariantID(_configModel!.variant!);
  //     isSuccess = true;
  //     notifyListeners();
  //   } else {
  //     isSuccess = false;
  //     String _error;
  //     if (apiResponse.error is String) {
  //       _error = apiResponse.error;
  //     } else {
  //       _error = apiResponse.error.errors[0].message;
  //     }
  //     print(_error);
  //   //  showCustomSnackBar(_error, globalKey.currentContext!);
  //   }
  //   return isSuccess;
  // }

}
