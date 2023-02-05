import 'package:als_frontend/data/datasource/remote/dio/dio_client.dart';
import 'package:als_frontend/data/datasource/remote/exception/api_error_handler.dart';
import 'package:als_frontend/data/model/response/base/api_response.dart';
import 'package:als_frontend/util/app_constant.dart';
import 'package:dio/dio.dart';

class PostRepo {
  final DioClient dioClient;

  PostRepo({required this.dioClient});

  Response response = Response(requestOptions: RequestOptions(path: '22222'));

  Future<ApiResponse> submitPost(FormData formData, {onSendProgress}) async {
    try {
      response =
          await dioClient.post("${AppConstant.baseUrl}${AppConstant.postsUri}user/create/", data: formData, onSendProgress: onSendProgress);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> updatePost(FormData formData, String url, {onSendProgress}) async {
    try {
      response = await dioClient.patch("${AppConstant.baseUrl}${url.replaceAll("comment/", "").replaceAll('list/', '')}up-del-retr/",
          data: formData, onSendProgress: onSendProgress);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      print(formData.fields);
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> submitPostTOGroupBYUSINGGroupID(FormData formData, int groupID, {onSendProgress}) async {
    try {
      response = await dioClient.post("${AppConstant.postsGroupUri}$groupID/", data: formData, onSendProgress: onSendProgress);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> submitPostTOPageBYUSINGPageID(FormData formData, int pageID, {onSendProgress}) async {
    try {
      response = await dioClient.post("${AppConstant.postPageURI}$pageID/list-create/", data: formData, onSendProgress: onSendProgress);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> reportPost(Map<String, String> body, int id) async {
    try {
      response = await dioClient.post("${AppConstant.postsUri}post-report/$id/", data: body);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> reportPagePost(Map<String, String> body, int id) async {
    try {
      response = await dioClient.post("/page/post/report/$id/create/", data: body);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> reportGroupPost(Map<String, String> body, int id) async {
    try {
      response = await dioClient.post("${AppConstant.postsUri}group-post-report/$id/", data: body);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> deletePost(String url) async {
    try {
      response = await dioClient.delete("${url.replaceAll("comment/", "").replaceAll('list/', '')}up-del-retr/");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> sharePost(String url, String description, {onSendProgress}) async {
    try {
      response = await dioClient.post("${url.replaceAll("comment/", "")}share/",
          data: {"description": description}, onSendProgress: onSendProgress);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }
}
