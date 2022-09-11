// To parse this JSON data, do
//
//     final drectMassagesModel = drectMassagesModelFromJson(jsonString);

import 'dart:convert';

DrectMassagesModel drectMassagesModelFromJson(String str) =>
    DrectMassagesModel.fromJson(json.decode(str));

String drectMassagesModelToJson(DrectMassagesModel data) =>
    json.encode(data.toJson());

class DrectMassagesModel {
  DrectMassagesModel({
    this.isAnyoneMessage,
    this.isFollowerMessage,
    this.isFollowingMessage,
  });

  bool? isAnyoneMessage;
  bool? isFollowerMessage;
  bool? isFollowingMessage;

  factory DrectMassagesModel.fromJson(Map<String, dynamic> json) =>
      DrectMassagesModel(
        isAnyoneMessage: json["is_anyone_message"],
        isFollowerMessage: json["is_follower_message"],
        isFollowingMessage: json["is_following_message"],
      );

  Map<String, dynamic> toJson() => {
        "is_anyone_message": isAnyoneMessage,
        "is_follower_message": isFollowerMessage,
        "is_following_message": isFollowingMessage,
      };
}
