
import 'package:als_frontend/data/model/response/settings/block_list_model.dart';
import 'package:als_frontend/data/repository/settings_repo.dart';
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsProvider extends ChangeNotifier{
   final SettingsRepo settingsRepo;
   SettingsProvider({required this.settingsRepo, });
   bool darkModeOff = false;
   List<Result> blocklist = [];
   int position = 0;
   bool isBottomLoading = false;
   bool hasNextData = false;
   int selectPage = 1;
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
   Future emailUpdate(String oldMail,String newmail,String confirmPassword)async{
     _isLoading= true;
     notifyListeners();
     Response response = await settingsRepo.emailUpdate(oldMail, newmail, confirmPassword);
     if(response.status==200){
       success=true;
       notifyListeners();
     }else{
       print("false");
     }
   }
   updatePageNo() {
     selectPage++;
     initializeAllUserBlockData((bool status) {}, page: selectPage);
     notifyListeners();
   }
   initializeAllUserBlockData(Function callBackFunction, {int page = 1, bool isFirstTime = true}) async {
     if (page == 1) {
       selectPage = 1;
       blocklist.clear();
       blocklist = [];
       _isLoading = true;
       isBottomLoading = false;
       hasNextData = false;
       position = 0;

       if (!isFirstTime) {
         notifyListeners();
       }
     } else {
       isBottomLoading = true;
       notifyListeners();
     }

     Response response = await settingsRepo.blockList( page);
     _isLoading = false;
     isBottomLoading = false;
     callBackFunction(true);
     int status = 0;
     if (response.statusCode == 200) {
       hasNextData = response.body['next'] != null ? true : false;
       response.body['results'].forEach((element) {
         Result blocklist = Result.fromJson(element);
         print(blocklist.toJson());
       });
     } else {
       Fluttertoast.showToast(msg: response.statusText!);
     }
     notifyListeners();
   }



   changeDarkModestatus(bool value, {bool isFirstTime = false}) {
     darkModeOff = value;
     if (!isFirstTime) notifyListeners();}

}