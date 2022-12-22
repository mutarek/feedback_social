import 'package:als_frontend/data/datasource/remote/exception/api_error_handler.dart';
import 'package:als_frontend/data/model/response/base/api_response.dart';
import 'package:als_frontend/util/app_constant.dart';
import 'package:als_frontend/util/helper.dart';
import 'package:dio/dio.dart';

import '../datasource/remote/dio/dio_client.dart';

class CommentRepo {
  final DioClient dioClient;

  CommentRepo({required this.dioClient});

  Response response = Response(requestOptions: RequestOptions(path: '22222'));

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
      response = await dioClient.post('${url}create/', data: {"comment": comment});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      showLog(e.toString());
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> addReply(String url, String commentID, String comment) async {
    try {
      response = await dioClient.post('$url$commentID/reply/', data: {"comment": comment});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }
}
