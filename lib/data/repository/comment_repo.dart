import 'package:als_frontend/data/datasource/remote/exception/api_error_handler.dart';
import 'package:als_frontend/data/model/response/base/api_response.dart';
import 'package:als_frontend/util/helper.dart';
import 'package:dio/dio.dart';

import '../datasource/remote/dio/dio_client.dart';

class CommentRepo {
  final DioClient dioClient;

  CommentRepo({required this.dioClient});

  Response response = Response(requestOptions: RequestOptions(path: '22222'));

  Future<ApiResponse> getAllLikesData(String url) async {
    try {
      response = await dioClient.get(url);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> addLike(String url) async {
    try {
      response = await dioClient.post("${url.replaceAll("list/", "")}get-or-create/");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> getAllCommentData(String url) async {
    try {
      response = await dioClient.get("$url?page=1");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> getAllGroupCommentData(int postId, int groupID) async {
    try {
      response = await dioClient.get('post/group/$postId/comment/');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> addComment(String url, String comment) async {
    try {
      response = await dioClient.post('${url.replaceAll("list/", "")}create/', data: {"comment": comment});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      showLog(e.toString());
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }
  Future<ApiResponse> deleteComment(String url, String commentID) async {
    try {
      response = await dioClient.delete('${url.replaceAll("list/", "")}$commentID/up-del-retr/');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      showLog(e.toString());
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> updateComment(String url, String commentID,String comment) async {
    try {
      response = await dioClient.patch('${url.replaceAll("list/", "")}$commentID/up-del-retr/',data: {"comment":comment});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      showLog(e.toString());
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> addReply(String url, String commentID, String comment) async {
    try {
      String url2 = url.replaceAll("/page/post/comment/", "").replaceAll("/list/", "");
      String url3 = "/page/post/comment/reply/$url2/$commentID/create/";
      response = await dioClient.post(url3, data: {"comment": comment});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }
}
