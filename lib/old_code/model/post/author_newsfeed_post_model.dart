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

  NewsfeedModels.fromJson(dynamic json) {
    id = json['id'];
    description = json['description'];
    author = json['author'] != null ? Author.fromJson(json['author']) : null;
    totalImage = json['total_image'];
    if (json['images'] != null) {
      images = [];
      json['images'].forEach((v) {
        images?.add(Images.fromJson(v));
      });
    }
    totalVideo = json['total_video'];
    if (json['videos'] != null) {
      videos = [];
      json['videos'].forEach((v) {
        videos?.add(Videos.fromJson(v));
      });
    }
    totalComment = json['total_comment'];
    if (json['comments'] != null) {
      comments = [];
      json['comments'].forEach((v) {
        comments?.add(Comments.fromJson(v));
      });
    }
    totalLike = json['total_like'];
    if (json['liked_by'] != null) {
      likedBy = [];
      json['liked_by'].forEach((v) {
        likedBy?.add(LikedBy.fromJson(v));
      });
    }
    timestamp = json['timestamp'];
    isShare = json['is_share'];
    postType = json['post_type'];
    like = json['like'];
    sharePost = json['share_post'] != null ? SharePost.fromJson(json['share_post']) : null;
  }

  num? id;
  String? description;
  Author? author;
  num? totalImage;
  List<Images>? images;
  num? totalVideo;
  List<Videos>? videos;
  num? totalComment;
  List<Comments>? comments;
  num? totalLike;
  List<LikedBy>? likedBy;
  String? timestamp;
  bool? isShare;
  String? postType;
  bool? like;
  SharePost? sharePost;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['description'] = description;
    if (author != null) {
      map['author'] = author?.toJson();
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
    if (comments != null) {
      map['comments'] = comments?.map((v) => v.toJson()).toList();
    }
    map['total_like'] = totalLike;
    if (likedBy != null) {
      map['liked_by'] = likedBy?.map((v) => v.toJson()).toList();
    }
    map['timestamp'] = timestamp;
    map['is_share'] = isShare;
    map['post_type'] = postType;
    map['like'] = like;
    if (sharePost != null) {
      map['share_post'] = sharePost?.toJson();
    }
    return map;
  }
}

class SharePost {
  SharePost({
    this.post,
    this.postUrl,
    this.shareFrom,
    this.timestamp,
  });

  SharePost.fromJson(dynamic json) {
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

  Post.fromJson(dynamic json) {
    id = json['id'];
    description = json['description'];
    author = json['author'] != null ? Author.fromJson(json['author']) : null;
    totalImage = json['total_image'];
    if (json['images'] != null) {
      images = [];
      json['images'].forEach((v) {
        images?.add(Images.fromJson(v));
      });
    }
    totalVideo = json['total_video'];
    if (json['videos'] != null) {
      videos = [];
      json['videos'].forEach((v) {
        videos?.add(Videos.fromJson(v));
      });
    }
  }

  num? id;
  String? description;
  Author? author;
  num? totalImage;
  List<Images>? images;
  num? totalVideo;
  List<Videos>? videos;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['description'] = description;
    if (author != null) {
      map['author'] = author?.toJson();
    }
    map['total_image'] = totalImage;
    if (images != null) {
      map['images'] = images?.map((v) => v.toJson()).toList();
    }
    map['total_video'] = totalVideo;
    if (videos != null) {
      map['videos'] = videos?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Videos {
  Videos({
    this.id,
    this.thumbnail,
    this.video,
  });

  Videos.fromJson(dynamic json) {
    id = json['id'];
    thumbnail = json['thumbnail'];
    video = json['video'];
  }

  num? id;
  String? thumbnail;
  String? video;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['thumbnail'] = thumbnail;
    map['video'] = video;
    return map;
  }
}

class Images {
  Images({
    this.id,
    this.image,
  });

  Images.fromJson(dynamic json) {
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

class LikedBy {
  LikedBy({
    this.id,
    this.fullName,
    this.profileImage,
  });

  LikedBy.fromJson(dynamic json) {
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

class Comments {
  Comments({
    this.id,
    this.comment,
    this.post,
    this.author,
    this.replies,
  });

  Comments.fromJson(dynamic json) {
    id = json['id'];
    comment = json['comment'];
    post = json['post'];
    author = json['author'] != null ? Author.fromJson(json['author']) : null;
    if (json['replies'] != null) {
      replies = [];
      // json['replies'].forEach((v) {
      //   replies?.add(Dynamic.fromJson(v));
      // });
    }
  }

  num? id;
  String? comment;
  num? post;
  Author? author;
  List<dynamic>? replies;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['comment'] = comment;
    map['post'] = post;
    if (author != null) {
      map['author'] = author?.toJson();
    }
    if (replies != null) {
      map['replies'] = replies?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}



