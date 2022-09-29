// To parse required this JSON data, do
//
//     final singlePostModel = singlePostModelFromJson(jsonString);

import 'dart:convert';

SinglePostModel singlePostModelFromJson(String str) =>
    SinglePostModel.fromJson(json.decode(str));

String singlePostModelToJson(SinglePostModel data) =>
    json.encode(data.toJson());

class SinglePostModel {
  SinglePostModel({
    required this.id,
    required this.description,
    required this.author,
    required this.totalImage,
    required this.images,
    required this.totalVideo,
    required this.videos,
    required this.totalComment,
    required this.comments,
    required this.totalLike,
    required this.likedBy,
    required this.timestamp,
    required this.isShare,
    required this.postType,
    required this.like,
  });

  int id;
  String description;
  Author author;
  int totalImage;
  List<Image> images;
  int totalVideo;
  List<dynamic> videos;
  int totalComment;
  List<Comment> comments;
  int totalLike;
  List<dynamic> likedBy;
  String timestamp;
  bool isShare;
  String postType;
  bool like;

  factory SinglePostModel.fromJson(Map<String, dynamic> json) =>
      SinglePostModel(
        id: json["id"],
        description: json["description"],
        author: Author.fromJson(json["author"]),
        totalImage: json["total_image"],
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
        totalVideo: json["total_video"],
        videos: List<dynamic>.from(json["videos"].map((x) => x)),
        totalComment: json["total_comment"],
        comments: List<Comment>.from(
            json["comments"].map((x) => Comment.fromJson(x))),
        totalLike: json["total_like"],
        likedBy: List<dynamic>.from(json["liked_by"].map((x) => x)),
        timestamp: json["timestamp"],
        isShare: json["is_share"],
        postType: json["post_type"],
        like: json["like"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "author": author.toJson(),
        "total_image": totalImage,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "total_video": totalVideo,
        "videos": List<dynamic>.from(videos.map((x) => x)),
        "total_comment": totalComment,
        "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
        "total_like": totalLike,
        "liked_by": List<dynamic>.from(likedBy.map((x) => x)),
        "timestamp": timestamp,
        "is_share": isShare,
        "post_type": postType,
        "like": like,
      };
}

class Author {
  Author({
    required this.id,
    required this.fullName,
    required this.profileImage,
  });

  int id;
  String fullName;
  String profileImage;

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

class Comment {
  Comment({
    required this.id,
    required this.comment,
    required this.post,
    required this.author,
    required this.replies,
  });

  int id;
  String comment;
  int post;
  Author author;
  List<dynamic> replies;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
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
        "author": author.toJson(),
        "replies": List<dynamic>.from(replies.map((x) => x)),
      };
}

class Image {
  Image({
    required this.id,
    required this.image,
  });

  int id;
  String image;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        id: json["id"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
      };
}
