import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class OtherProvider with ChangeNotifier {
  File? selectedFile;
  bool inProcess = false;

  clearImage() {
    selectedFile = null;

    notifyListeners();
  }

  getImage(ImageSource source, double ratioX, double ratioY, int widget, int height) async {
    // inProcess = true;

    XFile? image = await ImagePicker().pickImage(source: source);
    if (image != null) {
      CroppedFile? cropped = await ImageCropper().cropImage(
        sourcePath: image.path,
        aspectRatio: CropAspectRatio(ratioX: ratioX, ratioY: ratioY),
        compressQuality: 100,
        maxWidth: widget + 200,
        maxHeight: height + 200,
        compressFormat: ImageCompressFormat.jpg,
        uiSettings: [
          AndroidUiSettings(
            toolbarColor: Colors.teal,
            toolbarTitle: "Feedback Image Cropper",
            statusBarColor: Colors.teal.shade900,
            backgroundColor: Colors.white,
          ),
          IOSUiSettings(title: 'Cropper'),
        ],
      );
      if (cropped != null) {
        selectedFile = File(cropped.path);
      } else {
        selectedFile = File(image.path);
      }
    }
    inProcess = false;
    notifyListeners();
  }

  getImageWithOutCroup(ImageSource source) async {
    selectedFile = null;
    XFile? image = await ImagePicker().pickImage(source: source);
    if (image != null) {
      selectedFile = File(image.path);
    }
    notifyListeners();
  }
}
