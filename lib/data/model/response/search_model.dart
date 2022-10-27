class SearchModel {
  SearchModel({
    this.people,
    this.posts,
    this.groups,
    this.pages,
  });

  SearchModel.fromJson(dynamic json) {
    if (json['people'] != null) {
      people = [];
      json['people'].forEach((v) {
        people?.add(People.fromJson(v));
      });
    }
    if (json['posts'] != null) {
      posts = [];
      json['posts'].forEach((v) {
        posts?.add(Posts.fromJson(v));
      });
    }
    if (json['groups'] != null) {
      groups = [];
      json['groups'].forEach((v) {
        groups?.add(Groups.fromJson(v));
      });
    }
    if (json['pages'] != null) {
      pages = [];
      json['pages'].forEach((v) {
        pages?.add(Pages.fromJson(v));
      });
    }
  }

  List<People>? people;
  List<Posts>? posts;
  List<Groups>? groups;
  List<Pages>? pages;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (people != null) {
      map['people'] = people?.map((v) => v.toJson()).toList();
    }
    if (posts != null) {
      map['posts'] = posts?.map((v) => v.toJson()).toList();
    }
    if (groups != null) {
      map['groups'] = groups?.map((v) => v.toJson()).toList();
    }
    if (pages != null) {
      map['pages'] = pages?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Pages {
  Pages({
    this.id,
    this.name,
    this.category,
    this.coverPhoto,
    this.avatar,
    this.isAuthor,
  });

  Pages.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    category = json['category'];
    coverPhoto = json['cover_photo'];
    avatar = json['avatar'];
    isAuthor = json['is_author'];
  }

  num? id;
  String? name;
  String? category;
  String? coverPhoto;
  String? avatar;
  bool? isAuthor;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['category'] = category;
    map['cover_photo'] = coverPhoto;
    map['avatar'] = avatar;
    map['is_author'] = isAuthor;
    return map;
  }
}

class Groups {
  Groups({
    this.id,
    this.name,
    this.category,
    this.coverPhoto,
    this.isPrivate,
    this.isAuthor,
  });

  Groups.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    category = json['category'];
    coverPhoto = json['cover_photo'];
    isPrivate = json['is_private'];
    isAuthor = json['is_author'];
  }

  num? id;
  String? name;
  String? category;
  String? coverPhoto;
  bool? isPrivate;
  bool? isAuthor;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['category'] = category;
    map['cover_photo'] = coverPhoto;
    map['is_private'] = isPrivate;
    map['is_author'] = isAuthor;
    return map;
  }
}

class Posts {
  Posts({
    this.newsfeedId,
    this.isDelete,
    this.id,
    this.description,
    this.author,
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
    this.like,
  });

  Posts.fromJson(dynamic json) {
    newsfeedId = json['newsfeed_id'];
    isDelete = json['is_delete'];
    id = json['id'];
    description = json['description'];
    author = json['author'] != null ? Author.fromJson(json['author']) : null;
    totalImage = json['total_image'];
    if (json['images'] != null) {
      images = [];
      // json['images'].forEach((v) {
      //   images?.add(Dynamic.fromJson(v));
      // });
    }
    totalVideo = json['total_video'];
    if (json['videos'] != null) {
      videos = [];
      // json['videos'].forEach((v) {
      //   videos?.add(Dynamic.fromJson(v));
      // });
    }
    totalComment = json['total_comment'];
    commentUrl = json['comment_url'];
    totalLike = json['total_like'];
    if (json['liked_by'] != null) {
      likedBy = [];
      // json['liked_by'].forEach((v) {
      //   likedBy?.add(Dynamic.fromJson(v));
      // });
    }
    timestamp = json['timestamp'];
    isShare = json['is_share'];
    postType = json['post_type'];
    like = json['like'];
  }

  num? newsfeedId;
  bool? isDelete;
  num? id;
  String? description;
  Author? author;
  num? totalImage;
  List<dynamic>? images;
  num? totalVideo;
  List<dynamic>? videos;
  num? totalComment;
  String? commentUrl;
  num? totalLike;
  List<dynamic>? likedBy;
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

class People {
  People({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.profileImage,
  });

  People.fromJson(dynamic json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    profileImage = json['profile_image'];
  }

  num? id;
  String? firstName;
  String? lastName;
  String? email;
  String? profileImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    map['email'] = email;
    map['profile_image'] = profileImage;
    return map;
  }
}
