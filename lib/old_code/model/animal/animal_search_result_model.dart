// To parse this JSON data, do
//
//     final animalSearchResultModel = animalSearchResultModelFromJson(jsonString);

import 'dart:convert';

List<AnimalSearchResultModel> animalSearchResultModelFromJson(String str) =>
    List<AnimalSearchResultModel>.from(
        json.decode(str).map((x) => AnimalSearchResultModel.fromJson(x)));

String animalSearchResultModelToJson(List<AnimalSearchResultModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AnimalSearchResultModel {
  AnimalSearchResultModel({
    required this.id,
    required this.owner,
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
  int owner;
  String animalName;
  String givenName;
  String species;
  String gender;
  String age;
  String genus;
  String animalOwner;
  String ownerProfilePicture;
  String image;

  factory AnimalSearchResultModel.fromJson(Map<String, dynamic> json) =>
      AnimalSearchResultModel(
        id: json["id"],
        owner: json["owner"],
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
        "owner": owner,
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
