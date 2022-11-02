// To parse this JSON data, do
//
//     final authorPageModel = authorPageModelFromJson(jsonString);

import 'dart:convert';

List<AuthorPageModel> authorPageModelFromJson(String str) =>
    List<AuthorPageModel>.from(json.decode(str).map((x) => AuthorPageModel.fromJson(x)));

String authorPageModelToJson(List<AuthorPageModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AuthorPageModel {
  AuthorPageModel({
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

  factory AuthorPageModel.fromJson(Map<String, dynamic> json) => AuthorPageModel(
        id: json["id"],
        name: json["name"],
        category: json["category"].toString(),
        coverPhoto: json["cover_photo"] ?? "",
        avatar: json["avatar"],
        followers: json["followers"] ?? json["total_like"],
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
