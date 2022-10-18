// To parse required this JSON data, do
//
//     final friendListModel = friendListModelFromJson(jsonString);

import 'dart:convert';

List<FriendListModel> friendListModelFromJson(String str) =>
    List<FriendListModel>.from(json.decode(str).map((x) => FriendListModel.fromJson(x)));

String friendListModelToJson(List<FriendListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FriendListModel {
  FriendListModel({
    required this.id,
    required this.fullName,
    required this.profileImage,
  });

  int id;
  String fullName;
  String profileImage;

  factory FriendListModel.fromJson(Map<String, dynamic> json) => FriendListModel(
        id: json["id"],
        fullName: json["full_name"],
        profileImage: json["profile_image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "full_name": fullName,
        "profile_image": profileImage,
      };
}
