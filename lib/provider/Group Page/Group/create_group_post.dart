// ignore_for_file: unnecessary_null_comparison

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../const/url.dart';

class CreateGroupPost extends ChangeNotifier {
  List<XFile> image = [];
  File? video;
  final _picker = ImagePicker();
  bool spinner = false;
  String? token;
  String message = "";
  bool success = false;
  int? groupId;
  int? postId;
  String description = "";
  bool postDeleted = false;

  Future pickImage() async {
    var pickedFile = await _picker.pickMultiImage();
    if (pickedFile != null) {
      image.addAll(pickedFile);
      notifyListeners();
    }
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

    var uri = Uri.parse("$baseUrl/posts/group/$groupId/"),
        headers = 'token $token';
    try {
      var request = http.MultipartRequest(
        'POST',
        uri,
      );
      request.headers["Authorization"] = headers;
      request.headers["Content-Type"] = "multipart/form-data";
      request.fields['description'] = description;

      if (image != null) {
        for (int i = 0; i < image.length; i++) {
          request.files.add(http.MultipartFile(
              'image',
              File(image[i].path).readAsBytes().asStream(),
              File(image[i].path).lengthSync(),
              filename: image[i].path.split("/").last));
        }
      }

      if (video != null) {
        request.files.add(http.MultipartFile(
            'video',
            File(video!.path).readAsBytes().asStream(),
            File(video!.path).lengthSync(),
            filename: video!.path.split("/").last));
      }

      var response = await request.send();
      print(response.statusCode);
      print(groupId);
      if (response.statusCode == 201) {
        success = true;
        spinner = false;
        notifyListeners();
        Fluttertoast.showToast(msg: "Posted");
      } else {
        success = false;
        spinner = false;
        notifyListeners();
        Fluttertoast.showToast(msg: "Something went wrong");
      }
    } catch (e) {
      print("Add animal provider: $e");
    }
  }

  Future delete() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? '');
    var uri = Uri.parse("$baseUrl/posts/group/$groupId/$postId/"),
        headers = {'Authorization': 'token $token'};
    var response = await http.delete(uri, headers: headers);
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
    var uri = Uri.parse("$baseUrl/posts/group/$groupId/$postId/"),
        headers = {'Authorization': 'token $token'};
    Map<String, String> requestBody = <String, String>{
      'description': description,
    };
    var response = await http.patch(uri, headers: headers, body: requestBody);
    notifyListeners();
    if (response.statusCode == 200) {
      Fluttertoast.showToast(msg: "Edited successfully");
    } else {
      Fluttertoast.showToast(msg: "Something went wrong");
    }
  }
}
