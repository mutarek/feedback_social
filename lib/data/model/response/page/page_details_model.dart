// To parse this JSON data, do
//
//     final pageDetailsModel = pageDetailsModelFromJson(jsonString);

import 'dart:convert';

import '../news_feed_model.dart';

PageDetailsModel pageDetailsModelFromJson(String str) => PageDetailsModel.fromJson(json.decode(str));

String pageDetailsModelToJson(PageDetailsModel data) => json.encode(data.toJson());

class PageDetailsModel {
  PageDetailsModel({
    required this.id,
    required this.name,
    required this.bio,
    required this.description,
    required this.category,
    required this.contact,
    required this.email,
    required this.website,
    required this.city,
    required this.address,
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
  String bio;
  String description;
  String category;
  String contact;
  String email;
  String website;
  String city;
  String address;
  String coverPhoto;
  String avatar;
  DateTime createdAt;
  Author author;
  String photos;
  String videos;
  String posts;
  bool like;
  int totalLike;
  String likedBy;

  factory PageDetailsModel.fromJson(Map<String, dynamic> json) => PageDetailsModel(
    id: json["id"],
    name: json["name"],
    bio: json["bio"],
    description: json["description"],
    category: json["category"],
    contact: json["contact"],
    email: json["email"],
    website: json["website"],
    city: json["city"],
    address: json["address"],
    coverPhoto: json["cover_photo"],
    avatar: json["avatar"],
    createdAt: DateTime.parse(json["created_at"]),
    author: Author.fromJson(json["author"]),
    photos: json["photos"],
    videos: json["videos"],
    posts: json["posts"],
    like: json["like"],
    totalLike: json["total_like"],
    likedBy: json["liked_by"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "bio": bio,
    "description": description,
    "category": category,
    "contact": contact,
    "email": email,
    "website": website,
    "city": city,
    "address": address,
    "cover_photo": coverPhoto,
    "avatar": avatar,
    "created_at": createdAt.toIso8601String(),
    "author": author.toJson(),
    "photos": photos,
    "videos": videos,
    "posts": posts,
    "like": like,
    "total_like": totalLike,
    "liked_by": likedBy,
  };
}
