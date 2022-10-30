import 'package:als_frontend/data/datasource/api_client.dart';
import 'package:als_frontend/util/app_constant.dart';
import 'package:get/get_connect/http/src/response/response.dart';

class SettingsRepo {
  final ApiClient apiClient;

  SettingsRepo({required this.apiClient});

  Future<Response> passwordUpdate(String oldPassword, String newPassword, String confirmPassword) async {
    return await apiClient.putData(
        AppConstant.passwordUpdate, {"old_password": oldPassword, "new_password": newPassword, "confirm_password": confirmPassword});
  }

  Future<Response> emailUpdate(String oldMail, String newMail, String confirmPassword) async {
    return await apiClient.putData(AppConstant.emailUpdate, {"old_email": oldMail, "new_email": newMail, "password": confirmPassword});
  }

  Future<Response> blockList(int page) async {
    return await apiClient.getData(AppConstant.blocklist + "?page=$page");
  }

  Future<Response> otherSettingsValue() async {
    return await apiClient.getData(AppConstant.getOthersettingsValue);
  }

  Future<Response> updateOtherSettings(bool status, int slNo) async {
    Map map = {};
    switch (slNo) {
      case 0:
        map['is_anyone_tag'] = status;
        break;
      case 1:
        map['is_follower_tag'] = status;
        break;
      case 2:
        map['is_following_tag'] = status;
        break;
    }
    return await apiClient.patchData(AppConstant.getOthersettingsValue, map);
  }
}
