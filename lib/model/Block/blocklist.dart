import 'dart:convert';

List<BlocklistModel> blocklistModelFromJson(String str) =>
    List<BlocklistModel>.from(
        json.decode(str).map((x) => BlocklistModel.fromJson(x)));

String blocklistModelToJson(List<BlocklistModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class BlocklistModel {
  BlocklistModel({
    required this.id,
    required this.fullName,
    required this.profileImage,
  });

  int id;
  String fullName;
  String profileImage;

  factory BlocklistModel.fromJson(Map<String, dynamic> json) => BlocklistModel(
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
