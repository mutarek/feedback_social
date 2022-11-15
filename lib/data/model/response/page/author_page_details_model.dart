class AuthorPageDetailsModel {
  AuthorPageDetailsModel({
    this.id,
    this.name,
    this.category,
    this.coverPhoto,
    this.avatar,
    this.createdAt,
    this.author,
    this.photos,
    this.videos,
    this.posts,
    this.like,
    this.totalLike,
    this.likedBy,
  });

  AuthorPageDetailsModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    category = json['category'];
    coverPhoto = json['cover_photo'];
    avatar = json['avatar'];
    createdAt = json['created_at'];
    author = json['author'] != null ? Author.fromJson(json['author']) : null;
    if (json['photos'] != null) {
      photos = [];
      json['photos'].forEach((v) {
        photos?.add(Photos.fromJson(v));
      });
    }
    if (json['videos'] != null) {
      videos = [];
      json['videos'].forEach((v) {
        videos?.add(Video.fromJson(v));
      });
    }
    if (json['posts'] != null) {
      posts = [];
      json['posts'].forEach((v) {
        posts?.add(Posts.fromJson(v));
      });
    }
    like = json['like'];
    totalLike = json['total_like'];
    if (json['liked_by'] != null) {
      likedBy = [];
      json['liked_by'].forEach((v) {
        likedBy?.add(LikedByPage.fromJson(v));
      });
    }
  }

  num? id;
  String? name;
  String? category;
  String? coverPhoto;
  String? avatar;
  String? createdAt;
  Author? author;
  List<Photos>? photos;
  List<Video>? videos;
  List<Posts>? posts;
  bool? like;
  num? totalLike;
  List<LikedByPage>? likedBy;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['category'] = category;
    map['cover_photo'] = coverPhoto;
    map['avatar'] = avatar;
    map['created_at'] = createdAt;
    if (author != null) {
      map['author'] = author?.toJson();
    }
    if (photos != null) {
      map['photos'] = photos?.map((v) => v.toJson()).toList();
    }
    if (videos != null) {
      map['videos'] = videos?.map((v) => v.toJson()).toList();
    }
    if (posts != null) {
      map['posts'] = posts?.map((v) => v.toJson()).toList();
    }
    map['like'] = like;
    map['total_like'] = totalLike;
    if (likedBy != null) {
      map['liked_by'] = likedBy?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Posts {
  Posts({
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
    this.postType,
  });

  Posts.fromJson(dynamic json) {
    id = json['id'];
    description = json['description'];
    author = json['author'] != null ? Author.fromJson(json['author']) : null;
    page = json['page'] != null ? Page.fromJson(json['page']) : null;
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
        videos?.add(Video.fromJson(v));
      });
    }
    totalComment = json['total_comment'];
    commentUrl = json['comment_url'];
    totalLike = json['total_like'];
    if (json['liked_by'] != null) {
      likedBy = [];
      json['liked_by'].forEach((v) {
        likedBy?.add(LikedByPage.fromJson(v));
      });
    }
    timestamp = json['timestamp'];
    isShare = json['is_share'];
    postType = json['post_type'];
  }

  num? id;
  String? description;
  Author? author;
  Page? page;
  num? totalImage;
  List<Images>? images;
  num? totalVideo;
  List<dynamic>? videos;
  num? totalComment;
  String? commentUrl;
  num? totalLike;
  List<LikedByPage>? likedBy;
  String? timestamp;
  bool? isShare;
  String? postType;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
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
    return map;
  }
}

class LikedByPage {
  LikedByPage({
    this.id,
    this.fullName,
    this.profileImage,
  });

  LikedByPage.fromJson(dynamic json) {
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
    category = json['category'];
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

class Photos {
  Photos({
    this.id,
    this.image,
  });

  Photos.fromJson(dynamic json) {
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

