import 'dart:convert';

List<ProfileImagesModel> profileImagesModelFromJson(String str) =>
    List<ProfileImagesModel>.from(json.decode(str).map((x) => ProfileImagesModel.fromJson(x)));

String profileImagesModelToJson(List<ProfileImagesModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProfileImagesModel {
  ProfileImagesModel({required this.id, required this.image});

  int id;
  String image;

  factory ProfileImagesModel.fromJson(Map<String, dynamic> json) => ProfileImagesModel(id: json["id"], image: json["image"]);

  Map<String, dynamic> toJson() => {"id": id, "image": image};
}
