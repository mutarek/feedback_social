// To parse this JSON data, do
//
//     final socketCommentModel = socketCommentModelFromJson(jsonString);

import 'dart:convert';

List<SocketCommentModel> socketCommentModelFromJson(String str) =>
    List<SocketCommentModel>.from(
        json.decode(str).map((x) => SocketCommentModel.fromJson(x)));

String socketCommentModelToJson(List<SocketCommentModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SocketCommentModel {
  SocketCommentModel({
    this.type,
    this.commentType,
    this.commentData,
  });

  String? type;
  String? commentType;
  CommentData? commentData;

  factory SocketCommentModel.fromJson(Map<String, dynamic> json) =>
      SocketCommentModel(
        type: json["type"],
        commentType: json["comment_type"],
        commentData: CommentData.fromJson(json["comment_data"]),
      );

  Map<String, dynamic> toJson() => {
        "type": type,
        "comment_type": commentType,
        "comment_data": commentData!.toJson(),
      };
}

class CommentData {
  CommentData({
    this.comment,
    this.fullName,
    this.profileImage,
  });

  String? comment;
  String? fullName;
  String? profileImage;

  factory CommentData.fromJson(Map<String, dynamic> json) => CommentData(
        comment: json["comment"],
        fullName: json["full_name"],
        profileImage: json["profile_image"],
      );

  Map<String, dynamic> toJson() => {
        "comment": comment,
        "full_name": fullName,
        "profile_image": profileImage,
      };
}
