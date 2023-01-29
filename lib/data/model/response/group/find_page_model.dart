// To parse this JSON data, do
//
//     final findPageModel = findPageModelFromJson(jsonString);

import 'dart:convert';

FindPageModel findPageModelFromJson(String str) => FindPageModel.fromJson(json.decode(str));

String findPageModelToJson(FindPageModel data) => json.encode(data.toJson());

class FindPageModel {
  FindPageModel({
    required this.name,
    required this.avatar,
    required this.likedUrl,
  });

  String name;
  String avatar;
  String likedUrl;

  factory FindPageModel.fromJson(Map<String, dynamic> json) => FindPageModel(
    name: json["name"],
    avatar: json["avatar"],
    likedUrl: json["liked_url"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "avatar": avatar,
    "liked_url": likedUrl,
  };
}
