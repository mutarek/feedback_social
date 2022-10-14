import 'package:als_frontend/data/datasource/api_client.dart';
import 'package:als_frontend/util/app_constant.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:http/http.dart' as Http;

class PostRepo {
  final ApiClient apiClient;

  PostRepo({required this.apiClient});

  Future<Response> submitPost(Map<String, String> body, List<Http.MultipartFile> multipartData) async {
    return await apiClient.postMultipartData(AppConstant.postsUri, body, multipartData);
  }
}
