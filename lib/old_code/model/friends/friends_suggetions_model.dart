// To parse this JSON data, do
//
//     final friendsSuggetionsModel = friendsSuggetionsModelFromJson(jsonString);

import 'dart:convert';

List<FriendsSuggetionsModel> friendsSuggetionsModelFromJson(String str) =>
    List<FriendsSuggetionsModel>.from(
        json.decode(str).map((x) => FriendsSuggetionsModel.fromJson(x)));

String friendsSuggetionsModelToJson(List<FriendsSuggetionsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FriendsSuggetionsModel {
  FriendsSuggetionsModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.profileImage,
  });

  int id;
  String firstName;
  String lastName;
  String profileImage;

  factory FriendsSuggetionsModel.fromJson(Map<String, dynamic> json) =>
      FriendsSuggetionsModel(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        profileImage: json["profile_image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "profile_image": profileImage,
      };
}
