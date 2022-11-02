
import 'dart:convert';

List<PrivacyPolicyModel> privacyPolicyModelFromJson(String str) =>
    List<PrivacyPolicyModel>.from(
        json.decode(str).map((x) => PrivacyPolicyModel.fromJson(x)));

String privacyPolicyModelToJson(List<PrivacyPolicyModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PrivacyPolicyModel {
  PrivacyPolicyModel({
     this.id,
     this.title,
     this.description,
     this.createdAt,
  });

  int? id;
  String? title;
  String? description;
  String? createdAt;

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
