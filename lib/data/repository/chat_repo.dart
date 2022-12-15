

import 'dart:convert';

import 'package:als_frontend/data/datasource/remote/exception/api_error_handler.dart';
import 'package:als_frontend/data/model/response/base/api_response.dart';
import 'package:als_frontend/data/model/response/chat/offline_chat_model.dart';
import 'package:als_frontend/data/repository/auth_repo.dart';
import 'package:als_frontend/util/app_constant.dart';
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../datasource/remote/dio/dio_client.dart';

double progressPercent = 0;
class ChatRepo{
  final DioClient dioClient;
  final AuthRepo authRepo1;
  final SharedPreferences sharedPreferences;
  ChatRepo({required this.dioClient,
    required this.sharedPreferences,
    required this.authRepo1,
  });
  Future<ApiResponse> getUserAllChatLists(int pageNO) async {
    Response response = Response(requestOptions: RequestOptions(path: '22222'));
    try{
      response =  await dioClient.get("${AppConstant.messageRoomList}?page=$pageNO&size=10");
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }
  Future<ApiResponse> getUserP2PChatLists(String roomID, int pageNo) async {
    Response response = Response(requestOptions: RequestOptions(path: '22222'));
    try{
      response =   await dioClient.get('${AppConstant.chatRoomListUri}$roomID/?page=$pageNo&size=20');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }
  Future<ApiResponse> getChatMessageBetweenTwoUser(String personID, int pageNo) async {
    Response response = Response(requestOptions: RequestOptions(path: '22222'));
    try{
      response =   await dioClient.get('${AppConstant.chatMessageBetweenTwoUserURI}${authRepo1.getUserID()}/$personID/?page=$pageNo&size=20');
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }
  Future<ApiResponse> callForGetRoomID(String userID) async {
    Response response = Response(requestOptions: RequestOptions(path: '22222'));
    try{
      response =  await dioClient.post(AppConstant.messageRoomCreateList, data: userID);
      return ApiResponse.withSuccess(response);
    } catch (e) {
      return ApiResponse.withError(ApiErrorHandler.getMessage(e), response);
    }
  }

  List<OfflineChat> getChatData() {
    List<String> chatsSave = sharedPreferences.getStringList(AppConstant.chats) ?? [];
    List<OfflineChat> chatData = [];
    for (var cart in chatsSave) {
      chatData.add(OfflineChat.fromJson(jsonDecode(cart)));
    }
    return chatData;
  }

  void addToChatList(List<OfflineChat> chatList) {
    List<String> chats = [];
    for (var chat in chatList) {
      chats.add(jsonEncode(chat));
    }
    sharedPreferences.setStringList(AppConstant.chats, chats);
  }


}