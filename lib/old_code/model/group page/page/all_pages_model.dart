// To parse this JSON data, do
//
//     final allPagesModel = allPagesModelFromJson(jsonString);

import 'dart:convert';

List<AllPagesModel> allPagesModelFromJson(String str) =>
    List<AllPagesModel>.from(
        json.decode(str).map((x) => AllPagesModel.fromJson(x)));

String allPagesModelToJson(List<AllPagesModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllPagesModel {
  AllPagesModel({
    required this.id,
    required this.name,
    required this.category,
    required this.coverPhoto,
    required this.avatar,
    required this.followers,
  });

  int id;
  String name;
  String category;
  String coverPhoto;
  String avatar;
  int followers;

  factory AllPagesModel.fromJson(Map<String, dynamic> json) => AllPagesModel(
        id: json["id"],
        name: json["name"],
        category: json["category"],
        coverPhoto: json["cover_photo"],
        avatar: json["avatar"],
        followers: json["followers"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "category": category,
        "cover_photo": coverPhoto,
        "avatar": avatar,
        "followers": followers,
      };
}
