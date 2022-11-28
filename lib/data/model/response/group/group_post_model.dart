// To parse this JSON data, do
//
//     final groupPostModel = groupPostModelFromJson(jsonString);

import 'dart:convert';

List<GroupPostModel> groupPostModelFromJson(String str) =>
    List<GroupPostModel>.from(
        json.decode(str).map((x) => GroupPostModel.fromJson(x)));

String groupPostModelToJson(List<GroupPostModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GroupPostModel {
  GroupPostModel({
    required this.id,
    required this.description,
    required this.author,
    required this.group,
    required this.isApprove,
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
  Group group;
  bool isApprove;
  int totalImage;
  List<Image> images;
  int totalVideo;
  List<Video> videos;
  int totalComment;
  List<Comment> comments;
  int totalLike;
  List<LikedBy> likedBy;
  String timestamp;
  bool isShare;
  String postType;
  bool like;

  factory GroupPostModel.fromJson(Map<String, dynamic> json) => GroupPostModel(
        id: json["id"],
        description: json["description"],
        author: Author.fromJson(json["author"]),
        group: Group.fromJson(json["group"]),
        isApprove: json["is_approve"],
        totalImage: json["total_image"],
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
        totalVideo: json["total_video"],
        videos: List<Video>.from(json["videos"].map((x) => Video.fromJson(x))),
        totalComment: json["total_comment"],
        comments: List<Comment>.from(
            json["comments"].map((x) => Comment.fromJson(x))),
        totalLike: json["total_like"],
        likedBy: List<LikedBy>.from(
            json["liked_by"].map((x) => LikedBy.fromJson(x))),
        timestamp: json["timestamp"],
        isShare: json["is_share"],
        postType: json["post_type"],
        like: json["like"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "author": author.toJson(),
        "group": group.toJson(),
        "is_approve": isApprove,
        "total_image": totalImage,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "total_video": totalVideo,
        "videos": List<dynamic>.from(videos.map((x) => x.toJson())),
        "total_comment": totalComment,
        "comments": List<dynamic>.from(comments.map((x) => x.toJson())),
        "total_like": totalLike,
        "liked_by": List<dynamic>.from(likedBy.map((x) => x.toJson())),
        "timestamp": timestamp,
        "is_share": isShare,
        "post_type": postTypeValues.reverse[postType],
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
  LikedBy author;
  List<Reply> replies;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json["id"],
        comment: json["comment"],
        post: json["post"],
        author: LikedBy.fromJson(json["author"]),
        replies:
            List<Reply>.from(json["replies"].map((x) => Reply.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "comment": comment,
        "post": post,
        "author": author.toJson(),
        "replies": List<dynamic>.from(replies.map((x) => x.toJson())),
      };
}

class LikedBy {
  LikedBy({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.isActive,
    required this.profileImage,
  });

  int id;
  String firstName;
  String lastName;
  bool isActive;
  String profileImage;

  factory LikedBy.fromJson(Map<String, dynamic> json) => LikedBy(
        id: json["id"]??0,
        firstName: json["first_name"]??"",
        lastName: json["last_name"]??'',
        isActive: json["is_active"]??false,
        profileImage: json["profile_image"]??"",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "is_active": isActive,
        "profile_image": profileImage,
      };
}

class Reply {
  Reply({
    required this.id,
    required this.comment,
    required this.parent,
    required this.post,
    required this.author,
    required this.replies,
  });

  int id;
  String comment;
  int parent;
  int post;
  LikedBy author;
  List<dynamic> replies;

  factory Reply.fromJson(Map<String, dynamic> json) => Reply(
        id: json["id"],
        comment: json["comment"],
        parent: json["parent"],
        post: json["post"],
        author: LikedBy.fromJson(json["author"]),
        replies: List<dynamic>.from(json["replies"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "comment": comment,
        "parent": parent,
        "post": post,
        "author": author.toJson(),
        "replies": List<dynamic>.from(replies.map((x) => x)),
      };
}

class Group {
  Group({
    required this.id,
    required this.name,
    required this.category,
    required this.coverPhoto,
    required this.isPrivate,
  });

  int id;
  String name;
  String category;
  String coverPhoto;
  bool isPrivate;

  factory Group.fromJson(Map<String, dynamic> json) => Group(
        id: json["id"],
        name: json["name"],
        category: json["category"],
        coverPhoto: json["cover_photo"],
        isPrivate: json["is_private"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "category": category,
        "cover_photo": coverPhoto,
        "is_private": isPrivate,
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

enum PostType { group }

final postTypeValues = EnumValues({"group": PostType.group});

class Video {
  Video({
    required this.id,
    required this.thumbnail,
    required this.video,
  });

  int id;
  String thumbnail;
  String video;

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

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap ??= map!.map((k, v) =>  MapEntry(v, k));
    return reverseMap!;
  }
}
