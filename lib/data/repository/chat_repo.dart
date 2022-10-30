import 'package:als_frontend/data/datasource/api_client.dart';
import 'package:als_frontend/util/app_constant.dart';
import 'package:get/get_connect/http/src/response/response.dart';

class ChatRepo {
  final ApiClient apiClient;

  ChatRepo({required this.apiClient});

  Future<Response> getUserAllChatLists(int pageNO) async {
    return await apiClient.getData(AppConstant.messageRoomList + "?page=$pageNO&size=10");
  }

  Future<Response> getUserP2PChatLists(String roomID, int pageNo) async {
    return await apiClient.getData('${AppConstant.chatRoomList}$roomID/?page=$pageNo&size=10');
  }

  Future<Response> callForGetRoomID(String userID) async {
    return await apiClient.postData(AppConstant.messageRoomCreateList, {"user": userID});
  }
}
