// To parse this JSON data, do
//
//     final latestVersionModel = latestVersionModelFromJson(jsonString);

import 'dart:convert';

LatestVersionModel latestVersionModelFromJson(String str) =>
    LatestVersionModel.fromJson(json.decode(str));

String latestVersionModelToJson(LatestVersionModel data) =>
    json.encode(data.toJson());

class LatestVersionModel {
  LatestVersionModel({
    required this.version,
  });

  String version;

  factory LatestVersionModel.fromJson(Map<String, dynamic> json) =>
      LatestVersionModel(
        version: json["version"],
      );

  Map<String, dynamic> toJson() => {
        "version": version,
      };
}
