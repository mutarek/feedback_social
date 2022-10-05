// To parse this JSON data, do
//
//     final onwerAnimalModel = onwerAnimalModelFromJson(jsonString);

import 'dart:convert';

List<OnwerAnimalModel> onwerAnimalModelFromJson(String str) =>
    List<OnwerAnimalModel>.from(
        json.decode(str).map((x) => OnwerAnimalModel.fromJson(x)));

String onwerAnimalModelToJson(List<OnwerAnimalModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OnwerAnimalModel {
  OnwerAnimalModel({
    required this.id,
    required this.animalName,
    required this.givenName,
    required this.species,
    required this.gender,
    required this.age,
    required this.genus,
    required this.animalOwner,
    required this.ownerProfilePicture,
    required this.image,
  });

  int id;
  String animalName;
  String givenName;
  String species;
  String gender;
  String age;
  String genus;
  String animalOwner;
  String ownerProfilePicture;
  String image;

  factory OnwerAnimalModel.fromJson(Map<String, dynamic> json) =>
      OnwerAnimalModel(
        id: json["id"],
        animalName: json["animal_name"],
        givenName: json["given_name"],
        species: json["species"],
        gender: json["gender"],
        age: json["age"],
        genus: json["genus"],
        animalOwner: json["animal_owner"],
        ownerProfilePicture: json["owner_profile_picture"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "animal_name": animalName,
        "given_name": givenName,
        "species": species,
        "gender": gender,
        "age": age,
        "genus": genus,
        "animal_owner": animalOwner,
        "owner_profile_picture": ownerProfilePicture,
        "image": image,
      };
}
