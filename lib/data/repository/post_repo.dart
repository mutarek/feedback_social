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

  Future<Response> updatePost(Map<String, String> body, List<Http.MultipartFile> multipartData, int id) async {
    return await apiClient.patchMultipartData(AppConstant.postsUri + "$id/", body, multipartData);
  }

  Future<Response> submitPostTOGroupBYUSINGGroupID(Map<String, String> body, List<Http.MultipartFile> multipartData, int groupID) async {
    return await apiClient.postMultipartData(AppConstant.postsGroupUri + "$groupID/", body, multipartData);
  }

  Future<Response> updatePostTOGroupBYUSINGGroupID(
      Map<String, String> body, List<Http.MultipartFile> multipartData, int groupID, int id) async {
    return await apiClient.patchMultipartData(AppConstant.postsGroupUri + "$groupID/$id/", body, multipartData);
  }

  Future<Response> submitPostTOPageBYUSINGPageID(Map<String, String> body, List<Http.MultipartFile> multipartData, int pageID) async {
    return await apiClient.postMultipartData(AppConstant.postPageURI + "$pageID/", body, multipartData);
  }

  Future<Response> updatePostTOPageBYUSINGPageID(
      Map<String, String> body, List<Http.MultipartFile> multipartData, int pageID, int id) async {
    return await apiClient.patchMultipartData(AppConstant.postPageURI + "$pageID/$id/", body, multipartData);
  }
}
