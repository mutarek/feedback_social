
import 'dart:convert';

List<GroupImagesModel> groupImagesModelFromJson(String str) =>
    List<GroupImagesModel>.from(json.decode(str).map((x) => GroupImagesModel.fromJson(x)));

String groupImagesModelToJson(List<GroupImagesModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GroupImagesModel {
  GroupImagesModel({required this.id, required this.image});

  int id;
  String image;

  factory GroupImagesModel.fromJson(Map<String, dynamic> json) => GroupImagesModel(id: json["id"], image: json["image"]);

  Map<String, dynamic> toJson() => {"id": id, "image": image};
}
