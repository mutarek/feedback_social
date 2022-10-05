// To parse this JSON data, do
//
//     final pageImagesModel = pageImagesModelFromJson(jsonString);

import 'dart:convert';

List<PageImagesModel> pageImagesModelFromJson(String str) =>
    List<PageImagesModel>.from(
        json.decode(str).map((x) => PageImagesModel.fromJson(x)));

String pageImagesModelToJson(List<PageImagesModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PageImagesModel {
  PageImagesModel({
    required this.id,
    required this.image,
  });

  int id;
  String image;

  factory PageImagesModel.fromJson(Map<String, dynamic> json) =>
      PageImagesModel(
        id: json["id"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
      };
}
