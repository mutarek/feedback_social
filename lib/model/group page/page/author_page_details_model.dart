// To parse required this JSON data, do
//
//     final authorPageDetailsModel = authorPageDetailsModelFromJson(jsonString);

import 'dart:convert';

AuthorPageDetailsModel authorPageDetailsModelFromJson(String str) =>
    AuthorPageDetailsModel.fromJson(json.decode(str));

String authorPageDetailsModelToJson(AuthorPageDetailsModel data) =>
    json.encode(data.toJson());

class AuthorPageDetailsModel {
  AuthorPageDetailsModel({
    required this.id,
    required this.name,
    required this.category,
    required this.coverPhoto,
    required this.avatar,
    required this.createdAt,
    required this.author,
    required this.photos,
    required this.videos,
    required this.posts,
    required this.like,
    required this.totalLike,
    required this.likedBy,
  });

  int id;
  String name;
  String category;
  String coverPhoto;
  String avatar;
  String createdAt;
  Author author;
  List<Photo> photos;
  List<Video> videos;
  List<Post> posts;
  bool like;
  int totalLike;
  List<LikedBy> likedBy;

  factory AuthorPageDetailsModel.fromJson(Map<String, dynamic> json) =>
      AuthorPageDetailsModel(
        id: json["id"],
        name: json["name"],
        category: json["category"],
        coverPhoto: json["cover_photo"],
        avatar: json["avatar"],
        createdAt: json["created_at"],
        author: Author.fromJson(json["author"]),
        photos: List<Photo>.from(json["photos"].map((x) => Photo.fromJson(x))),
        videos: List<Video>.from(json["videos"].map((x) => Video.fromJson(x))),
        posts: List<Post>.from(json["posts"].map((x) => Post.fromJson(x))),
        like: json["like"],
        totalLike: json["total_like"],
        likedBy: List<LikedBy>.from(
            json["liked_by"].map((x) => LikedBy.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "category": category,
        "cover_photo": coverPhoto,
        "avatar": avatar,
        "created_at": createdAt,
        "author": author.toJson(),
        "photos": List<dynamic>.from(photos.map((x) => x.toJson())),
        "videos": List<dynamic>.from(videos.map((x) => x.toJson())),
        "posts": List<dynamic>.from(posts.map((x) => x.toJson())),
        "like": like,
        "total_like": totalLike,
        "liked_by": List<dynamic>.from(likedBy.map((x) => x.toJson())),
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




class LikedBy {
  LikedBy({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.dateOfBirth,
    required this.gender,
    required this.isActive,
    required this.profileImage,
  });

  int id;
  String firstName;
  String lastName;
  String email;
  dynamic dateOfBirth;
  String gender;
  bool isActive;
  String profileImage;

  factory LikedBy.fromJson(Map<String, dynamic> json) => LikedBy(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        dateOfBirth: json["date_of_birth"],
        gender: json["gender"],
        isActive: json["is_active"],
        profileImage: json["profile_image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "date_of_birth": dateOfBirth,
        "gender": gender,
        "is_active": isActive,
        "profile_image": profileImage,
      };
}





class Photo {
  Photo({
    required this.id,
    required this.image,
  });

  int id;
  String image;

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
        id: json["id"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
      };
}

class Post {
  Post({
    required this.id,
    required this.description,
    required this.author,
    required this.page,
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
  });

  int id;
  String description;
  Author author;
  Page page;
  int totalImage;
  List<Photo> images;
  int totalVideo;
  List<Video> videos;
  int totalComment;
  List<Comment> comments;
  int totalLike;
  List<LikedBy> likedBy;
  String timestamp;
  bool isShare;
  String postType;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["id"],
        description: json["description"],
        author: Author.fromJson(json["author"]),
        page: Page.fromJson(json["page"]),
        totalImage: json["total_image"],
        images: List<Photo>.from(json["images"].map((x) => Photo.fromJson(x))),
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
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "author": author.toJson(),
        "page": page.toJson(),
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
        "post_type": postType,
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
  List<dynamic> replies;

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
        "author": author.toJson(),
        "replies": List<dynamic>.from(replies.map((x) => x)),
      };
}

class Page {
  Page({
    required this.id,
    required this.name,
    required this.category,
    required this.coverPhoto,
    required this.avatar,
  });

  int id;
  String name;
  String category;
  String coverPhoto;
  String avatar;

  factory Page.fromJson(Map<String, dynamic> json) => Page(
        id: json["id"],
        name: json["name"],
        category: json["category"],
        coverPhoto: json["cover_photo"],
        avatar: json["avatar"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "category": category,
        "cover_photo": coverPhoto,
        "avatar": avatar,
      };
}


class Video {
  Video({
    required this.id,
    required this.video,
  });

  int id;
  String video;

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

  EnumValues( this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map!.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap!;
  }
}
