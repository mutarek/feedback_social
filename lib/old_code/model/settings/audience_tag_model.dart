// To parse this JSON data, do
//
//     final audienceTagModel = audienceTagModelFromJson(jsonString);

import 'dart:convert';

AudienceTagModel audienceTagModelFromJson(String str) =>
    AudienceTagModel.fromJson(json.decode(str));

String audienceTagModelToJson(AudienceTagModel data) =>
    json.encode(data.toJson());

class AudienceTagModel {
  AudienceTagModel({
    this.isAnyoneTag,
    this.isPeopleFollowTag,
  });

  bool? isAnyoneTag;
  bool? isPeopleFollowTag;

  factory AudienceTagModel.fromJson(Map<String, dynamic> json) =>
      AudienceTagModel(
        isAnyoneTag: json["is_anyone_tag"],
        isPeopleFollowTag: json["is_people_follow_tag"],
      );

  Map<String, dynamic> toJson() => {
        "is_anyone_tag": isAnyoneTag,
        "is_people_follow_tag": isPeopleFollowTag,
      };
}
