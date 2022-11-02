import 'dart:convert';
import 'dart:io';

import 'package:als_frontend/data/model/response/image_video_detect_model.dart';
import 'package:als_frontend/data/model/response/news_feed_model.dart';
import 'package:als_frontend/data/repository/post_repo.dart';
import 'package:als_frontend/helper/image_compressure.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:http/http.dart' as Http;
import 'package:image_picker/image_picker.dart';

class PostResponse {
  NewsFeedData? newsFeedData;
  bool? status;

  PostResponse({this.newsFeedData, this.status});
}

class PostProvider with ChangeNotifier {
  final PostRepo postRepo;

  PostProvider({required this.postRepo});

  bool isLoading = false;
  List<Http.MultipartFile> multipartFile = [];

  calculateMultipartFile() {
    multipartFile.clear();
    multipartFile = [];
    if (afterConvertImageLists.isNotEmpty) {
      for (int i = 0; i < afterConvertImageLists.length; i++) {
        multipartFile.add(Http.MultipartFile(
            'image', afterConvertImageLists[i].readAsBytes().asStream(), afterConvertImageLists[i].lengthSync(),
            filename: afterConvertImageLists[i].path.split("/").last));
      }
    }
    if (video.isNotEmpty) {
      for (int i = 0; i < video.length; i++) {
        multipartFile.add(
            Http.MultipartFile('video', video[i].readAsBytes().asStream(), video[i].lengthSync(), filename: video[i].path.split("/").last));
      }
    }
    notifyListeners();
  }

  Future<PostResponse> addPost(String postText, {bool isFromGroup = false, bool isFromPage = false, int groupPageID = 0}) async {
    isLoading = true;
    calculateMultipartFile();
    Response response;
    if (isFromGroup) {
      response = await postRepo.submitPostTOGroupBYUSINGGroupID({"description": postText}, multipartFile, groupPageID);
    } else if (isFromPage) {
      response = await postRepo.submitPostTOPageBYUSINGPageID({"description": postText}, multipartFile, groupPageID);
    } else {
      response = await postRepo.submitPost({"description": postText}, multipartFile);
    }
    isLoading = false;
    if (response.statusCode == 201 || response.statusCode == 200) {
      Fluttertoast.showToast(msg: "Posted");
      NewsFeedData n = NewsFeedData.fromJson(response.body);
      notifyListeners();
      return PostResponse(newsFeedData: n, status: true);
    } else {
      Fluttertoast.showToast(msg: "Something went wrong!");
      return PostResponse(newsFeedData: NewsFeedData(), status: false);
    }
  }

  Future<PostResponse> updatePost(String postText, int id, {bool isFromGroup = false, bool isFromPage = false, int groupPageID = 0}) async {
    isLoading = true;
    calculateMultipartFile();
    Response response;
    if (isFromGroup) {
      response = await postRepo.updatePostTOGroupBYUSINGGroupID(
          {"description": postText, "deleted_image": jsonEncode(deletedImagesIDS), "deleted_video": jsonEncode(deletedVideoIDS)},
          multipartFile,
          groupPageID,
          id);
    } else if (isFromPage) {
      response = await postRepo.updatePostTOPageBYUSINGPageID(
          {"description": postText, "deleted_image": jsonEncode(deletedImagesIDS), "deleted_video": jsonEncode(deletedVideoIDS)},
          multipartFile,
          groupPageID,
          id);
    } else {
      response = await postRepo.updatePost(
          {"description": postText, "deleted_image": jsonEncode(deletedImagesIDS), "deleted_video": jsonEncode(deletedVideoIDS)},
          multipartFile,
          id);
    }
    isLoading = false;
    if (response.statusCode == 201 || response.statusCode == 200) {
      Fluttertoast.showToast(msg: "Updated Successfully");
      NewsFeedData n = NewsFeedData.fromJson(response.body);
      notifyListeners();
      return PostResponse(newsFeedData: n, status: true);
    } else {
      Fluttertoast.showToast(msg: "Something went wrong!");
      return PostResponse(newsFeedData: NewsFeedData(), status: false);
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
    if (pickedFile!.isNotEmpty) {
      imageFile.addAll(pickedFile);
      imageFile.forEach((element) async {
        singleImage = File(element.path);
        afterConvertImageLists.add(await imageCompressed(imagePathToCompress: singleImage!));

        var sizeInBefore = singleImage!.lengthSync() / 1024;
        debugPrint("Size in Before Compress:" + sizeInBefore.toString() + "KB");
        File compressImage = await imageCompressed(imagePathToCompress: singleImage!);
        var sizeInAfter = compressImage.lengthSync() / 1024;
        debugPrint("Size in After:" + sizeInAfter.toString() + "KB");
        notifyListeners();
      });
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

  initializeImageVideo(NewsFeedData newsFeedData) {
    deletedImagesIDS.clear();
    deletedVideoIDS.clear();
    deletedImagesIDS = [];
    deletedVideoIDS = [];

    for (var element in newsFeedData.images!) {
      imageVideoLists.add(ImageVideoDetectModel(true, element.image!, '', element.id!.toString()));
    }

    for (var element in newsFeedData.videos!) {
      imageVideoLists.add(ImageVideoDetectModel(false, element.thumbnail!, element.video!, element.id!.toString()));
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
    Response response;
    if (isFromGroup) {
      response = await postRepo.reportGroupPost({"report_note": report, "report_type": "1"}, id);
    } else if (isFromPage) {
      response = await postRepo.reportPagePost({"report_note": report, "report_type": "1"}, id);
    } else {
      response = await postRepo.reportPost({"report_note": report}, id);
    }
    isLoading = false;
    if (response.statusCode == 201 || response.statusCode == 200) {
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
    Response response = await postRepo.deletePost(url);

    isLoading = false;
    if (response.statusCode == 204 || response.statusCode == 301) {
      Fluttertoast.showToast(msg: 'Post Deleted Successfully');
      notifyListeners();
      return true;
    } else {
      Fluttertoast.showToast(msg: response.statusText!);
      return false;
    }
  }

  //// for Share post
  Future<PostResponse> sharePost(String url, String description, NewsFeedData newsfeedData) async {
    isLoading = true;
    notifyListeners();
    Response response = await postRepo.sharePost(url, description);

    isLoading = false;
    if (response.statusCode == 201) {
      Fluttertoast.showToast(msg: 'Post Share Successfully');
      SharePostModel n = SharePostModel.fromJson(response.body);
      NewsFeedData newsFeedData = newsfeedData;
      newsFeedData.isShare = true;
      newsFeedData.sharePost = n;
      newsFeedData.description = description;
      newsFeedData.timestamp=DateTime.now().toString();
      notifyListeners();
      return PostResponse(newsFeedData: newsFeedData, status: true);
    } else {
      Fluttertoast.showToast(msg: response.statusText!);
      return PostResponse(newsFeedData: NewsFeedData(), status: false);
    }
  }
}
