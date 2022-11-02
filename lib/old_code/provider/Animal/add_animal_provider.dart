import 'dart:io';


import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../const/url.dart';
import '../../model/model.dart';
import '../../screens/screens.dart';

class AddAnimalProvider extends ChangeNotifier {
  File? image;
  final _picker = ImagePicker();
  bool spinner = false;
  String? token;
  int? animalID;
  bool animalDeleted = false;

  String message = "";
  bool success = false;
  List<String> gender = ["Male", "Female"];
  String drondownValue = "Male";

  Future pickImage() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      image = File(pickedFile.path);
      notifyListeners();
    }
  }

  Future<void> uploadImage(
      String animalName, givenName, species, gender, age, genus) async {
    spinner = true;
    notifyListeners();

    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? '');
    var uri = Uri.parse("$baseUrl/animal/"), headers = 'token $token';

    try {
      var request = http.MultipartRequest(
        'POST',
        uri,
      );
      request.headers["Authorization"] = headers;
      request.headers["Content-Type"] = "multipart/form-data";
      request.fields['animal_name'] = animalName;
      request.fields['given_name'] = givenName;
      request.fields['species'] = species;
      request.fields['gender'] = gender;
      request.fields['age'] = age;
      request.fields['genus'] = genus;

      if (image != null) {
        request.files.add(http.MultipartFile(
            'image',
            File(image!.path).readAsBytes().asStream(),
            File(image!.path).lengthSync(),
            filename: image!.path.split("/").last));
      }

      var response = await request.send();
      if (response.statusCode == 201) {
        success = true;
        spinner = false;
        notifyListeners();
        Fluttertoast.showToast(msg: "Added successfully");
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
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? '');
    var uri = Uri.parse("$baseUrl/animal/$animalID/"),
        headers = {'Authorization': 'token $token'};
    var response = await http.delete(uri, headers: headers);

    if (response.statusCode == 204) {
      animalDeleted = true;
      notifyListeners();
      Fluttertoast.showToast(msg: "Deleted");
      animalDeleted = false;
      Get.to(() => const YourAnimalScreen());
      notifyListeners();
    } else {
      Fluttertoast.showToast(msg: "SomeThing went worng!");
    }
  }

  SingleAnimalDetails userprofileData = SingleAnimalDetails();

  void editanimal(
    String animalName,
    givenName,
    species,
    gender,
    age,
    genus
  ) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString('token') ?? '');
    var uri = Uri.parse("$baseUrl/animal/$animalID/"),
        headers = {'Authorization': 'token $token'};
    Map<String, String> requestBody = <String, String>
    {
      "animal_name": animalName,
      "given_name": givenName,
      "species": species,
      "gender": gender,
      "age": age,
      "genus": genus,
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
