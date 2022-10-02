// To parse this JSON data, do
//
//     final authorNewsFeedPostModel = authorNewsFeedPostModelFromJson(jsonString);

import 'dart:convert';

AuthorNewsFeedPostModel authorNewsFeedPostModelFromJson(String str) => AuthorNewsFeedPostModel.fromJson(json.decode(str));

String authorNewsFeedPostModelToJson(AuthorNewsFeedPostModel data) => json.encode(data.toJson());

class AuthorNewsFeedPostModel {
  AuthorNewsFeedPostModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  int? count;
  String? next;
  dynamic previous;
  List<NewsfeedModels>? results;

  factory AuthorNewsFeedPostModel.fromJson(Map<String, dynamic> json) => AuthorNewsFeedPostModel(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: List<NewsfeedModels>.from(json["results"].map((x) => NewsfeedModels.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class NewsfeedModels {
  NewsfeedModels({
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
    this.sharePost,
  });

  int? id;
  String? description;
  Author? author;
  int? totalImage;
  List<Image>? images;
  int? totalVideo;
  List<Video>? videos;
  int? totalComment;
  List<dynamic>? comments;
  int? totalLike;
  List<LikedByMeModels>? likedBy;
  String? timestamp;
  bool? isShare;
  String? postType;
  bool? like;
  SharePost? sharePost;

  factory NewsfeedModels.fromJson(Map<String, dynamic> json) => NewsfeedModels(
        id: json["id"],
        description: json["description"],
        author: Author.fromJson(json["author"]),
        totalImage: json["total_image"],
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
        totalVideo: json["total_video"],
        videos: List<Video>.from(json["videos"].map((x) => Video.fromJson(x))),
        totalComment: json["total_comment"],
        comments: List<dynamic>.from(json["comments"].map((x) => x)),
        totalLike: json["total_like"],
        likedBy: List<LikedByMeModels>.from(json["liked_by"].map((x) => x)),
        timestamp: json["timestamp"],
        isShare: json["is_share"],
        postType: json["post_type"],
        like: json["like"],
        sharePost: json["share_post"] == null ? null : SharePost.fromJson(json["share_post"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "author": author!.toJson(),
        "total_image": totalImage,
        "images": List<dynamic>.from(images!.map((x) => x.toJson())),
        "total_video": totalVideo,
        "videos": List<dynamic>.from(videos!.map((x) => x.toJson())),
        "total_comment": totalComment,
        "comments": List<dynamic>.from(comments!.map((x) => x)),
        "total_like": totalLike,
        "liked_by": List<dynamic>.from(likedBy!.map((x) => x)),
        "timestamp": timestamp,
        "is_share": isShare,
        "post_type": postType,
        "like": like,
        "share_post": sharePost == null ? null : sharePost!.toJson(),
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

class SharePost {
  SharePost({
    this.post,
    this.postUrl,
    this.shareFrom,
    this.timestamp,
  });

  Post? post;
  String? postUrl;
  String? shareFrom;
  String? timestamp;

  factory SharePost.fromJson(Map<String, dynamic> json) => SharePost(
        post: Post.fromJson(json["post"]),
        postUrl: json["post_url"],
        shareFrom: json["share_from"],
        timestamp: json["timestamp"],
      );

  Map<String, dynamic> toJson() => {
        "post": post!.toJson(),
        "post_url": postUrl,
        "share_from": shareFrom,
        "timestamp": timestamp,
      };
}

class Post {
  Post({
    this.id,
    this.description,
    this.author,
    this.totalImage,
    this.images,
    this.totalVideo,
    this.videos,
  });

  int? id;
  String? description;
  Author? author;
  int? totalImage;
  List<Image>? images;
  int? totalVideo;
  List<Video>? videos;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["id"],
        description: json["description"],
        author: Author.fromJson(json["author"]),
        totalImage: json["total_image"],
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
        totalVideo: json["total_video"],
        videos: List<Video>.from(json["videos"].map((x) => Video.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "author": author!.toJson(),
        "total_image": totalImage,
        "images": List<dynamic>.from(images!.map((x) => x.toJson())),
        "total_video": totalVideo,
        "videos": List<dynamic>.from(videos!.map((x) => x.toJson())),
      };
}

class Video {
  Video({
    this.id,
    this.thumbnail,
    this.video,
  });

  int? id;
  String? thumbnail;
  String? video;

  factory Video.fromJson(Map<String, dynamic> json) => Video(
        id: json["id"],
        thumbnail: json["thumbnail"],
        video: json["video"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "thumbnail": thumbnail,
        "video": video,
      };
}
class LikedByMeModels {
  LikedByMeModels({
    this.id,
    this.fullName,
    this.profileImage,
  });

  LikedByMeModels.fromJson(dynamic json) {
    id = json['id'];
    fullName = json['full_name'];
    profileImage = json['profile_image'];
  }

  num? id;
  String? fullName;
  String? profileImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['full_name'] = fullName;
    map['profile_image'] = profileImage;
    return map;
  }
}
