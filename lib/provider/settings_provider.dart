
import 'package:als_frontend/data/repository/settings_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get_connect/http/src/response/response.dart';

class SettingsProvider extends ChangeNotifier{
   final SettingsRepo settingsRepo;
   SettingsProvider({required this.settingsRepo, });
  String message = "";
  bool success = false;
  bool _isLoading = false;
  Future passwordUpdate(String oldPassword,String newPassword,String confirmPassword)async{
    _isLoading= true;
    notifyListeners();
    Response response = await settingsRepo.passwordUpdate(oldPassword, newPassword, confirmPassword);
    if(response.status==200){
      success=true;
      notifyListeners();
    }else{
      print("false");
    }
  }

   bool darkModeOff = false;

   changeDarkModestatus(bool value, {bool isFirstTime = false}) {
     darkModeOff = value;
     if (!isFirstTime) notifyListeners();}

}