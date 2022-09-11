import 'dart:io';

import 'package:als_frontend/const/url.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class UpdatePageProfileImageProvider extends ChangeNotifier {
  String imageUrl = "";
  File? image;
  int? id;
  final _picker = ImagePicker();
  bool spinner = false;
  bool success = false;
  String? token;
  Future pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      notifyListeners();
    }
  }

  Future<void> uploadImage() async {
    spinner = true;
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? '');
    id = (prefs.getInt('id') ?? '') as int;
    var uri = Uri.parse("$baseUrl/page/$id/"),
        headers = 'token $token';

    try {
      var request = http.MultipartRequest(
        'PATCH',
        uri,
      );
      request.headers["Authorization"] = headers;
      request.headers["Content-Type"] = "multipart/form-data";

      if (image != null) {
        request.files.add(http.MultipartFile(
            'avatar',
            File(image!.path).readAsBytes().asStream(),
            File(image!.path).lengthSync(),
            filename: image!.path.split("/").last));
      }

      var response = await request.send();
      if (response.statusCode == 200) {
        success = true;
        spinner = false;
        notifyListeners();
        Fluttertoast.showToast(msg: "Uploaded successfully");
      } else {
        spinner = false;
        notifyListeners();
        Fluttertoast.showToast(msg: "Something went wrong!");
      }
    } catch (e) {
      print("Add animal provider: $e");
    }
  }
}
