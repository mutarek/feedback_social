// To parse this JSON data, do
//
//     final newsfeedModel = newsfeedModelFromJson(jsonString);

import 'dart:convert';

NewsfeedModel newsfeedModelFromJson(String str) => NewsfeedModel.fromJson(json.decode(str));

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
  List<NewsFeedData>? results;

  factory NewsfeedModel.fromJson(Map<String, dynamic> json) => NewsfeedModel(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: List<NewsFeedData>.from(json["results"].map((x) => NewsFeedData.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class NewsFeedData {
  NewsFeedData({
    this.newsfeedId,
    this.isDelete,
    this.id,
    this.description,
    this.author,
    this.page,
    this.totalImage,
    this.images,
    this.totalVideo,
    this.videos,
    this.totalComment,
    this.commentUrl,
    this.totalLike,
    this.likedBy,
    this.timestamp,
    this.isShare,
    this.sharePost,
    this.postType,
    this.like,
  });

  NewsFeedData.fromJson(dynamic json) {
    newsfeedId = json['newsfeed_id'] ?? 0;
    isDelete = json['is_delete'] ?? false;
    id = json['id'];
    description = json['description'];
    author = json['author'] != null ? Author.fromJson(json['author']) : null;
    page = json['page'] != null ? Page.fromJson(json['page']) : null;
    if (json.containsKey('share_post')) {
      sharePost = json['share_post'] != null ? SharePostModel.fromJson(json['share_post']) : null;
    } else {
      sharePost = SharePostModel();
    }
    totalImage = json['total_image'];
    if (json['images'] != null) {
      images = [];
      json['images'].forEach((v) {
        images?.add(ImagesData.fromJson(v));
      });
    }
    totalVideo = json['total_video'];
    if (json['videos'] != null || json['videos'].isNotEmpty) {
      videos = [];
      json['videos'].forEach((v) {
        videos?.add(Video.fromJson(v));
      });
    } else {
      videos = [];
    }
    totalComment = json['total_comment'];
    commentUrl = json['comment_url'];
    totalLike = json['total_like'];
    if (json['liked_by'] != null || json['liked_by'].isNotEmpty) {
      likedBy = [];
      json['liked_by'].forEach((v) {
        likedBy?.add(LikedBy.fromJson(v));
      });
    } else {
      likedBy = [];
    }
    timestamp = json['timestamp'];
    isShare = json['is_share'];
    postType = json['post_type'];
    like = json['like'];
  }

  int? newsfeedId;
  bool? isDelete;
  int? id;
  String? description;
  Author? author;
  Page? page;
  SharePostModel? sharePost;
  int? totalImage;
  List<ImagesData>? images;
  int? totalVideo;
  List<Video>? videos;
  int? totalComment;
  String? commentUrl;
  int? totalLike;
  List<LikedBy>? likedBy;
  String? timestamp;
  bool? isShare;
  String? postType;
  bool? like;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['newsfeed_id'] = newsfeedId;
    map['is_delete'] = isDelete;
    map['id'] = id;
    map['description'] = description;
    if (author != null) {
      map['author'] = author?.toJson();
    }
    if (page != null) {
      map['page'] = page?.toJson();
    }
    map['total_image'] = totalImage;
    if (images != null) {
      map['images'] = images?.map((v) => v.toJson()).toList();
    }
    map['total_video'] = totalVideo;
    if (videos != null) {
      map['videos'] = videos?.map((v) => v.toJson()).toList();
    }
    map['total_comment'] = totalComment;
    map['comment_url'] = commentUrl;
    map['total_like'] = totalLike;
    if (likedBy != null) {
      map['liked_by'] = likedBy?.map((v) => v.toJson()).toList();
    }
    map['timestamp'] = timestamp;
    map['is_share'] = isShare;
    map['post_type'] = postType;
    map['like'] = like;
    return map;
  }
}

class ImagesData {
  ImagesData({
    this.id,
    this.image,
  });

  ImagesData.fromJson(dynamic json) {
    id = json['id'];
    image = json['image'];
  }

  num? id;
  String? image;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['image'] = image;
    return map;
  }
}

class Page {
  Page({
    this.id,
    this.name,
    this.category,
    this.coverPhoto,
    this.avatar,
  });

  Page.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    category = json['category'].toString();
    coverPhoto = json['cover_photo'];
    avatar = json['avatar'];
  }

  num? id;
  String? name;
  String? category;
  String? coverPhoto;
  String? avatar;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['category'] = category;
    map['cover_photo'] = coverPhoto;
    map['avatar'] = avatar;
    return map;
  }
}

class Author {
  Author({
    this.id,
    this.fullName,
    this.profileImage,
  });

  Author.fromJson(dynamic json) {
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
      thumbnail: json["thumbnail"] ?? "https://www.thejungleadventure.com/assets/images/logo/novideo.png");

  Map<String, dynamic> toJson() => {"id": id, "video": video, "thumbnail": thumbnail};
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
        dateOfBirth: json["date_of_birth"] == null ? null : DateTime.parse(json["date_of_birth"]),
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
        category: json["category"].toString(),
        coverPhoto: json["cover_photo"],
        isPrivate: json["is_private"] ?? false,
        avatar: json["avatar"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "category": category,
        "cover_photo": coverPhoto,
        "is_private": isPrivate ?? null,
        "avatar": avatar ?? null,
      };
}

class ImageData {
  ImageData({
    this.id,
    this.image,
  });

  int? id;
  String? image;

  factory ImageData.fromJson(Map<String, dynamic> json) => ImageData(
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
  List<ImagesData>? images;
  int? totalVideo;
  List<Video>? videos;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["id"],
        description: json["description"] ?? "",
        author: Author.fromJson(json["author"]),
        totalImage: json["total_image"],
        images: List<ImagesData>.from(json["images"].map((x) => ImagesData.fromJson(x))),
        totalVideo: json["total_video"],
        videos: List<Video>.from(json["videos"].map((x) => x)),
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

class SharePostModel {
  SharePostModel({
    this.post,
    this.postUrl,
    this.shareFrom,
    this.timestamp,
  });

  SharePostModel.fromJson(dynamic json) {
    post = json['post'] != null ? Post.fromJson(json['post']) : null;
    postUrl = json['post_url'];
    shareFrom = json['share_from'];
    timestamp = json['timestamp'];
  }

  Post? post;
  String? postUrl;
  String? shareFrom;
  String? timestamp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (post != null) {
      map['post'] = post?.toJson();
    }
    map['post_url'] = postUrl;
    map['share_from'] = shareFrom;
    map['timestamp'] = timestamp;
    return map;
  }
}
