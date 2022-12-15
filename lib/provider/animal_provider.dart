import 'dart:io';

import 'package:als_frontend/data/model/response/Search_animal_model.dart';
import 'package:als_frontend/data/model/response/base/api_response.dart';
import 'package:als_frontend/data/model/response/owner_animal_model.dart';
import 'package:als_frontend/data/repository/animal_repo.dart';
import 'package:als_frontend/helper/image_compressure.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';

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

    ApiResponse apiResponse = await animalRepo.getAnimals(page);
    isLoading = false;
    isBottomLoading = false;
    callBackFunction(true);

    if (apiResponse.response.statusCode == 200 && apiResponse.response.data.isNotEmpty) {
      apiResponse.response.data.forEach((element) {
        OnwerAnimalModel ownerAnimalModel = OnwerAnimalModel.fromJson(element);
        animals.add(ownerAnimalModel);
      });
    } else {
      Fluttertoast.showToast(msg: apiResponse.response.toString());
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
      image = await imageCompressed(imagePathToCompress: File(pickedFile.path));
      notifyListeners();
    }
  }

  clearImage() {
    image = null;
    notifyListeners();
  }
  FormData formData = FormData();
  //TODO: for Add Animal
  addAnimal(String animalName, String givenName, String species, String age, String genus, Function callBackFunction) async {
    isLoading = true;

    formData = FormData();
    if (image != null) {
      formData.files.add(
          MapEntry('image', MultipartFile(image!.readAsBytes().asStream(), image!.lengthSync(), filename: image!.path.split("/").last)));
    }
    formData.fields.addAll([
      MapEntry('animal_name', animalName),
      MapEntry('given_name', givenName),
      MapEntry('species', species),
      MapEntry('gender', selectGender),
      MapEntry('age', age),
      MapEntry('genus', genus)
    ]);
    notifyListeners();

    ApiResponse response = await animalRepo.addedAnimal(formData);
    isLoading = false;
    if (response.response.statusCode == 201) {
      OnwerAnimalModel ownerAnimalModel = OnwerAnimalModel.fromJson(response.response.data);
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
  deleteAnimal(int animalID, int index, Function callback) async {
    isLoading = true;
    notifyListeners();
    ApiResponse response = await animalRepo.deleteAnimal(animalID);
    isLoading = false;
    if (response.response.statusCode == 204) {
      animals.removeAt(index);
      Fluttertoast.showToast(msg: "Animal Deleted Successfully");
      callback(true);
    } else {
      Fluttertoast.showToast(msg: "Animal Deleted Wrong!");
      callback(false);
    }
    notifyListeners();
  }

  //TODO: for Update Animal
  updateAnimal(
      String animalName, String givenName, String species, String age, String genus, Function callBackFunction, int id, int index) async {
    isLoading = true;
    formData = FormData();

    if (image != null) {
      formData.files.add(
          MapEntry('image', MultipartFile(image!.readAsBytes().asStream(), image!.lengthSync(), filename: image!.path.split("/").last)));
    }

    notifyListeners();
    ApiResponse response = await animalRepo.updateAnimal(formData,id);
    isLoading = false;
    if (response.response.statusCode == 200) {
      OnwerAnimalModel ownerAnimalModel = OnwerAnimalModel.fromJson(response.response.data);
      animals.removeAt(index);
      animals.add(ownerAnimalModel);
      callBackFunction(true);
      Fluttertoast.showToast(msg: "Updated Successfully");
    } else {
      callBackFunction(false);
      Fluttertoast.showToast(msg: "Something went wrong!");
    }
    notifyListeners();
  }

  //TODO: for Update Animal
  List<SearchAnimalModel> searchAnimalLists = [];
  bool isLoadingSearch = false;

  searchAnimal(String code, {bool isFirstTime = true}) async {
    isLoadingSearch = true;
    searchAnimalLists.clear();
    searchAnimalLists = [];
    if (!isFirstTime) notifyListeners();
    ApiResponse response = await animalRepo.searchAnimal(code);
    isLoadingSearch = false;
    if (response.response.statusCode == 200) {
      response.response.data.forEach((element) {
        SearchAnimalModel animal = SearchAnimalModel.fromJson(element);
        searchAnimalLists.add(animal);
      });
    } else {
      Fluttertoast.showToast(msg: "Something went wrong!");
    }
    notifyListeners();
  }
}