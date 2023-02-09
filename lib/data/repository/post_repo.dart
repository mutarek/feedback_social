import 'package:als_frontend/data/datasource/remote/dio/dio_client.dart';
import 'package:als_frontend/data/datasource/remote/exception/api_error_handler.dart';
import 'package:als_frontend/data/model/response/base/api_response.dart';
import 'package:als_frontend/util/app_constant.dart';
import 'package:dio/dio.dart';

class PostRepo {
  final DioClient dioClient;

  PostRepo({required this.dioClient});

  Response response = Response(requestOptions: RequestOptions(path: ''));

  Future<ApiResponse> submitPost(FormData formData, {onSendProgress}) async {
    try {
      response = await dioClient.post("${AppConstant.baseUrl}${AppConstant.userPostUri}", data: formData, onSendProgress: onSendProgress);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> updatePost(FormData formData, String url, {onSendProgress}) async {
    try {
      response = await dioClient.put("${AppConstant.baseUrl}${url.replaceAll("comment/", "").replaceAll('list/', '')}up-del-retr/",
          data: formData, onSendProgress: onSendProgress);
      return ApiResponse.withSuccess(response);
    } catch (e) {
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

  Future<ApiResponse> reportPagePost(Map<String, String> body, int id, int status) async {
    try {
      String url = "/${status == 0 ? "page" : status == 1 ? "group" : "user"}/post/report/$id/create/";

      response = await dioClient.post(url, data: body);
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
      response =
          await dioClient.post("${url.replaceAll("list/", "")}create/", data: {"description": description}, onSendProgress: onSendProgress);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> hidePagePostFromDatabase(String postId, bool isPage, bool isGroup) async {
    Response response = Response(requestOptions: RequestOptions(path: '22222'));
    try {
      response = await dioClient.post("/${isPage ? 'page' : isGroup ? "group" : 'user'}/post/hide/$postId/");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> bookmarkCreate(int postId, bool isPage, bool isGroup) async {
    Response response = Response(requestOptions: RequestOptions(path: '22222'));
    try {
      response = await dioClient.post("${AppConstant.bookmarkURI}create", data: {
        "post_id": postId,
        "post_type": isPage
            ? 3
            : isGroup
                ? 2
                : 1
      });
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> bookmarkDelete(int bookmarkID) async {
    Response response = Response(requestOptions: RequestOptions(path: '22222'));
    try {
      response = await dioClient.delete("${AppConstant.bookmarkURI}$bookmarkID/delete");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> bookmarkLists(int page) async {
    Response response = Response(requestOptions: RequestOptions(path: '22222'));
    try {
      response = await dioClient.get("${AppConstant.bookmarkURI}list/?page=$page");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }
}
