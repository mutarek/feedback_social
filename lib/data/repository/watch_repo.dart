import 'package:als_frontend/data/datasource/remote/dio/dio_client.dart';
import 'package:als_frontend/data/datasource/remote/exception/api_error_handler.dart';
import 'package:als_frontend/data/model/response/base/api_response.dart';
import 'package:als_frontend/util/app_constant.dart';
import 'package:dio/dio.dart';

class WatchRepo {
  final DioClient dioClient;

  WatchRepo({required this.dioClient});

  Future<ApiResponse> getAllVideos(int page) async {
    Response response = Response(requestOptions: RequestOptions(path: '22222'));
    try {
      response =
          await dioClient.get(AppConstant.watchListUri + page.toString());
      return ApiResponse.withSuccess(response);
    } catch (e) {
      print('aakak ${e.toString()}');
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> addLike(int postID,
      {bool isGroup = false,
      bool isFromLike = false,
      int groupPageID = 0}) async {
    Response response = Response(requestOptions: RequestOptions(path: '22222'));

    try {
      if (isGroup) {
        response = await dioClient
            .post('/posts/group/$groupPageID/$postID/like/', data: {});
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
}
