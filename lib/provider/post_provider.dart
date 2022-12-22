import 'dart:convert';
import 'dart:io';

import 'package:als_frontend/data/model/response/base/api_response.dart';
import 'package:als_frontend/data/model/response/image_video_detect_model.dart';
import 'package:als_frontend/data/model/response/news_feed_model.dart';
import 'package:als_frontend/data/repository/auth_repo.dart';
import 'package:als_frontend/data/repository/post_repo.dart';
import 'package:als_frontend/helper/image_compressure.dart';
import 'package:als_frontend/util/helper.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

class PostResponse {
  NewsFeedModel? newsFeedData;
  bool? status;

  PostResponse({this.newsFeedData, this.status});
}

class PostProvider with ChangeNotifier {
  final PostRepo postRepo;
  final AuthRepo authRepo;

  PostProvider({required this.postRepo, required this.authRepo});

  bool isLoading = false;
  FormData formData = FormData();
  String body = "";

  calculateMultipartFile() {
    formData = FormData();

    if (afterConvertImageLists.isNotEmpty) {
      for (int i = 0; i < afterConvertImageLists.length; i++) {
        formData.files.add(MapEntry(
            'image',
            MultipartFile(afterConvertImageLists[i].readAsBytes().asStream(), afterConvertImageLists[i].lengthSync(),
                filename: afterConvertImageLists[i].path.split("/").last)));
      }
    }
    if (video.isNotEmpty) {
      for (int i = 0; i < video.length; i++) {
        formData.files.add(MapEntry(
            'video', MultipartFile(video[i].readAsBytes().asStream(), video[i].lengthSync(), filename: video[i].path.split("/").last)));
      }
    }
    notifyListeners();
  }

  disCardPost() {
    status = 1;
    isLoading = false;
    notifyListeners();
  }

  int status = 0;
  double uploadPercent = 0.0;

  Future<PostResponse> addPost(String postText, {bool isFromGroup = false, bool isFromPage = false, int groupPageID = 0}) async {
    body = postText;
    isLoading = true;
    uploadPercent = 0.0;
    notifyListeners();
    calculateMultipartFile();

    ApiResponse apiResponse;
    formData.fields.add(MapEntry('description', postText));
    if (isFromGroup) {
      apiResponse = await postRepo.submitPostTOGroupBYUSINGGroupID(formData, groupPageID, onSendProgress: (int sentBytes, int totalBytes) {
        progressPercent = sentBytes / totalBytes * 100;
        uploadPercent = (progressPercent / 100);

        showLog("Progress: $progressPercent %");
        if (progressPercent == 100) {
          uploadPercent = 1.0;
          showLog('finished');
        }
        notifyListeners();
        showOneTimeNotification();
      });
    } else if (isFromPage) {
      apiResponse = await postRepo.submitPostTOPageBYUSINGPageID(formData, groupPageID, onSendProgress: (int sentBytes, int totalBytes) {
        progressPercent = sentBytes / totalBytes * 100;
        uploadPercent = (progressPercent / 100);

        showLog("Progress: $progressPercent %");
        if (progressPercent == 100) {
          uploadPercent = 1.0;
          showLog('finished');
        }
        notifyListeners();
        showOneTimeNotification();
      });
    } else {
      apiResponse = await postRepo.submitPost(formData, onSendProgress: (int sentBytes, int totalBytes) {
        progressPercent = sentBytes / totalBytes * 100;
        uploadPercent = (progressPercent / 100);

        showLog("Send Progress: $uploadPercent %");
        if (progressPercent == 100) {
          uploadPercent = 1.0;
          showLog('finished');
        }
        notifyListeners();
        showOneTimeNotification();
      });
    }
    if (apiResponse.response.statusCode == 201 || apiResponse.response.statusCode == 200) {
      Fluttertoast.showToast(msg: "Posted");
      NewsFeedModel n = NewsFeedModel.fromJson(apiResponse.response.data);
      isLoading = false;
      status = 0;
      notifyListeners();
      return PostResponse(newsFeedData: n, status: true);
    } else {
      isLoading = true;
      status = 1;
      notifyListeners();
      Fluttertoast.showToast(msg: "Something went wrong!");
      return PostResponse(newsFeedData: NewsFeedModel(), status: false);
    }
  }

  Future<PostResponse> updatePost(String postText, int id, {bool isFromGroup = false, bool isFromPage = false, int groupPageID = 0}) async {
    isLoading = true;
    calculateMultipartFile();
    ApiResponse apiResponse;
    formData.fields.add(MapEntry('description', postText));
    formData.fields.add(MapEntry('deleted_image', jsonEncode(deletedImagesIDS)));
    formData.fields.add(MapEntry('deleted_video', jsonEncode(deletedVideoIDS)));

    if (isFromGroup) {
      apiResponse =
          await postRepo.updatePostTOGroupBYUSINGGroupID(formData, groupPageID, id, onSendProgress: (int sentBytes, int totalBytes) {
        progressPercent = sentBytes / totalBytes * 100;
        if (progressPercent == 100) {
          // dispose();
        }
      });
    } else if (isFromPage) {
      apiResponse =
          await postRepo.updatePostTOPageBYUSINGPageID(formData, groupPageID, id, onSendProgress: (int sentBytes, int totalBytes) {
        progressPercent = sentBytes / totalBytes * 100;
        if (progressPercent == 100) {
          // dispose();
        }
      });
    } else {
      apiResponse = await postRepo.updatePost(formData, id, onSendProgress: (int sentBytes, int totalBytes) {
        progressPercent = sentBytes / totalBytes * 100;
        if (progressPercent == 100) {
          // dispose();
        }
      });
    }
    isLoading = false;
    if (apiResponse.response.statusCode == 201 || apiResponse.response.statusCode == 200) {
      Fluttertoast.showToast(msg: "Updated Successfully");
      NewsFeedModel n = NewsFeedModel.fromJson(apiResponse.response.data);
      notifyListeners();
      return PostResponse(newsFeedData: n, status: true);
    } else {
      Fluttertoast.showToast(msg: "Something went wrong!");
      return PostResponse(newsFeedData: NewsFeedModel(), status: false);
    }
  }

  List<XFile> imageFile = [];
  List<File> afterConvertImageLists = [];
  File? singleImage;
  List<File> video = [];
  final _picker = ImagePicker();

  void pickImage() async {
    imageFile = [];
    var pickedFile = await _picker.pickMultiImage();
    if (pickedFile.isNotEmpty) {
      imageFile.addAll(pickedFile);
      for (var element in imageFile) {
        singleImage = File(element.path);
        afterConvertImageLists.add(await imageCompressed(imagePathToCompress: singleImage!));
        await imageCompressed(imagePathToCompress: singleImage!);
        notifyListeners();
      }
    }
  }

  Future pickVideo() async {
    final pickedFile = await _picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      video.add(File(pickedFile.path));
      notifyListeners();
    }
  }

  clearImageVideo({bool isFirstTime = false}) {
    video.clear();
    video = [];
    afterConvertImageLists.clear();
    afterConvertImageLists = [];
    imageVideoLists.clear();
    imageVideoLists = [];
    if (!isFirstTime) notifyListeners();
  }

  cancelImageFromList(int index) {
    afterConvertImageLists.removeAt(index);
    notifyListeners();
  }

  cancelVideoFromList(int index) {
    video.removeAt(index);
    notifyListeners();
  }

  List<ImageVideoDetectModel> imageVideoLists = [];

  initializeImageVideo(NewsFeedModel newsFeedData) {
    deletedImagesIDS.clear();
    deletedVideoIDS.clear();
    deletedImagesIDS = [];
    deletedVideoIDS = [];

    for (var element in newsFeedData.images!) {
      imageVideoLists.add(ImageVideoDetectModel(true, element.image!, '', element.id!.toString(), newsFeedData.description!));
    }

    for (var element in newsFeedData.videos!) {
      imageVideoLists
          .add(ImageVideoDetectModel(false, element.thumbnail!, element.video!, element.id!.toString(), newsFeedData.description!));
    }
    notifyListeners();
  }

  List<int> deletedImagesIDS = [];
  List<int> deletedVideoIDS = [];

  clearUserImage(int index) {
    if (imageVideoLists[index].isImage) {
      deletedImagesIDS.add(int.parse(imageVideoLists[index].id));
    } else {
      deletedVideoIDS.add(int.parse(imageVideoLists[index].id));
    }
    imageVideoLists.removeAt(index);
    notifyListeners();
  }

  //// for report post
  Future<bool> reportPost(String report, int id, {bool isFromGroup = false, bool isFromPage = false}) async {
    isLoading = true;
    ApiResponse response;
    if (isFromGroup) {
      response = await postRepo.reportGroupPost({"report_note": report, "report_type": "1"}, id);
    } else if (isFromPage) {
      response = await postRepo.reportPagePost({"report_note": report, "report_type": "1"}, id);
    } else {
      response = await postRepo.reportPost({"report_note": report}, id);
    }
    isLoading = false;
    if (response.response.statusCode == 201 || response.response.statusCode == 200) {
      Fluttertoast.showToast(msg: "Report Added Successfully On this post");
      notifyListeners();
      return true;
    } else {
      Fluttertoast.showToast(msg: "Something went wrong!");
      return false;
    }
  }

  //// for delete post
  Future<bool> deletePost(String url) async {
    isLoading = true;
    notifyListeners();
    ApiResponse response = await postRepo.deletePost(url);

    isLoading = false;
    if (response.response.statusCode == 204 || response.response.statusCode == 301) {
      Fluttertoast.showToast(msg: 'Post Deleted Successfully');
      notifyListeners();
      return true;
    } else {
      Fluttertoast.showToast(msg: response.error!.toString());
      return false;
    }
  }

  //// for Share post
  Future<PostResponse> sharePost(String url, String description, NewsFeedModel newsfeedData) async {
    isLoading = true;
    notifyListeners();
    ApiResponse response = await postRepo.sharePost(url, description);

    isLoading = false;
    if (response.response.statusCode == 201) {
      Fluttertoast.showToast(msg: 'Post Share Successfully');
      SharePost n = SharePost.fromJson(response.response.data);
      NewsFeedModel newsFeedData = newsfeedData;
      newsFeedData.isShare = true;
      newsFeedData.sharePost = n;
      newsFeedData.description = description;
      newsFeedData.timestamp = DateTime.now().toString();
      newsFeedData.author =
          Author(id: int.parse(authRepo.getUserID()), fullName: authRepo.getUserName(), profileImage: authRepo.getUserProfile());
      newsFeedData.images = [];
      newsFeedData.videos = [];
      notifyListeners();
      return PostResponse(newsFeedData: newsFeedData, status: true);
    } else {
      Fluttertoast.showToast(msg: response.error.toString());
      return PostResponse(newsFeedData: NewsFeedModel(), status: false);
    }
  }

  ////// TODO: for local Notification
  FlutterLocalNotificationsPlugin? fLutterLocalNotificationsPlugin;

  initializeNotificationSettings() {
    var androidInitialize = const AndroidInitializationSettings('ic_launcher');
    var iosInitialize = const DarwinInitializationSettings();
    var initializesSettings = InitializationSettings(android: androidInitialize, iOS: iosInitialize);
    fLutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    fLutterLocalNotificationsPlugin!.initialize(initializesSettings);
    showScheduledTimeNotification();
  }

  Future notificationSelected(String payload) async {
    showLog('Selected $payload');
  }

  AndroidNotificationDetails? androidDetails;
  DarwinNotificationDetails? iosDetails;
  NotificationDetails? generalNotificationDetails;

  Future showScheduledTimeNotification() async {
    androidDetails = const AndroidNotificationDetails('channelId', 'Feedback',
        channelDescription: 'This is My channel', importance: Importance.max, autoCancel: false);
    iosDetails = const DarwinNotificationDetails();
    generalNotificationDetails = NotificationDetails(android: androidDetails, iOS: iosDetails);
  }

  Future showOneTimeNotification() async {
    androidDetails = const AndroidNotificationDetails('channelId', 'Feedback',
        channelDescription: 'This is My channel', importance: Importance.low, autoCancel: true, colorized: true, ongoing: true);
    iosDetails = const DarwinNotificationDetails();
    var generalNotificationDetails = NotificationDetails(android: androidDetails, iOS: iosDetails);
    fLutterLocalNotificationsPlugin!.show(0, progressPercent == 100 ? "Post uploading finished" : "Post uploading",
        progressPercent == 100 ? "100 %" : "Completed ${(uploadPercent * 100).toStringAsFixed(1)}%", generalNotificationDetails,
        payload: 'Task');
    showLog("notification progress: =>  ${uploadPercent.toString()}");
    if (progressPercent == 100) {
      await fLutterLocalNotificationsPlugin!.cancel(0);
    }
  }
}
