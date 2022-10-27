
import 'package:als_frontend/data/datasource/api_client.dart';
import 'package:als_frontend/util/app_constant.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:http/http.dart' as Http;

class SettingsRepo{
  final ApiClient apiClient;
  SettingsRepo({required this.apiClient});


  Future<Response> passwordUpdate(String oldPassword,String newPassword,String confirmPassword) async {
    return await apiClient.putData(AppConstant.passwordUpdate,{
      "old_password": oldPassword,
      "new_password": newPassword,
      "confirm_password": confirmPassword
    });
  }
  Future<Response> emailUpdate(String oldMail,String newMail,String confirmPassword) async {
    return await apiClient.putData(AppConstant.emailUpdate, {
      "old_email": oldMail,
      "new_email": newMail,
      "password": confirmPassword
    });
  }
  Future<Response> blockList(int page) async {
    return await apiClient.getData(AppConstant.blocklist+"?page=$page");
  }



}