// To parse this JSON data, do
//
//     final getOtherSettingsValueModel = getOtherSettingsValueModelFromJson(jsonString);

import 'dart:convert';

GetOtherSettingsValueModel getOtherSettingsValueModelFromJson(String str) => GetOtherSettingsValueModel.fromJson(json.decode(str));

String getOtherSettingsValueModelToJson(GetOtherSettingsValueModel data) => json.encode(data.toJson());

class GetOtherSettingsValueModel {
  GetOtherSettingsValueModel({
    required this.isAnyoneTag,
    required this.isFollowerTag,
    required this.isFollowingTag,
    required this.isAnyoneShare,
    required this.isFollowerShare,
    required this.isFollowingShare,
    required this.isAnyoneMessage,
    required this.isFollowerMessage,
    required this.isFollowingMessage,
  });

  bool isAnyoneTag;
  bool isFollowerTag;
  bool isFollowingTag;
  bool isAnyoneShare;
  bool isFollowerShare;
  bool isFollowingShare;
  bool isAnyoneMessage;
  bool isFollowerMessage;
  bool isFollowingMessage;

  factory GetOtherSettingsValueModel.fromJson(Map<String, dynamic> json) => GetOtherSettingsValueModel(
    isAnyoneTag: json["is_anyone_tag"],
    isFollowerTag: json["is_follower_tag"],
    isFollowingTag: json["is_following_tag"],
    isAnyoneShare: json["is_anyone_share"],
    isFollowerShare: json["is_follower_share"],
    isFollowingShare: json["is_following_share"],
    isAnyoneMessage: json["is_anyone_message"],
    isFollowerMessage: json["is_follower_message"],
    isFollowingMessage: json["is_following_message"],
  );

  Map<String, dynamic> toJson() => {
    "is_anyone_tag": isAnyoneTag,
    "is_follower_tag": isFollowerTag,
    "is_following_tag": isFollowingTag,
    "is_anyone_share": isAnyoneShare,
    "is_follower_share": isFollowerShare,
    "is_following_share": isFollowingShare,
    "is_anyone_message": isAnyoneMessage,
    "is_follower_message": isFollowerMessage,
    "is_following_message": isFollowingMessage,
  };
}
