import 'dart:io';

import 'package:als_frontend/data/model/response/news_feed_model.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class OtherProvider with ChangeNotifier {
  File? selectedFile;
  File? pageProfileFile;
  File? pageCoverFile;
  bool inProcess = false;

  clearImage() {
    selectedFile = null;
    notifyListeners();
  }

  setCover() {
    pageCoverFile = selectedFile;
    notifyListeners();
  }

  setProfile() {
    pageProfileFile = selectedFile;
    notifyListeners();
  }

  clearCoverProfile() {
    pageProfileFile = null;
    pageCoverFile = null;
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

  ImagesVideoModel imageVideoLists = ImagesVideoModel();

  changeImageVideoLists(List<ImagesData> imageData, List<VideosData> videoData) {
    imageVideoLists = ImagesVideoModel();
    imageVideoLists = ImagesVideoModel(imagesData: imageData, videosData: videoData);
    notifyListeners();
  }

  addLikeImageVideo(int reactStatusID, int valueIndex, bool isVideo) async {
    if (!isVideo) {
      if (reactStatusID == 1 || reactStatusID == 2 || reactStatusID == 3) {
        if (imageVideoLists.imagesData![valueIndex].reaction == -1) {
          imageVideoLists.imagesData![valueIndex].totalReaction = imageVideoLists.imagesData![valueIndex].totalReaction! + 1;
        }

        if (reactStatusID == 1) {
          imageVideoLists.imagesData![valueIndex].totalLiked = imageVideoLists.imagesData![valueIndex].totalLiked! + 1;
          if (imageVideoLists.imagesData![valueIndex].reaction! == 2) {
            imageVideoLists.imagesData![valueIndex].totalLoved = imageVideoLists.imagesData![valueIndex].totalLoved! - 1;
          }
          if (imageVideoLists.imagesData![valueIndex].reaction! == 3) {
            imageVideoLists.imagesData![valueIndex].totalSad = imageVideoLists.imagesData![valueIndex].totalSad! - 1;
          }
        } else if (reactStatusID == 2) {
          imageVideoLists.imagesData![valueIndex].totalLoved = imageVideoLists.imagesData![valueIndex].totalLoved! + 1;
          if (imageVideoLists.imagesData![valueIndex].reaction! == 1) {
            imageVideoLists.imagesData![valueIndex].totalLiked = imageVideoLists.imagesData![valueIndex].totalLiked! - 1;
          }
          if (imageVideoLists.imagesData![valueIndex].reaction! == 3) {
            imageVideoLists.imagesData![valueIndex].totalSad = imageVideoLists.imagesData![valueIndex].totalSad! - 1;
          }
        } else {
          imageVideoLists.imagesData![valueIndex].totalSad = imageVideoLists.imagesData![valueIndex].totalSad! + 1;
          if (imageVideoLists.imagesData![valueIndex].reaction! == 1) {
            imageVideoLists.imagesData![valueIndex].totalLiked = imageVideoLists.imagesData![valueIndex].totalLiked! - 1;
          }
          if (imageVideoLists.imagesData![valueIndex].reaction! == 2) {
            imageVideoLists.imagesData![valueIndex].totalLoved = imageVideoLists.imagesData![valueIndex].totalLoved! - 1;
          }
        }

        imageVideoLists.imagesData![valueIndex].reaction = reactStatusID;
      } else {
        imageVideoLists.imagesData![valueIndex].totalReaction = imageVideoLists.imagesData![valueIndex].totalReaction! - 1;
        imageVideoLists.imagesData![valueIndex].reaction = reactStatusID;
      }
    } else {}

    notifyListeners();
  }

  changeImageVideoLikeStatus(int valueIndex) async {
    if (imageVideoLists.imagesData![valueIndex].reaction != -1) {
      imageVideoLists.imagesData![valueIndex].totalReaction = imageVideoLists.imagesData![valueIndex].totalReaction! - 1;
      if (imageVideoLists.imagesData![valueIndex].reaction == 1) {
        imageVideoLists.imagesData![valueIndex].totalLiked = imageVideoLists.imagesData![valueIndex].totalLiked! - 1;
      } else if (imageVideoLists.imagesData![valueIndex].reaction == 2) {
        imageVideoLists.imagesData![valueIndex].totalLoved = imageVideoLists.imagesData![valueIndex].totalLoved! - 1;
      } else {
        imageVideoLists.imagesData![valueIndex].totalSad = imageVideoLists.imagesData![valueIndex].totalSad! - 1;
      }
      imageVideoLists.imagesData![valueIndex].reaction = -1;
    }
    notifyListeners();
  }
}
