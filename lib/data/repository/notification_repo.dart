import 'package:als_frontend/data/datasource/api_client.dart';
import 'package:als_frontend/util/app_constant.dart';
import 'package:get/get_connect/http/src/response/response.dart';

class NotificationRepo {
  final ApiClient apiClient;
  NotificationRepo({required this.apiClient});

  Future<Response> getAllNotification(int pageNo) async {
    return await apiClient.getData("${AppConstant.notificationListURI}?page=$pageNo&size=10");
  }

  Future<Response> getNotificationUnreadCount() async {
    return await apiClient.postData(AppConstant.notificationUnreadCountURI, {});
  }

  Future<Response> getNotificationReadCount() async {
    return await apiClient.postData(AppConstant.notificationReadCountURI, {});
  }
}
