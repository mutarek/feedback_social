import 'package:als_frontend/data/datasource/remote/dio/dio_client.dart';
import 'package:als_frontend/data/datasource/remote/exception/api_error_handler.dart';
import 'package:als_frontend/data/model/response/base/api_response.dart';
import 'package:als_frontend/util/app_constant.dart';
import 'package:dio/dio.dart';

double progressPercent = 0;

class NewsfeedRepo {
  final DioClient dioClient;

  NewsfeedRepo({required this.dioClient});

  Future<ApiResponse> getNewsFeedData(int page) async {
    Response response = Response(requestOptions: RequestOptions(path: '22222'));
    try {
      response = await dioClient.get(AppConstant.newsFeedURI + page.toString());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      print('ssksk ${e.toString()}');
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> addLike(int postID, {bool isGroup = false, bool isFromLike = false, int groupPageID = 0}) async {
    Response response = Response(requestOptions: RequestOptions(path: '22222'));

    try {
      if (isGroup) {
        response = await dioClient.post('/posts/group/$groupPageID/$postID/like/', data: {});
        return ApiResponse.withSuccess(response);
      } else if (isFromLike) {
        response = await dioClient.post('/posts/$postID/like/', data: {});
        return ApiResponse.withSuccess(response);
      } else {
        response = await dioClient.post('/posts/$postID/like/', data: {});
        return ApiResponse.withSuccess(response);
      }
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> addLikeONGroup(int postID, int groupID) async {
    Response response = Response(requestOptions: RequestOptions(path: '22222'));
    try {
      response = await dioClient.post('/posts/group/$groupID/$postID/like/', data: {});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> addLikeONPage(int postID, int groupID) async {
    Response response = Response(requestOptions: RequestOptions(path: '22222'));
    try {
      response = await dioClient.post('/posts/page/$groupID/$postID/like/', data: {});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> callForSinglePostFromNotification(String url) async {
    Response response = Response(requestOptions: RequestOptions(path: '22222'));
    try {
      response = await dioClient.get(url);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> callForgetLikedShareUser(String url, int pageNo) async {
    Response response = Response(requestOptions: RequestOptions(path: '22222'));
    try {
      response = await dioClient.get('$url?page=$pageNo&size=20');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }
}
