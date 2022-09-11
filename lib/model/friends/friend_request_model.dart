// To parse this JSON data, do
//
//     final friendsRequestModel = friendsRequestModelFromJson(jsonString);

import 'dart:convert';

List<FriendsRequestModel> friendsRequestModelFromJson(String str) =>
    List<FriendsRequestModel>.from(
        json.decode(str).map((x) => FriendsRequestModel.fromJson(x)));

String friendsRequestModelToJson(List<FriendsRequestModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FriendsRequestModel {
  FriendsRequestModel({
    required this.id,
    required this.fromUser,
    required this.timestamp,
  });

  int id;
  FromUser fromUser;
  String timestamp;

  factory FriendsRequestModel.fromJson(Map<String, dynamic> json) =>
      FriendsRequestModel(
        id: json["id"],
        fromUser: FromUser.fromJson(json["from_user"]),
        timestamp: json["timestamp"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "from_user": fromUser.toJson(),
        "timestamp": timestamp,
      };
}

class FromUser {
  FromUser({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.profileImage,
  });

  int id;
  String firstName;
  String lastName;
  String email;
  String profileImage;

  factory FromUser.fromJson(Map<String, dynamic> json) => FromUser(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        profileImage: json["profile_image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "profile_image": profileImage,
      };
}
