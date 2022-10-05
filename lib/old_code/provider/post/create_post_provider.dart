// ignore_for_file: unnecessary_null_comparison

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_native_image/flutter_native_image.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../const/url.dart';

class CreatePostProvider extends ChangeNotifier {
  List<XFile> image = [];
  File? video;
  final _picker = ImagePicker();
  bool spinner = false;
  String? token;
  String message = "";
  bool success = false;
  int? postId;
  int? editPostId;
  String description = "";
  bool postDeleted = false;
  //
  // Future pickImage() async {
  //   var pickedFile = await _picker.pickMultiImage();
  //   if (pickedFile != null) {
  //     image.addAll(pickedFile);
  //     notifyListeners();
  //   }
  // }

  List<XFile> imageFile = [];
  List<File> afterConvertImageLists = [];
  File? singleImage;

  void pickImage() async {
    imageFile = [];
    afterConvertImageLists = [];
    var pickedFile = await _picker.pickMultiImage();
    if (pickedFile!.isNotEmpty) {
      imageFile.addAll(pickedFile);
      image.addAll(pickedFile);
      imageFile.forEach((element) async {
        singleImage = File(element.path);
        afterConvertImageLists.add(await customCompressed(imagePathToCompress: singleImage!));

        var sizeInBefore = singleImage!.lengthSync() / 1024;
        debugPrint("Size in Before Compress:" + sizeInBefore.toString() + "KB");
        File compressImage = await customCompressed(imagePathToCompress: singleImage!);
        var sizeInAfter = compressImage.lengthSync() / 1024;
        debugPrint("Size in After:" + sizeInAfter.toString() + "KB");
      });
    }

    notifyListeners();
  }

  Future<File> customCompressed({required File imagePathToCompress, quality = 100, percentage = 30}) async {
    var path = await FlutterNativeImage.compressImage(imagePathToCompress.absolute.path, quality: quality, percentage: percentage);
    return path;
  }

  Future pickVideo() async {
    final pickedFile = await _picker.pickVideo(source: ImageSource.gallery);
    if (pickedFile != null) {
      video = File(pickedFile.path);
      notifyListeners();
    }
  }

  Future createPost(String description) async {
    spinner = true;
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? '');

    var uri = Uri.parse(postCreate), headers = 'token $token';
    try {
      var request = http.MultipartRequest(
        'POST',
        uri,
      );
      request.headers["Authorization"] = headers;
      request.headers["Content-Type"] = "multipart/form-data";
      request.fields['description'] = description;

      if (afterConvertImageLists.isNotEmpty) {
        for (int i = 0; i < afterConvertImageLists.length; i++) {
          request.files.add(http.MultipartFile('image', File(afterConvertImageLists[i].path).readAsBytes().asStream(), File(afterConvertImageLists[i].path).lengthSync(),
              filename: afterConvertImageLists[i].path.split("/").last));
        }
      }

      if (video != null) {
        request.files.add(http.MultipartFile('video', File(video!.path).readAsBytes().asStream(), File(video!.path).lengthSync(),
            filename: video!.path.split("/").last));
      }

      var response = await request.send();
      debugPrint(image.length.toString());
      if (response.statusCode == 201) {
        success = true;
        spinner = false;
        notifyListeners();
        Fluttertoast.showToast(msg: "Posted");
      } else {
        spinner = false;
        notifyListeners();
        Fluttertoast.showToast(msg: "Something went wrong!");
      }
    } catch (e) {
      print("Add animal provider: $e");
    }
  }

  Future delete() async {
    print("delete from create post provider");
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? '');
    var uri = Uri.parse("$baseUrl/posts/newsfeeds/$postId/delete"), headers = {'Authorization': 'token $token'};
    var response = await http.delete(uri, headers: headers);
    print(postId);
    print(response.statusCode);
    if (response.statusCode == 204) {
      postDeleted = true;
      notifyListeners();
      Fluttertoast.showToast(msg: "Deleted");
      postDeleted = false;
      notifyListeners();
    } else {
      Fluttertoast.showToast(msg: "SomeThing went worng!");
    }
  }

  void editPost(String description) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? '');
    var uri = Uri.parse("$baseUrl/posts/$editPostId/"), headers = {'Authorization': 'token $token'};
    Map<String, String> requestBody = <String, String>{
      'description': description,
    };
    var response = await http.patch(uri, headers: headers, body: requestBody);
    print(postId);
    print(response.statusCode);
    notifyListeners();
    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: "Edited successfully");
    } else {
      Fluttertoast.showToast(msg: "Something went wrong");
    }
  }
}
