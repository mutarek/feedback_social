// To parse this JSON data, do
//
//     final privacyPolicyModel = privacyPolicyModelFromJson(jsonString);

import 'dart:convert';

List<PrivacyPolicyModel> privacyPolicyModelFromJson(String str) =>
    List<PrivacyPolicyModel>.from(
        json.decode(str).map((x) => PrivacyPolicyModel.fromJson(x)));

String privacyPolicyModelToJson(List<PrivacyPolicyModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PrivacyPolicyModel {
  PrivacyPolicyModel({
    required this.id,
    required this.title,
    required this.description,
    required this.createdAt,
  });

  int id;
  String title;
  String description;
  String createdAt;

  factory PrivacyPolicyModel.fromJson(Map<String, dynamic> json) =>
      PrivacyPolicyModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        createdAt: json["created_at"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "created_at": createdAt,
      };
}
