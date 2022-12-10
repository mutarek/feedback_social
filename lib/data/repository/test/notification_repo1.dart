import 'package:als_frontend/data/datasource/remote/dio/dio_client.dart';
import 'package:als_frontend/data/datasource/remote/exception/api_error_handler.dart';
import 'package:als_frontend/data/model/response/base/api_response.dart';
import 'package:als_frontend/util/app_constant.dart';
import 'package:dio/dio.dart';

class NotificationRepo1 {
  final DioClient dioClient;
  NotificationRepo1({required this.dioClient});

  Future<ApiResponse> getAllNotification(int pageNo) async {
    Response response = Response(requestOptions: RequestOptions(path: '22222'));
    try {
      response = await dioClient.get(AppConstant.notificationListURI + "?page=$pageNo&size=10");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }

  }

  // Future<Response> getNotificationUnreadCount() async {
  //   return await apiClient.postData(AppConstant.notificationUnreadCountURI, {});
  // }
  //
  // Future<Response> getNotificationReadCount() async {
  //   return await apiClient.postData(AppConstant.notificationReadCountURI, {});
  // }
}