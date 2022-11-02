class OnwerAnimalModel {
  OnwerAnimalModel({
    this.id,
    this.animalName,
    this.givenName,
    this.species,
    this.gender,
    this.age,
    this.genus,
    this.image,
    this.animalOwner,
    this.ownerProfilePicture,
  });

  OnwerAnimalModel.fromJson(dynamic json) {
    id = json['id'];
    animalName = json['animal_name'];
    givenName = json['given_name'];
    species = json['species'];
    gender = json['gender'];
    age = json['age'];
    genus = json['genus'];
    image = json['image'];
    animalOwner = json['animal_owner'];
    ownerProfilePicture = json['owner_profile_picture'];
  }

  num? id;
  String? animalName;
  String? givenName;
  String? species;
  String? gender;
  String? age;
  String? genus;
  String? image;
  String? animalOwner;
  String? ownerProfilePicture;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['animal_name'] = animalName;
    map['given_name'] = givenName;
    map['species'] = species;
    map['gender'] = gender;
    map['age'] = age;
    map['genus'] = genus;
    map['image'] = image;
    map['animal_owner'] = animalOwner;
    map['owner_profile_picture'] = ownerProfilePicture;
    return map;
  }
}
