import 'package:als_frontend/data/datasource/remote/dio/dio_client.dart';
import 'package:als_frontend/data/datasource/remote/exception/api_error_handler.dart';
import 'package:als_frontend/data/model/response/base/api_response.dart';
import 'package:als_frontend/util/app_constant.dart';
import 'package:dio/dio.dart';

class NotificationRepo {
  final DioClient dioClient;
  NotificationRepo({required this.dioClient});

  Future<ApiResponse> getAllNotification(int pageNo) async {
    Response response = Response(requestOptions: RequestOptions(path: '22222'));
    try {
      response = await dioClient.get("${AppConstant.notificationListURI}?page=$pageNo&size=10");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }

  }

  Future<ApiResponse> getNotificationUnreadCount() async {
    Response response = Response(requestOptions: RequestOptions(path: '22222'));
    try {
      response = await dioClient.post(AppConstant.baseUrl+AppConstant.notificationUnreadCountURI,data: {});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  Future<ApiResponse> getNotificationReadCount() async {
    Response response = Response(requestOptions: RequestOptions(path: '22222'));
    try {
      response = await dioClient.post(AppConstant.notificationReadCountURI,data: {});
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }
}
