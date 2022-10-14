import 'dart:io';

import 'package:als_frontend/data/repository/post_repo.dart';
import 'package:als_frontend/data/model/response/news_feed_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:http/http.dart' as Http;
import 'package:image_picker/image_picker.dart';

class PostProvider with ChangeNotifier {
  final PostRepo postRepo;

  PostProvider({required this.postRepo});

  bool isLoading = false;

  addPost(String postText, Function callBackFunction) async {
    isLoading = true;
    List<Http.MultipartFile> multipartFile = [];

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
    Response response = await postRepo.submitPost({"description": postText}, multipartFile);
    isLoading = false;
    if (response.statusCode == 201) {
      callBackFunction(true, NewsFeedData.fromJson(response.body),1);
      Fluttertoast.showToast(msg: "Posted");
    } else {
      callBackFunction(false, NewsFeedData(),0);
      Fluttertoast.showToast(msg: "Something went wrong!");
    }
    notifyListeners();
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
        afterConvertImageLists.add(await customCompressed(imagePathToCompress: singleImage!));

        var sizeInBefore = singleImage!.lengthSync() / 1024;
        debugPrint("Size in Before Compress:" + sizeInBefore.toString() + "KB");
        File compressImage = await customCompressed(imagePathToCompress: singleImage!);
        var sizeInAfter = compressImage.lengthSync() / 1024;
        debugPrint("Size in After:" + sizeInAfter.toString() + "KB");
        notifyListeners();
      });
    }
  }

  Future<File> customCompressed({required File imagePathToCompress, quality = 100, percentage = 30}) async {
    var path = await FlutterNativeImage.compressImage(imagePathToCompress.absolute.path, quality: quality, percentage: percentage);
    return path;
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
}
