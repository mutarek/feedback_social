// To parse this JSON data, do
//
//     final singleAnimalDetails = singleAnimalDetailsFromJson(jsonString);

import 'dart:convert';

SingleAnimalDetails singleAnimalDetailsFromJson(String str) =>
    SingleAnimalDetails.fromJson(json.decode(str));

String singleAnimalDetailsToJson(SingleAnimalDetails data) =>
    json.encode(data.toJson());

class SingleAnimalDetails {
  SingleAnimalDetails({
    this.id,
    this.owner,
    this.animalName,
    this.givenName,
    this.species,
    this.gender,
    this.age,
    this.genus,
    this.animalOwner,
    this.ownerProfilePicture,
    this.image,
  });

  int? id;
  int? owner;
  String? animalName;
  String? givenName;
  String? species;
  String? gender;
  String? age;
  String? genus;
  String? animalOwner;
  String? ownerProfilePicture;
  String? image;

  factory SingleAnimalDetails.fromJson(Map<String, dynamic> json) =>
      SingleAnimalDetails(
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
