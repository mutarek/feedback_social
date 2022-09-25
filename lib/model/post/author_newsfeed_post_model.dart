// To parse this JSON data, do
//
//     final authorNewsFeedPostModel = authorNewsFeedPostModelFromJson(jsonString);

import 'dart:convert';

AuthorNewsFeedPostModel authorNewsFeedPostModelFromJson(String str) =>
    AuthorNewsFeedPostModel.fromJson(json.decode(str));

String authorNewsFeedPostModelToJson(AuthorNewsFeedPostModel data) =>
    json.encode(data.toJson());

class AuthorNewsFeedPostModel {
  AuthorNewsFeedPostModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  int? count;
  dynamic next;
  dynamic previous;
  List<Result>? results;

  factory AuthorNewsFeedPostModel.fromJson(Map<String, dynamic> json) =>
      AuthorNewsFeedPostModel(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class Result {
  Result({
    this.id,
    this.description,
    this.author,
    this.totalImage,
    this.images,
    this.totalVideo,
    this.videos,
    this.totalComment,
    this.comments,
    this.totalLike,
    this.likedBy,
    this.timestamp,
    this.isShare,
    this.postType,
    this.like,
  });

  int? id;
  String? description;
  Author? author;
  int? totalImage;
  List<Image>? images;
  int? totalVideo;
  List<dynamic>? videos;
  int? totalComment;
  List<dynamic>? comments;
  int? totalLike;
  List<dynamic>? likedBy;
  String? timestamp;
  bool? isShare;
  String? postType;
  bool? like;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        id: json["id"],
        description: json["description"],
        author: Author.fromJson(json["author"]),
        totalImage: json["total_image"],
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
        totalVideo: json["total_video"],
        videos: List<dynamic>.from(json["videos"].map((x) => Video.fromJson(x))),
        totalComment: json["total_comment"],
        comments: List<dynamic>.from(json["comments"].map((x) => x)),
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
        "author": author!.toJson(),
        "total_image": totalImage,
        "images": List<dynamic>.from(images!.map((x) => x.toJson())),
        "total_video": totalVideo,
        "videos": List<dynamic>.from(videos!.map((x) => x)),
        "total_comment": totalComment,
        "comments": List<dynamic>.from(comments!.map((x) => x)),
        "total_like": totalLike,
        "liked_by": List<dynamic>.from(likedBy!.map((x) => x)),
        "timestamp": timestamp,
        "is_share": isShare,
        "post_type": postType,
        "like": like,
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

class Image {
  Image({
    this.id,
    this.image,
  });

  int? id;
  String? image;

  factory Image.fromJson(Map<String, dynamic> json) => Image(
        id: json["id"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
      };
}

class Video {
  Video({
    this.id,
    this.video,
    this.thumbnail,
  });

  int? id;
  String? video;
  String? thumbnail;

  factory Video.fromJson(Map<String, dynamic> json) => Video(
        id: json["id"],
        video: json["video"],
        thumbnail: json["thumbnail"]
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "video": video,
        "thumbnail": thumbnail,
      };
}
