// To parse this JSON data, do
//
//     final timelinePostCommentModel = timelinePostCommentModelFromJson(jsonString);

import 'dart:convert';

List<TimelinePostCommentModel> timelinePostCommentModelFromJson(String str) =>
    List<TimelinePostCommentModel>.from(
        json.decode(str).map((x) => TimelinePostCommentModel.fromJson(x)));

String timelinePostCommentModelToJson(List<TimelinePostCommentModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TimelinePostCommentModel {
  TimelinePostCommentModel({
    this.id,
    this.comment,
    this.post,
    this.author,
    this.replies,
  });

  int? id;
  String? comment;
  int? post;
  Author? author;
  List<dynamic>? replies;

  factory TimelinePostCommentModel.fromJson(Map<String, dynamic> json) =>
      TimelinePostCommentModel(
        id: json["id"],
        comment: json["comment"],
        post: json["post"],
        author: Author.fromJson(json["author"]),
        replies: List<dynamic>.from(json["replies"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "comment": comment,
        "post": post,
        "author": author!.toJson(),
        "replies": List<dynamic>.from(replies!.map((x) => x)),
      };
}

class Author {
  Author({
    this.id,
    this.fullName,
    this.profileImage,
  });

  int? id;
  String? fullName;
  String? profileImage;

  factory Author.fromJson(Map<String, dynamic> json) => Author(
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
