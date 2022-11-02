// To parse this JSON data, do
//
//     final profileVideoModel = profileVideoModelFromJson(jsonString);

import 'dart:convert';

List<ProfileVideoModel> profileVideoModelFromJson(String str) =>
    List<ProfileVideoModel>.from(json.decode(str).map((x) => ProfileVideoModel.fromJson(x)));

String profileVideoModelToJson(List<ProfileVideoModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ProfileVideoModel {
  ProfileVideoModel({required this.id, required this.video, this.thumbnail});

  int id;
  String video;
  String? thumbnail;

  factory ProfileVideoModel.fromJson(Map<String, dynamic> json) =>
      ProfileVideoModel(id: json["id"], video: json["video"], thumbnail: json["thumbnail"]);

  Map<String, dynamic> toJson() => {"id": id, "video": video, "thumbnail": thumbnail};
}
