// To parse this JSON data, do
//
//     final authorGroupModel = authorGroupModelFromJson(jsonString);

import 'dart:convert';

List<AuthorGroupModel> authorGroupModelFromJson(String str) =>
    List<AuthorGroupModel>.from(
        json.decode(str).map((x) => AuthorGroupModel.fromJson(x)));

String authorGroupModelToJson(List<AuthorGroupModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AuthorGroupModel {
  AuthorGroupModel({
    required this.id,
    required this.name,
    required this.category,
    required this.coverPhoto,
    required this.isPrivate,
    required this.totalMember,
  });

  int id;
  String name;
  String category;
  String coverPhoto;
  bool isPrivate;
  int totalMember;

  factory AuthorGroupModel.fromJson(Map<String, dynamic> json) =>
      AuthorGroupModel(
        id: json["id"],
        name: json["name"],
        category: json["category"],
        coverPhoto: json["cover_photo"],
        isPrivate: json["is_private"],
        totalMember: json["total_member"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "category": category,
        "cover_photo": coverPhoto,
        "is_private": isPrivate,
        "total_member": totalMember,
      };
}
