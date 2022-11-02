// To parse required this JSON data, do
//
//     final searchModel = searchModelFromJson(jsonString);

// ignore_for_file: unnecessary_null_comparison, prefer_if_null_operators, prefer_null_aware_operators, unnecessary_new, prefer_conditional_assignment

import 'dart:convert';

SearchModel searchModelFromJson(String str) =>
    SearchModel.fromJson(json.decode(str));

String searchModelToJson(SearchModel data) => json.encode(data.toJson());

class SearchModel {
  SearchModel({
    required this.people,
    required this.posts,
    required this.groups,
    required this.pages,
  });

  List<Person> people;
  List<PostElement> posts;
  List<dynamic> groups;
  List<Page> pages;

  factory SearchModel.fromJson(Map<String, dynamic> json) => SearchModel(
        people:
            List<Person>.from(json["people"].map((x) => Person.fromJson(x))),
        posts: List<PostElement>.from(
            json["posts"].map((x) => PostElement.fromJson(x))),
        groups: List<dynamic>.from(json["groups"].map((x) => x)),
        pages: List<Page>.from(json["pages"].map((x) => Page.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "people": List<dynamic>.from(people.map((x) => x.toJson())),
        "posts": List<dynamic>.from(posts.map((x) => x.toJson())),
        "groups": List<dynamic>.from(groups.map((x) => x)),
        "pages": List<dynamic>.from(pages.map((x) => x.toJson())),
      };
}

class Page {
  Page({
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
  List<dynamic> photos;
  List<dynamic> videos;
  List<dynamic> posts;
  bool like;
  int totalLike;
  List<dynamic> likedBy;

  factory Page.fromJson(Map<String, dynamic> json) => Page(
        id: json["id"],
        name: json["name"],
        category: json["category"],
        coverPhoto: json["cover_photo"],
        avatar: json["avatar"],
        createdAt: json["created_at"],
        author: Author.fromJson(json["author"]),
        photos: List<dynamic>.from(json["photos"].map((x) => x)),
        videos: List<dynamic>.from(json["videos"].map((x) => x)),
        posts: List<dynamic>.from(json["posts"].map((x) => x)),
        like: json["like"],
        totalLike: json["total_like"],
        likedBy: List<dynamic>.from(json["liked_by"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "category": category,
        "cover_photo": coverPhoto,
        "avatar": avatar,
        "created_at": createdAt,
        "author": author.toJson(),
        "photos": List<dynamic>.from(photos.map((x) => x)),
        "videos": List<dynamic>.from(videos.map((x) => x)),
        "posts": List<dynamic>.from(posts.map((x) => x)),
        "like": like,
        "total_like": totalLike,
        "liked_by": List<dynamic>.from(likedBy.map((x) => x)),
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


class Person {
  Person({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.profileImage,
  });

  int id;
  String firstName;
  String lastName;
  String email;
  String profileImage;

  factory Person.fromJson(Map<String, dynamic> json) => Person(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        profileImage: json["profile_image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "profile_image": profileImage,
      };
}

class PostElement {
  PostElement({
    required this.id,
    required this.description,
    required this.author,
    required this.isShare,
    required this.sharePost,
    required this.totalImage,
    required this.images,
    required this.totalVideo,
    required this.videos,
    required this.totalComment,
    required this.comments,
    required this.totalLike,
    required this.likedBy,
    required this.timestamp,
    required this.postType,
    required this.like,
  });

  int id;
  String description;
  Author author;
  bool isShare;
  SharePost sharePost;
  int totalImage;
  List<dynamic> images;
  int totalVideo;
  List<dynamic> videos;
  int totalComment;
  List<dynamic> comments;
  int totalLike;
  List<LikedBy> likedBy;
  String timestamp;
  String postType;
  bool like;

  factory PostElement.fromJson(Map<String, dynamic> json) => PostElement(
        id: json["id"],
        description: json["description"],
        author: Author.fromJson(json["author"]),
        isShare: json["is_share"],
        sharePost: SharePost.fromJson(json["share_post"]),
        totalImage: json["total_image"],
        images: List<dynamic>.from(json["images"].map((x) => x)),
        totalVideo: json["total_video"],
        videos: List<dynamic>.from(json["videos"].map((x) => x)),
        totalComment:
            json["total_comment"],
        comments: List<dynamic>.from(json["comments"].map((x) => x)),
        totalLike: json["total_like"],
        likedBy: List<LikedBy>.from(
                json["liked_by"].map((x) => LikedBy.fromJson(x))),
        timestamp: json["timestamp"],
        postType: json["post_type"],
        like: json["like"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "author": author.toJson(),
        "is_share": isShare,
        "share_post": sharePost == null ? null : sharePost.toJson(),
        "total_image": totalImage == null ? null : totalImage,
        "images":
            images == null ? null : List<dynamic>.from(images.map((x) => x)),
        "total_video": totalVideo == null ? null : totalVideo,
        "videos":
            videos == null ? null : List<dynamic>.from(videos.map((x) => x)),
        "total_comment": totalComment == null ? null : totalComment,
        "comments": comments == null
            ? null
            : List<dynamic>.from(comments.map((x) => x)),
        "total_like": totalLike == null ? null : totalLike,
        "liked_by": likedBy == null
            ? null
            : List<dynamic>.from(likedBy.map((x) => x.toJson())),
        "timestamp": timestamp == null ? null : timestamp,
        "post_type": postType == null ? null : postType,
        "like": like == null ? null : like,
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

class SharePost {
  SharePost({
    required this.post,
    required this.postUrl,
    required this.shareFrom,
    required this.timestamp,
  });

  SharePostPost post;
  String postUrl;
  String shareFrom;
  String timestamp;

  factory SharePost.fromJson(Map<String, dynamic> json) => SharePost(
        post: SharePostPost.fromJson(json["post"]),
        postUrl: json["post_url"],
        shareFrom: json["share_from"],
        timestamp: json["timestamp"],
      );

  Map<String, dynamic> toJson() => {
        "post": post.toJson(),
        "post_url": postUrl,
        "share_from": shareFrom,
        "timestamp": timestamp,
      };
}

class SharePostPost {
  SharePostPost({
    required this.id,
    required this.description,
    required this.author,
    required this.group,
    required this.page,
  });

  int id;
  String description;
  Author author;
  Group group;
  Group page;

  factory SharePostPost.fromJson(Map<String, dynamic> json) => SharePostPost(
        id: json["id"],
        description: json["description"],
        author: Author.fromJson(json["author"]),
        group: Group.fromJson(json["group"]),
        page: Group.fromJson(json["page"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "author": author.toJson(),
        "group": group == null ? null : group.toJson(),
        "page": page == null ? null : page.toJson(),
      };
}

class Group {
  Group({
    required this.id,
    required this.name,
    required this.category,
    required this.coverPhoto,
    required this.isPrivate,
    required this.avatar,
  });

  int id;
  String name;
  String category;
  String coverPhoto;
  bool isPrivate;
  String avatar;

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
