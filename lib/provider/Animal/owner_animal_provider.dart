import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../model/model.dart';
import '../../service/services.dart';

class OwnerAnimalProvider extends ChangeNotifier {
  int? animalIndex;
  String code = "";
  String searchCode = "";
  List<OnwerAnimalModel>? animals = [];
  var isLoaded = false;
  int index = 0;
  int singleImageIndex = 0;
  String postCaption = "";
  List<String> postImages = [];
  Future<void> getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    code = (prefs.getString('code') ?? '');
    animals = (await OwnerAnimalService().getAnimals())!;
    notifyListeners();
    if (animals != null) {
      isLoaded = true;
      notifyListeners();
    }
  }
}
