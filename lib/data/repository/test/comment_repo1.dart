
import 'package:als_frontend/data/datasource/remote/exception/api_error_handler.dart';
import 'package:als_frontend/data/model/response/base/api_response.dart';
import 'package:dio/dio.dart';

import '../../datasource/remote/dio/dio_client.dart';

double progressPercent = 0;
class CommentRepo1{

  final DioClient dioClient;

  CommentRepo1({required this.dioClient});
  Future<ApiResponse> getAllCommentData(String url) async {
    Response response = Response(requestOptions: RequestOptions(path: '22222'));
    try{
      response =   await dioClient.get(url + "?page=1");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }


  Future<ApiResponse>getAllGroupCommentData(int postId, int groupID) async {
    Response response = Response(requestOptions: RequestOptions(path:  '22222'));
    try{
      response = await  dioClient.get('post/group/$postId/comment/');
      return ApiResponse.withSuccess(response);
    }catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }
  Future<ApiResponse> addComment(String url, String comment) async {
    Response response = Response(requestOptions: RequestOptions(path:  '22222'));
    try{
      response = await dioClient.post('${url}create/', data: comment);
      return ApiResponse.withSuccess(response);
    }catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> addReply(String url, String commentID, String comment) async {
    Response response = Response(requestOptions: RequestOptions(path:  '22222'));
    try{
      response = await dioClient.post('$url$commentID/reply/',data: comment);
      return ApiResponse.withSuccess(response);
    }catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }
}