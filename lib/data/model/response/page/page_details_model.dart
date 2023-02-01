import '../news_feed_model.dart';

class PageDetailsModel {
  PageDetailsModel({
    this.id,
    this.name,
    this.bio,
    this.description,
    this.category,
    this.contact,
    this.email,
    this.website,
    this.city,
    this.address,
    this.coverPhoto,
    this.avatar,
    this.createdAt,
    this.author,
    this.photos,
    this.videos,
    this.posts,
    this.isLiked,
    this.totalLike,
    this.likedUserUrl,
    this.isFollowed,
    this.totalFollower,
    this.followerUrl,});

  PageDetailsModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    bio = json['bio'];
    description = json['description'];
    category = json['category'];
    contact = json['contact'];
    email = json['email'];
    website = json['website'];
    city = json['city'];
    address = json['address'];
    coverPhoto = json['cover_photo'];
    avatar = json['avatar'];
    createdAt = json['created_at'];
    author = json['author'] != null ? Author.fromJson(json['author']) : null;
    photos = json['photos'];
    videos = json['videos'];
    posts = json['posts'];
    isLiked = json['is_liked'];
    totalLike = json['total_like'];
    likedUserUrl = json['liked_user_url'];
    isFollowed = json['is_followed'];
    totalFollower = json['total_follower'];
    followerUrl = json['follower_url'];
  }
  num? id;
  String? name;
  String? bio;
  String? description;
  String? category;
  String? contact;
  String? email;
  String? website;
  String? city;
  String? address;
  String? coverPhoto;
  String? avatar;
  String? createdAt;
  Author? author;
  String? photos;
  String? videos;
  String? posts;
  bool? isLiked;
  num? totalLike;
  String? likedUserUrl;
  bool? isFollowed;
  num? totalFollower;
  String? followerUrl;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['bio'] = bio;
    map['description'] = description;
    map['category'] = category;
    map['contact'] = contact;
    map['email'] = email;
    map['website'] = website;
    map['city'] = city;
    map['address'] = address;
    map['cover_photo'] = coverPhoto;
    map['avatar'] = avatar;
    map['created_at'] = createdAt;
    if (author != null) {
      map['author'] = author?.toJson();
    }
    map['photos'] = photos;
    map['videos'] = videos;
    map['posts'] = posts;
    map['is_liked'] = isLiked;
    map['total_like'] = totalLike;
    map['liked_user_url'] = likedUserUrl;
    map['is_followed'] = isFollowed;
    map['total_follower'] = totalFollower;
    map['follower_url'] = followerUrl;
    return map;
  }

}
