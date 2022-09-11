// To parse this JSON data, do
//
//     final newsfeedModel = newsfeedModelFromJson(jsonString);

import 'dart:convert';

NewsfeedModel newsfeedModelFromJson(String str) =>
    NewsfeedModel.fromJson(json.decode(str));

String newsfeedModelToJson(NewsfeedModel data) => json.encode(data.toJson());

class NewsfeedModel {
  NewsfeedModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  int? count;
  String? next;
  dynamic previous;
  List<Result>? results;

  factory NewsfeedModel.fromJson(Map<String, dynamic> json) => NewsfeedModel(
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
    this.newsfeedId,
    this.id,
    this.description,
    this.author,
    this.group,
    this.isApprove,
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
    this.page,
  });
  int? newsfeedId;
  int? id;
  String? description;
  Author? author;
  Group? group;
  bool? isApprove;
  int? totalImage;
  List<Image>? images;
  int? totalVideo;
  List<Video>? videos;
  int? totalComment;
  List<Comment>? comments;
  int? totalLike;
  List<LikedBy>? likedBy;
  String? timestamp;
  bool? isShare;
  String? postType;
  bool? like;
  SharePost? sharePost;
  Group? page;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    newsfeedId: json["newsfeed_id"],
        id: json["id"],
        description: json["description"],
        author: Author.fromJson(json["author"]),
        group: json["group"] == null ? null : Group.fromJson(json["group"]),
        isApprove: json["is_approve"] == null ? null : json["is_approve"],
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
        sharePost: json["share_post"] == null
            ? null
            : SharePost.fromJson(json["share_post"]),
        page: json["page"] == null ? null : Group.fromJson(json["page"]),
      );

  Map<String, dynamic> toJson() => {
        "newsfeed_id": newsfeedId,
        "id": id,
        "description": description,
        "author": author!.toJson(),
        "group": group == null ? null : group!.toJson(),
        "is_approve": isApprove == null ? null : isApprove,
        "total_image": totalImage,
        "images": List<dynamic>.from(images!.map((x) => x.toJson())),
        "total_video": totalVideo,
        "videos": List<dynamic>.from(videos!.map((x) => x.toJson())),
        "total_comment": totalComment,
        "comments": List<dynamic>.from(comments!.map((x) => x.toJson())),
        "total_like": totalLike,
        "liked_by": List<dynamic>.from(likedBy!.map((x) => x.toJson())),
        "timestamp": timestamp,
        "is_share": isShare,
        "post_type": postType,
        "like": like,
        "share_post": sharePost == null ? null : sharePost!.toJson(),
        "page": page == null ? null : page!.toJson(),
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

class Comment {
  Comment({
    this.id,
    this.comment,
    this.post,
    this.author,
    this.replies,
  });

  int? id;
  String? comment;
  int? post;
  LikedBy? author;
  List<dynamic>? replies;

  factory Comment.fromJson(Map<String, dynamic> json) => Comment(
        id: json["id"],
        comment: json["comment"],
        post: json["post"],
        author: LikedBy.fromJson(json["author"]),
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

class LikedBy {
  LikedBy({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.dateOfBirth,
    this.gender,
    this.isActive,
    this.profileImage,
  });

  int? id;
  String? firstName;
  String? lastName;
  String? email;
  DateTime? dateOfBirth;
  String? gender;
  bool? isActive;
  String? profileImage;

  factory LikedBy.fromJson(Map<String, dynamic> json) => LikedBy(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        dateOfBirth: json["date_of_birth"] == null
            ? null
            : DateTime.parse(json["date_of_birth"]),
        gender: json["gender"],
        isActive: json["is_active"],
        profileImage: json["profile_image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "date_of_birth": dateOfBirth == null
            ? null
            : "${dateOfBirth!.year.toString().padLeft(4, '0')}-${dateOfBirth!.month.toString().padLeft(2, '0')}-${dateOfBirth!.day.toString().padLeft(2, '0')}",
        "gender": gender,
        "is_active": isActive,
        "profile_image": profileImage,
      };
}

class Group {
  Group({
    this.id,
    this.name,
    this.category,
    this.coverPhoto,
    this.isPrivate,
    this.avatar,
  });

  int? id;
  String? name;
  String? category;
  String? coverPhoto;
  bool? isPrivate;
  String? avatar;

  factory Group.fromJson(Map<String, dynamic> json) => Group(
        id: json["id"],
        name: json["name"],
        category: json["category"],
        coverPhoto: json["cover_photo"],
        isPrivate: json["is_private"] == null ? null : json["is_private"],
        avatar: json["avatar"] == null ? null : json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "category": category,
        "cover_photo": coverPhoto,
        "is_private": isPrivate == null ? null : isPrivate,
        "avatar": avatar == null ? null : avatar,
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
  List<dynamic>? videos;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["id"],
        description: json["description"],
        author: Author.fromJson(json["author"]),
        totalImage: json["total_image"],
        images: List<Image>.from(json["images"].map((x) => Image.fromJson(x))),
        totalVideo: json["total_video"],
        videos: List<dynamic>.from(json["videos"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "author": author!.toJson(),
        "total_image": totalImage,
        "images": List<dynamic>.from(images!.map((x) => x.toJson())),
        "total_video": totalVideo,
        "videos": List<dynamic>.from(videos!.map((x) => x)),
      };
}

class Video {
  Video({
    this.id,
    this.video,
  });

  int? id;
  String? video;

  factory Video.fromJson(Map<String, dynamic> json) => Video(
        id: json["id"],
        video: json["video"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "video": video,
      };
}

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map!.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap!;
  }
}
