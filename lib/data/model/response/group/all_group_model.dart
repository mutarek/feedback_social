// To parse this JSON data, do
//
//     final allGroupModel = allGroupModelFromJson(jsonString);

import 'dart:convert';

List<AllGroupModel> allGroupModelFromJson(String str) => List<AllGroupModel>.from(json.decode(str).map((x) => AllGroupModel.fromJson(x)));

String allGroupModelToJson(List<AllGroupModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AllGroupModel {
  AllGroupModel({
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

  factory AllGroupModel.fromJson(Map<String, dynamic> json) => AllGroupModel(
        id: json["id"],
        name: json["name"],
        category: json["category"]??"",
        coverPhoto: json["cover_photo"] ?? json["avatar"],
        isPrivate: json["is_private"]??false,
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
