import 'package:als_frontend/data/datasource/api_client.dart';
import 'package:als_frontend/util/app_constant.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:http/http.dart' as Http;

class SearchRepo {
  final ApiClient apiClient;

  SearchRepo({required this.apiClient});

  Future<Response> searchData(String query) async {
    return await apiClient.getData('/search/?q=$query');
  }
}
