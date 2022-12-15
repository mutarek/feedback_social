class NewsFeedModel {
  NewsFeedModel({
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
    this.totalLiked,
    this.likedByUrl,
    this.isLiked,
    this.sharedByUrl,
    this.totalShared,
    this.isShare,
    this.postType,
    this.timestamp,
    this.sharePost,
  });

  NewsFeedModel.fromJson(dynamic json) {
    newsfeedId = json['newsfeed_id'];
    isDelete = json['is_delete'];
    id = json['id'];
    description = json['description']??"";
    author = json['author'] != null ? Author.fromJson(json['author']) : null;
    totalImage = json['total_image'];
    if (json['images'] != null) {
      images = [];
      json['images'].forEach((v) {
        images?.add(ImagesData.fromJson(v));
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
    commentUrl = json['comment_url'];
    totalLiked = json['total_liked'];
    likedByUrl = json['liked_by_url'];
    isLiked = json['is_liked'];
    sharedByUrl = json['shared_by_url'];
    totalShared = json['total_shared'];
    isShare = json['is_share'];
    postType = json['post_type'];
    timestamp = json['timestamp'];
    sharePost = json['share_post'] != null ? SharePost.fromJson(json['share_post']) : SharePost();
    groupModel = json['group'] != null ? GroupModel.fromJson(json['group']) : GroupModel();
    pageModel = json['page'] != null ? PageModel.fromJson(json['page']) : PageModel();
  }

  num? newsfeedId;
  bool? isDelete;
  num? id;
  String? description;
  Author? author;
  num? totalImage;
  List<ImagesData>? images;
  num? totalVideo;
  List<Videos>? videos;
  num? totalComment;
  String? commentUrl;
  num? totalLiked;
  String? likedByUrl;
  bool? isLiked;
  String? sharedByUrl;
  num? totalShared;
  bool? isShare;
  String? postType;
  String? timestamp;
  SharePost? sharePost;
  GroupModel? groupModel;
  PageModel? pageModel;

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
    map['total_liked'] = totalLiked;
    map['liked_by_url'] = likedByUrl;
    map['is_liked'] = isLiked;
    map['shared_by_url'] = sharedByUrl;
    map['total_shared'] = totalShared;
    map['is_share'] = isShare;
    map['post_type'] = postType;
    map['timestamp'] = timestamp;
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
  Post(
      {this.id,
      this.description,
      this.author,
      this.totalImage,
      this.images,
      this.totalVideo,
      this.videos,
      this.pageModel,
      this.groupModel});

  Post.fromJson(dynamic json) {
    id = json['id'];
    description = json['description'];
    author = json['author'] != null ? Author.fromJson(json['author']) : null;
    totalImage = json['total_image']??0;
    if (json['images'] != null) {
      images = [];
      json['images'].forEach((v) {
        images?.add(ImagesData.fromJson(v));
      });
    }else{
      images = [];
    }
    totalVideo = json['total_video']??0;
    if (json['videos'] != null) {
      videos = [];
      json['videos'].forEach((v) {
        videos?.add(Videos.fromJson(v));
      });
    }else{
      videos = [];
    }
    pageModel = json['page'] != null ? PageModel.fromJson(json['page']) : PageModel();
    groupModel = json['group'] != null ? GroupModel.fromJson(json['group']) : GroupModel();
  }

  num? id;
  String? description;
  Author? author;
  PageModel? pageModel;
  GroupModel? groupModel;
  num? totalImage;
  List<ImagesData>? images;
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

class GroupModel {
  GroupModel({
    this.id,
    this.name,
    this.category,
    this.coverPhoto,
    this.isPrivate,
  });

  GroupModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    category = json['category'];
    coverPhoto = json['cover_photo'];
    isPrivate = json['is_private'];
  }

  num? id;
  String? name;
  String? category;
  String? coverPhoto;
  bool? isPrivate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['category'] = category;
    map['cover_photo'] = coverPhoto;
    map['is_private'] = isPrivate;
    return map;
  }
}

class PageModel {
  PageModel({
    this.id,
    this.name,
    this.category,
    this.coverPhoto,
    this.avatar,
  });

  PageModel.fromJson(dynamic json) {
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
