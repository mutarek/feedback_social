import 'dart:async';
import 'dart:convert';
import 'package:als_frontend/data/model/response/base/api_response.dart';
import 'package:als_frontend/data/model/response/chat/all_message_chat_list_model.dart';
import 'package:als_frontend/data/model/response/chat/chat_message_model.dart';
import 'package:als_frontend/data/model/response/chat/offline_chat_model.dart';
import 'package:als_frontend/data/repository/auth_repo.dart';
import 'package:als_frontend/data/repository/chat_repo.dart';
import 'package:als_frontend/util/app_constant.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatProvider with ChangeNotifier {
  final ChatRepo chatRepo;
  final AuthRepo authRepo;

  ChatProvider({required this.chatRepo, required this.authRepo});

  bool _isLoading = false;
  static SharedPreferences? sharedPreferences;

  bool get isLoading => _isLoading;

//TODO; Get ALl Chats
  List<AllMessageChatListModel> allChatsLists = [];
  List<AllMessageChatListModel> allChatsListsCopy = [];
  List<OfflineChat> offlineChatList = [];

  updatePageNoAllChats() {
    selectPage++;
    initializeAllChats(page: selectPage);
    notifyListeners();
  }

  initializeAllChats({int page = 1, bool isFirstTime = true}) async {
    if (page == 1) {
      allChatsLists.clear();
      allChatsLists = [];
      allChatsListsCopy.clear();
      allChatsListsCopy = [];
      _isLoading = true;
      isBottomLoading = false;
      hasNextData = false;
      selectPage = 1;
      if (!isFirstTime) notifyListeners();
    } else {
      isBottomLoading = true;
      notifyListeners();
    }

    // notifyListeners();
    ApiResponse apiResponse = await chatRepo.getUserAllChatLists(page);
    _isLoading = false;
    isBottomLoading = false;
    if (apiResponse.response.statusCode == 200) {
      hasNextData = apiResponse.response.data['next'] != null ? true : false;
      apiResponse.response.data['results'].forEach((element) {
        allChatsLists.add(AllMessageChatListModel.fromJson(element));
      });
      allChatsListsCopy.addAll(allChatsLists);
    } else {
      //showScaffoldSnackBar(context: context, message: apiResponse.error.toString());

    }
    notifyListeners();
  }

//TODO; Get p2p Chats
  List<ChatMessageModel> p2pChatLists = [];
  List<ChatMessageModel> p2pChatListsTemp = [];
  bool isBottomLoading = false;
  bool hasNextData = false;
  int selectPage = 1;

  updatePageNo(Function callBack,
      {bool isFromChatTwoUser = false, int userID = 0}) {
    selectPage++;
    initializeP2PChats(callBack,
        page: selectPage, userID: userID, isFromChatTwoUser: isFromChatTwoUser);
    notifyListeners();
  }

  initializeP2PChats(Function callBack,
      {int page = 1, bool isFromChatTwoUser = false, int userID = 0}) async {
    if (page == 1) {
      p2pChatLists.clear();
      p2pChatLists = [];
      _isLoading = true;
      isBottomLoading = false;
      hasNextData = false;
      selectPage = 1;
    } else {
      isBottomLoading = true;
      notifyListeners();
    }
    p2pChatListsTemp.clear();
    p2pChatListsTemp = [];
    ApiResponse apiResponse;
    if (isFromChatTwoUser) {
      apiResponse =
      await chatRepo.getChatMessageBetweenTwoUser(userID.toString(), page);
    } else {
      apiResponse = await chatRepo.getUserP2PChatLists(chatModels.id!, page);
    }

    _isLoading = false;
    isBottomLoading = false;
    notifyListeners();
    if (apiResponse.response.statusCode == 200) {
      hasNextData = apiResponse.response.data['next'] != null ? true : false;
      apiResponse.response.data['results'].forEach((element) {
        p2pChatListsTemp.add(ChatMessageModel.fromJson(element));
      });

      p2pChatLists.insertAll(0, p2pChatListsTemp);
      callBack(true);

      notifyListeners();
    } else {
      //showScaffoldSnackBar(context: context, message: apiResponse.error.toString());

    }
    notifyListeners();
  }

  String userName() {
    return authRepo.getUserName();
  }

  String userID() {
    return authRepo.getUserID();
  }

  bool isChangeValue = false;

  //TODO:  ********    for Web Socket
  WebSocketChannel channel = IOWebSocketChannel.connect('${AppConstant.socketBaseUrl}ws/post/191/comment/timeline_post/');

  userPostComments(AllMessageChatListModel model, int index,
      {bool isFromProfile = false}) {
    channel.stream.listen((data) {
      isChangeValue = true;
      notifyListeners();
      ChatMessageModel commentData =
      ChatMessageModel.fromJson(jsonDecode(data)['chat_data']);
      p2pChatLists.add(commentData);
      if (!isFromProfile) {
        allChatsLists[index].lastSms = commentData.text;
        allChatsLists[index].updateAt = commentData.timestamp;
        AllMessageChatListModel updateChatUser = allChatsLists[index];
        allChatsLists.removeAt(index);
        allChatsLists.insert(0, updateChatUser);
      }
      isChangeValue = false;
      notifyListeners();
    }, onDone: () {
      debugPrint("disconected");
    });
  }

  channelDismiss() {
    channel.sink.close();
    notifyListeners();
  }

  initializeSocket(int index, {bool isFromProfile = false}) {
    channel = IOWebSocketChannel.connect('${AppConstant.socketBaseUrl}ws/messaging/thread/${chatModels.id}/');
    userPostComments(chatModels, index, isFromProfile: isFromProfile);
  }

  bool sendMessageLoading = false;
  var ticker;
  int value = 0;
  bool hasConnection = false;
  int anotherAddStatus = 0;

  addPost(String userID, String message, Function status, int index) async {
    sendMessageLoading = true;
    bool result = await InternetConnectionChecker().hasConnection;
    value = 0;
    anotherAddStatus = 0;
    hasConnection = false;
    if (result == true) {
      Map map = {
        "data": {
          "user_id": userID.toString(),
          "room_id": chatModels.id,
          "text": message
        },
        "action": "chat"
      };
      channel.sink.add(jsonEncode(map));
    } else {
      ticker = Timer.periodic(const Duration(seconds: 5), (timer) async {
        value++;
        result = await InternetConnectionChecker().hasConnection;
        if (result == true) {
          timer.cancel();
          ticker.cancel();
          channel = IOWebSocketChannel.connect('${AppConstant.socketBaseUrl}ws/messaging/thread/${chatModels.id}/');
          channel.sink.add(
            jsonEncode({
              "data": {
                "user_id": userID,
                "room_id": chatModels.id,
                "text": message
              },
              "action": "chat"
            }),
          );
          status(1);
          channel.stream.listen((data) {
            ChatMessageModel commentData =
            ChatMessageModel.fromJson(jsonDecode(data)['chat_data']);
            p2pChatLists.add(commentData);
            allChatsLists[index].lastSms = commentData.text;
            allChatsLists[index].updateAt = commentData.timestamp;

            AllMessageChatListModel updateChatUser = allChatsLists[index];
            allChatsLists.removeAt(index);
            allChatsLists.insert(0, updateChatUser);
            notifyListeners();

            hasConnection = true;
          }, onDone: () {
            if (value > 5) {
              timer.cancel();
              ticker.cancel();
            }
            debugPrint("Trying for connect : disconnected");
          }, onError: (error) {
            if (value > 5) {
              timer.cancel();
              ticker.cancel();
            }
          });
        }

        if (value > 5 || hasConnection) {
          timer.cancel();
          ticker.cancel();
          List<OfflineChat> chatModel = chatRepo.getChatData();
          chatModel.add(OfflineChat(userId: userID,roomID: chatModels.id.toString(),message: message,index: index));
          chatRepo.addToChatList(chatModel);
        }
        notifyListeners();
      });
    }

    status(1);
    sendMessageLoading = false;
    notifyListeners();
  }

  // TODO: message room  create
  bool isOneTime = false;

  resetOneTime() {
    isOneTime = true;
    p2pChatLists.clear();
    p2pChatLists = [];
    notifyListeners();
  }

  Future<int> createRoom(
      String userID, String customerID, String message, int index) async {
    _isLoading = true;
    notifyListeners();
    ApiResponse apiResponse = await chatRepo.callForGetRoomID(customerID);
    _isLoading = false;
    isOneTime = false;
    if (apiResponse.response.statusCode == 200) {
      AllMessageChatListModel messageChatListModel =
      AllMessageChatListModel.fromJson(apiResponse.response.data);
      changeChantModel(messageChatListModel);
      initializeSocket(0, isFromProfile: true);
      addPost(userID, message, (status) {}, index);
    } else {
      //showScaffoldSnackBar(context: context, message: apiResponse.error.toString());
      allChatsLists = [];
    }
    notifyListeners();
    return 1;
  }

  // initializeChat Model Data
  AllMessageChatListModel chatModels = AllMessageChatListModel();

  changeChantModel(AllMessageChatListModel c) {
    chatModels = c;
    notifyListeners();
  }
}
