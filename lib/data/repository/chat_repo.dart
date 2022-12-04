import 'dart:convert';

import 'package:als_frontend/data/datasource/api_client.dart';
import 'package:als_frontend/data/model/response/chat/chat_message_model.dart';
import 'package:als_frontend/data/model/response/chat/offline_chat_model.dart';
import 'package:als_frontend/data/repository/auth_repo.dart';
import 'package:als_frontend/util/app_constant.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatRepo {
  final ApiClient apiClient;
  final AuthRepo authRepo;
  final SharedPreferences sharedPreferences;

  ChatRepo({required this.apiClient, required this.authRepo, required this.sharedPreferences});

  Future<Response> getUserAllChatLists(int pageNO) async {
    return await apiClient.getData(AppConstant.messageRoomList + "?page=$pageNO&size=10");
  }

  Future<Response> getUserP2PChatLists(String roomID, int pageNo) async {
    return await apiClient.getData('${AppConstant.chatRoomListUri}$roomID/?page=$pageNo&size=20');
  }

  Future<Response> getChatMessageBetweenTwoUser(String personID, int pageNo) async {
    return await apiClient.getData('${AppConstant.chatMessageBetweenTwoUserURI}${authRepo.getUserID()}/$personID/?page=$pageNo&size=20');
  }

  Future<Response> callForGetRoomID(String userID) async {
    return await apiClient.postData(AppConstant.messageRoomCreateList, {"user": userID});
  }

  List<OfflineChat> getChatData() {
    List<String> chatsSave = sharedPreferences.getStringList(AppConstant.chats) ?? [];
    List<OfflineChat> chatData = [];
    chatsSave.forEach((cart) => chatData.add(OfflineChat.fromJson(jsonDecode(cart))));
    return chatData;
  }

  void addToChatList(List<OfflineChat> chatList) {
    List<String> chats = [];
    chatList.forEach((chat) => chats.add(jsonEncode(chat)));
    sharedPreferences.setStringList(AppConstant.chats, chats);
  }
}
