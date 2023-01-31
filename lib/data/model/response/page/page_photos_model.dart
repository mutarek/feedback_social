// To parse this JSON data, do
//
//     final pagePhotosModel = pagePhotosModelFromJson(jsonString);

import 'dart:convert';

List<PagePhotosModel> pagePhotosModelFromJson(String str) => List<PagePhotosModel>.from(json.decode(str).map((x) => PagePhotosModel.fromJson(x)));

String pagePhotosModelToJson(List<PagePhotosModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PagePhotosModel {
  PagePhotosModel({
    required this.id,
    required this.image,
    required this.totalComment,
    required this.totalShare,
    required this.commentUrl,
    required this.sharedByUrl,
    required this.totalReaction,
    required this.totalLiked,
    required this.totalLoved,
    required this.totalSad,
    required this.loveReactUserUrl,
    required this.likeReactUserUrl,
    required this.sadReactUserUrl,
    required this.allReactUserUrl,
    this.reaction,
  });

  int id;
  String image;
  int totalComment;
  int totalShare;
  String commentUrl;
  String sharedByUrl;
  int totalReaction;
  int totalLiked;
  int totalLoved;
  int totalSad;
  String loveReactUserUrl;
  String likeReactUserUrl;
  String sadReactUserUrl;
  String allReactUserUrl;
  dynamic reaction;

  factory PagePhotosModel.fromJson(Map<String, dynamic> json) => PagePhotosModel(
    id: json["id"],
    image: json["image"],
    totalComment: json["total_comment"],
    totalShare: json["total_share"],
    commentUrl: json["comment_url"],
    sharedByUrl: json["shared_by_url"],
    totalReaction: json["total_reaction"],
    totalLiked: json["total_liked"],
    totalLoved: json["total_loved"],
    totalSad: json["total_sad"],
    loveReactUserUrl: json["love_react_user_url"],
    likeReactUserUrl: json["like_react_user_url"],
    sadReactUserUrl: json["sad_react_user_url"],
    allReactUserUrl: json["all_react_user_url"],
    reaction: json["reaction"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
    "total_comment": totalComment,
    "total_share": totalShare,
    "comment_url": commentUrl,
    "shared_by_url": sharedByUrl,
    "total_reaction": totalReaction,
    "total_liked": totalLiked,
    "total_loved": totalLoved,
    "total_sad": totalSad,
    "love_react_user_url": loveReactUserUrl,
    "like_react_user_url": likeReactUserUrl,
    "sad_react_user_url": sadReactUserUrl,
    "all_react_user_url": allReactUserUrl,
    "reaction": reaction,
  };
}
