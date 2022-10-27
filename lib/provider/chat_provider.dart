import 'dart:async';
import 'dart:convert';

import 'package:als_frontend/data/model/response/chat/AllMessageChatListModel.dart';
import 'package:als_frontend/data/model/response/chat/ChatMessageModel.dart';
import 'package:als_frontend/data/repository/auth_repo.dart';
import 'package:als_frontend/data/repository/chat_repo.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class ChatProvider with ChangeNotifier {
  final ChatRepo chatRepo;
  final AuthRepo authRepo;

  ChatProvider({required this.chatRepo, required this.authRepo});

  bool _isLoading = false;

  bool get isLoading => _isLoading;

//TODO; Get ALl Chats
  List<AllMessageChatListModel> allChatsLists = [];
  List<AllMessageChatListModel> allChatsListsCopy = [];

  initializeAllChats(BuildContext context) async {
    _isLoading = true;
    allChatsLists.clear();
    allChatsLists = [];
    allChatsListsCopy.clear();
    allChatsListsCopy = [];
    // notifyListeners();
    Response apiResponse = await chatRepo.getUserAllChatLists();
    _isLoading = false;
    if (apiResponse.statusCode == 200) {
      apiResponse.body['results'].forEach((element) {
        allChatsLists.add(AllMessageChatListModel.fromJson(element));
      });
      allChatsListsCopy.addAll(allChatsLists);
    } else {
      //showScaffoldSnackBar(context: context, message: apiResponse.error.toString());
      allChatsLists = [];
    }
    notifyListeners();
  }

//TODO; Get p2p Chats
  List<ChatMessageModel> p2pChatLists = [];
  List<ChatMessageModel> p2pChatListsTemp = [];
  bool isBottomLoading = false;
  bool hasNextMessage = false;
  int selectPage = 1;

  updatePageNo(String roomID, Function callBack) {
    selectPage++;
    initializeP2PChats(roomID, callBack, page: selectPage);
    notifyListeners();
  }

  initializeP2PChats(String roomID, Function callBack, {int page = 1}) async {
    if (page == 1) {
      p2pChatLists.clear();
      p2pChatLists = [];
      _isLoading = true;
      isBottomLoading = false;
      hasNextMessage = false;
      selectPage = 1;
    } else {
      isBottomLoading = true;
      notifyListeners();
    }
    p2pChatListsTemp.clear();
    p2pChatListsTemp = [];
    Response apiResponse = await chatRepo.getUserP2PChatLists(roomID, page);
    _isLoading = false;
    isBottomLoading = false;
    if (apiResponse.statusCode == 200) {
      hasNextMessage = apiResponse.body['next'] != null ? true : false;
      apiResponse.body['results'].forEach((element) {
        p2pChatListsTemp.add(ChatMessageModel.fromJson(element));
      });

      p2pChatLists.insertAll(0, p2pChatListsTemp);
      callBack(true);
      print(p2pChatLists.length);
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

  //TODO:  ********    for Web Socket
  WebSocketChannel channel = IOWebSocketChannel.connect('wss://als-social.com/ws/post/191/comment/timeline_post/');

  userPostComments(AllMessageChatListModel model, int index) {
    channel.stream.listen((data) {
      ChatMessageModel commentData = ChatMessageModel.fromJson(jsonDecode(data)['chat_data']);
      p2pChatLists.add(commentData);
      allChatsLists[index].lastSms = commentData.text;
      allChatsLists[index].updateAt = commentData.timestamp;

      AllMessageChatListModel updateChatUser = allChatsLists[index];
      allChatsLists.removeAt(index);
      allChatsLists.insert(0, updateChatUser);
      notifyListeners();
    }, onDone: () {
      print("disconected");
    });
  }

  channelDismiss() {
    channel.sink.close();
    notifyListeners();
  }

  initializeSocket(AllMessageChatListModel model, int index) {
    channel = IOWebSocketChannel.connect('wss://als-social.com/ws/messaging/thread/${model.id}/');
    userPostComments(model, index);
  }

  bool sendMessageLoading = false;
  var ticker;
  int value = 0;
  bool hasConnection = false;
  int anotherAddStatus = 0;

  addPost(String userID, String roomID, String message, Function status, AllMessageChatListModel model, int index) async {
    sendMessageLoading = true;
    bool result = await InternetConnectionChecker().hasConnection;
    value = 0;
    anotherAddStatus = 0;
    hasConnection = false;
    if (result == true) {
      channel.sink.add(
        jsonEncode({
          "data": {"user_id": userID, "room_id": roomID, "text": message},
          "action": "chat"
        }),
      );
    } else {
      ticker = Timer.periodic(Duration(seconds: 5), (timer) async {
        value++;
        result = await InternetConnectionChecker().hasConnection;
        if (result == true) {
          timer.cancel();
          ticker.cancel();
          channel = IOWebSocketChannel.connect('wss://als-social.com/ws/messaging/thread/$roomID/');
          channel.sink.add(
            jsonEncode({
              "data": {"user_id": userID, "room_id": roomID, "text": message},
              "action": "chat"
            }),
          );
          status(1);
          channel.stream.listen((data) {
            ChatMessageModel commentData = ChatMessageModel.fromJson(jsonDecode(data)['chat_data']);
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
            print("Trying for connect : disconected");
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
        }
        notifyListeners();
      });
    }

    status(1);
    sendMessageLoading = false;

    notifyListeners();
  }

//
// changeAddressSelectIndex(int index) {
//   selectAddressIndex = index;
//   notifyListeners();
// }
//
// // get all countries
// List<Country> countries = [];
// Country? selectCountries;
// bool _isLoadingCountries = false;
//
// bool get isLoadingCountries => _isLoadingCountries;
//
// initializeAllCountry(BuildContext context) async {
//   _isLoadingCountries = true;
//   countries.clear();
//   countries = [];
//   ApiResponse apiResponse = await profileRepo.getCountries();
//   _isLoadingCountries = false;
//   if (apiResponse.response.statusCode == 200) {
//     apiResponse.response.data['value'].forEach((element) {
//       countries.add(Country.fromJson(element));
//     });
//     selectCountries = countries[0];
//     initializeAllCity(context, selectCountries!.id);
//     notifyListeners();
//   } else {
//     showScaffoldSnackBar(context: context, message: apiResponse.error.toString());
//   }
// }
//
// changeCountry(Country c, BuildContext context) {
//   selectCountries = c;
//   initializeAllCity(context, c.id);
//   notifyListeners();
// }
//
// // get all Cities
// List<City> cities = [];
// City? selectCity;
// bool _isLoadingCity = false;
//
// bool get isLoadingCity => _isLoadingCity;
//
// initializeAllCity(BuildContext context, int countryID) async {
//   _isLoadingCity = true;
//   cities.clear();
//   cities = [];
//   ApiResponse apiResponse = await profileRepo.getCitiesByCountryID(countryID);
//   _isLoadingCity = false;
//   if (apiResponse.response.statusCode == 200) {
//     apiResponse.response.data['value'].forEach((element) {
//       cities.add(City.fromJson(element));
//     });
//     if (countryID == 11) {
//       selectCity = cities[cities.length - 9];
//     } else {
//       selectCity = cities[0];
//     }
//
//     notifyListeners();
//   } else {
//     showScaffoldSnackBar(context: context, message: apiResponse.error.toString());
//   }
// }
//
// changeCities(City c, BuildContext context) {
//   selectCity = c;
//   notifyListeners();
// }
//
// //
// // for Remember Me Section
//
// bool _isActiveRememberMe = true;
//
// bool get isDefault => _isActiveRememberMe;
//
// toggleRememberMe() {
//   _isActiveRememberMe = !_isActiveRememberMe;
//   notifyListeners();
// }
//
// // add address
// bool _isLoadingAddAddress = false;
//
// bool get isLoadingAddAddress => _isLoadingAddAddress;
//
// addEditAddress(Map address, BuildContext context, Function callBack, {bool isEdit = false}) async {
//   _isLoadingAddAddress = true;
//   notifyListeners();
//   ApiResponse apiResponse;
//   if (isEdit) {
//     apiResponse = await profileRepo.editAddress(address);
//   } else {
//     apiResponse = await profileRepo.addAddress(address);
//   }
//   _isLoadingAddAddress = false;
//   if (apiResponse.response.statusCode == 201 || apiResponse.response.statusCode == 200) {
//     showScaffoldSnackBar(context: context, message: apiResponse.response.data['message'], isError: false);
//     initializeAllAddress(context);
//     callBack(true);
//   } else {
//     print(apiResponse.error.toString());
//     showScaffoldSnackBar(context: context, message: apiResponse.error.toString());
//     callBack(false);
//   }
//   notifyListeners();
// }
//
// deleteAddress(BuildContext context, String addressID) async {
//   _isLoading = true;
//   ApiResponse apiResponse = await profileRepo.deleteAddress(addressID);
//   _isLoading = false;
//   if (apiResponse.response.statusCode == 200) {
//     showScaffoldSnackBar(context: context, message: apiResponse.response.data['message'], isError: false);
//     initializeAllAddress(context);
//   } else {
//     showScaffoldSnackBar(context: context, message: apiResponse.error.toString());
//   }
//   notifyListeners();
// }
//
// // get User
// ProfileModel? user;
//
// getUserProfiles(BuildContext context) async {
//   _isLoading = true;
//   ApiResponse apiResponse = await profileRepo.getCustomerProfile();
//   _isLoading = false;
//   if (apiResponse.response.statusCode == 200) {
//     user = ProfileModel.fromJson(apiResponse.response.data['value']);
//     print(user!.toJson());
//   } else {
//     showScaffoldSnackBar(context: context, message: apiResponse.error.toString());
//   }
//   notifyListeners();
// }
//
// String _profileImage = '';
//
// String get profileImage => _profileImage;
// bool isLoadingUpload = false;
//
// updateProfileImage(BuildContext context, File file) async {
//   _profileImage = '';
//   isLoadingUpload = true;
//   notifyListeners();
//   ApiResponse apiResponse = await profileRepo.uploadPhoto(file);
//   isLoadingUpload = false;
//   if (apiResponse.response.statusCode == 200) {
//     _profileImage = apiResponse.response.data['uploadedFiles'][0]['filePath'];
//
//     Map map = {
//       "firstname": user!.firstname,
//       "lastname": user!.lastname,
//       "age": user!.age,
//       "email": 'test@gmail.com',
//       "mobile": user!.mobile,
//       "birthday": user!.birthday,
//       "darkMode": user!.darkMode,
//       "image": _profileImage
//     };
//
//     updateProfile(context, map);
//
//     showCustomSnackBar("Profile Picture Upload Successfully", context, isError: false);
//   } else {
//     showCustomSnackBar(apiResponse.error.toString(), context);
//   }
//   notifyListeners();
// }
//
// bool isUpdateProfilePassword = false;
//
// updateProfile(BuildContext context, Map map) async {
//   _isLoading = true;
//   notifyListeners();
//   ApiResponse apiResponse = await profileRepo.updateProfile(map);
//   _isLoading = false;
//   if (apiResponse.response.statusCode == 200) {
//     user = ProfileModel.fromJson(apiResponse.response.data['value']);
//     showCustomSnackBar(apiResponse.response.data['message'], context, isError: false);
//     authRepo.clearFirstName();
//     authRepo.saveFirstName(user!.firstname!);
//   } else {
//     showCustomSnackBar(apiResponse.error.toString(), context);
//   }
//   notifyListeners();
// }
//
// bool _isLoadingPassword = false;
//
// bool get isLoadingPassword => _isLoadingPassword;
//
// updatePassword(BuildContext context, Map<String, dynamic> map, Function callBack) async {
//   _isLoadingPassword = true;
//   notifyListeners();
//   ApiResponse apiResponse = await profileRepo.updatePassword(map);
//   _isLoadingPassword = false;
//   if (apiResponse.response.statusCode == 200) {
//     showCustomSnackBar(apiResponse.response.data['message'], context, isError: false);
//     callBack(true);
//   } else {
//     showCustomSnackBar(apiResponse.error.toString(), context);
//     callBack(false);
//   }
//   notifyListeners();
// }
//
// bool isMaximize = false;
//
// changeMaximize({bool isFirstTime = false}) {
//   if (isFirstTime) {
//     isMaximize = true;
//   } else {
//     isMaximize = true;
//     notifyListeners();
//   }
// }
}
