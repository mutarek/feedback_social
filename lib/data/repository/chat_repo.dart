import 'package:als_frontend/data/datasource/api_client.dart';
import 'package:als_frontend/util/app_constant.dart';
import 'package:get/get_connect/http/src/response/response.dart';

class ChatRepo {
  final ApiClient apiClient;

  ChatRepo({required this.apiClient});

  Future<Response> getUserAllChatLists() async {
    return await apiClient.getData(AppConstant.messageRoomList);
  }

  Future<Response> getUserP2PChatLists(String roomID, int pageNo) async {
    return await apiClient.getData('${AppConstant.chatRoomList}$roomID/?page=$pageNo&size=10');
  }
}
