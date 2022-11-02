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

  Future<Response> reportPost(Map<String, String> body, int id) async {
    return await apiClient.postData(AppConstant.postsUri + "post-report/$id/", body);
  }

  Future<Response> reportPagePost(Map<String, String> body, int id) async {
    return await apiClient.postData(AppConstant.postsUri + "page-post-report/$id/", body);
  }

  Future<Response> reportGroupPost(Map<String, String> body, int id) async {
    return await apiClient.postData(AppConstant.postsUri + "group-post-report/$id/", body);
  }

  Future<Response> deletePost(String url) async {
    return await apiClient.deleteData(url.replaceAll("comment/", ""));
  }

  Future<Response> sharePost(String url, String description) async {
    return await apiClient.postData("${url.replaceAll("comment/", "")}share/", {"description": description});
  }
}
