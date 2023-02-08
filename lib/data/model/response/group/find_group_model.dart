// To parse this JSON data, do
//
//     final findGroupModel = findGroupModelFromJson(jsonString);

import 'dart:convert';

FindGroupModel findGroupModelFromJson(String str) => FindGroupModel.fromJson(json.decode(str));

String findGroupModelToJson(FindGroupModel data) => json.encode(data.toJson());

class FindGroupModel {
  FindGroupModel({
    required this.id,
    required this.name,
    required this.coverPhoto,
    required this.totalMember,
    required this.visitGroupUrl,
    required this.copyLinkUrl,
  });

  int id;
  String name;
  String coverPhoto;
  int totalMember;
  String visitGroupUrl;
  String copyLinkUrl;

  factory FindGroupModel.fromJson(Map<String, dynamic> json) => FindGroupModel(
    id: json["id"],
    name: json["name"],
    coverPhoto: json["cover_photo"],
    totalMember: json["total_member"],
    visitGroupUrl: json["visit_group_url"],
    copyLinkUrl: json["copy_link_url"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "cover_photo": coverPhoto,
    "total_member": totalMember,
    "visit_group_url": visitGroupUrl,
    "copy_link_url": copyLinkUrl,
  };
}
