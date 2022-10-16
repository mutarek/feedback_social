import 'dart:io';

import 'package:als_frontend/data/model/response/owner_animal_model.dart';
import 'package:als_frontend/data/repository/animal_repo.dart';
import 'package:als_frontend/helper/image_compressure.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_connect/http/src/response/response.dart';
import 'package:image_picker/image_picker.dart';
import 'package:http/http.dart' as Http;

class AnimalProvider with ChangeNotifier {
  final AnimalRepo animalRepo;

  AnimalProvider({required this.animalRepo});

  bool isLoading = false;
  bool hasNextData = false;
  bool isBottomLoading = false;
  int selectPage = 1;

  //TODO: for Owner Animal Lists Sections

  List<OnwerAnimalModel> animals = [];

  updatePageNo() {
    selectPage++;
    initializeOwnerAnimalList((bool status) {}, page: selectPage);
    notifyListeners();
  }

  initializeOwnerAnimalList(Function callBackFunction, {int page = 1, bool isFirstTime = true}) async {
    if (page == 1) {
      selectPage = 1;
      animals.clear();
      animals = [];
      isLoading = true;
      isBottomLoading = false;
      hasNextData = false;
      if (!isFirstTime) {
        notifyListeners();
      }
    } else {
      isBottomLoading = true;
      notifyListeners();
    }

    Response response = await animalRepo.getAnimals(page);
    isLoading = false;
    isBottomLoading = false;
    callBackFunction(true);

    if (response.statusCode == 200 && response.body.isNotEmpty) {
      //hasNextData = response.body['next'] != null ? true : false;
      response.body.forEach((element) {
        OnwerAnimalModel ownerAnimalModel = OnwerAnimalModel.fromJson(element);

        animals.add(ownerAnimalModel);
      });
    } else {
      //Fluttertoast.showToast(msg: response.statusText!);
    }
    notifyListeners();
  }

  List<String> gender = ["Male", "Female", "Other"];
  String selectGender = "Male";

  changeGenderStatus(String value) {
    selectGender = value;
    notifyListeners();
  }

  //TODO: for Take Photo

  File? image;
  int? id;
  final _picker = ImagePicker();

  Future pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = await imageCompressed(imagePathToCompress: File(pickedFile.path), percentage: 50);
      notifyListeners();
    }
  }

  clearImage() {
    image = null;
    notifyListeners();
  }

  //TODO: for Add Animal
  addAnimal(String animalName, String givenName, String species, String age, String genus, Function callBackFunction) async {
    isLoading = true;
    List<Http.MultipartFile> multipartFile = [];

    if (image != null) {
      multipartFile
          .add(Http.MultipartFile('image', image!.readAsBytes().asStream(), image!.lengthSync(), filename: image!.path.split("/").last));
    }

    notifyListeners();
    Response response = await animalRepo.addedAnimal(
        {"animal_name": animalName, "given_name": givenName, "species": species, "gender": selectGender, "age": age, "genus": genus},
        multipartFile);
    isLoading = false;
    if (response.statusCode == 201) {
      OnwerAnimalModel ownerAnimalModel = OnwerAnimalModel.fromJson(response.body);
      animals.add(ownerAnimalModel);
      callBackFunction(true);
      Fluttertoast.showToast(msg: "Posted");
    } else {
      callBackFunction(false);
      Fluttertoast.showToast(msg: "Something went wrong!");
    }
    notifyListeners();
  }

  //TODO: delete animal
  deleteAnimal(int animalID, int index,Function callback) async {
    isLoading = true;
    notifyListeners();
    Response response = await animalRepo.deleteAnimal(animalID);
    isLoading = false;
    if (response.statusCode == 204) {
      animals.removeAt(index);
      Fluttertoast.showToast(msg: "Animal Deleted Successfully");
      callback(true);
    } else {
      Fluttertoast.showToast(msg: "Animal Deleted Wrong!");
      callback(false);
    }
    notifyListeners();
  }
}
