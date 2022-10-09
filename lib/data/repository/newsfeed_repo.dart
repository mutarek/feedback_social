import 'package:als_frontend/data/datasource/api_client.dart';
import 'package:als_frontend/util/app_constant.dart';
import 'package:get/get_connect/http/src/response/response.dart';

class NewsfeedRepo {
  final ApiClient apiClient;

  NewsfeedRepo({required this.apiClient});

  Future<Response> getNewsFeedData(int page) async {
    return await apiClient.getData(AppConstant.newsFeedURI + page.toString());
  }
}
