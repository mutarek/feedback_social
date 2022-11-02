import 'package:als_frontend/data/datasource/api_client.dart';
import 'package:als_frontend/util/app_constant.dart';
import 'package:get/get_connect/http/src/response/response.dart';

class SplashRepo {
  final ApiClient apiClient;

  SplashRepo({required this.apiClient});

  Future<Response> getCurrentAppVersion() async {
    return await apiClient.getData(AppConstant.latestVersionUri);
  }
}
