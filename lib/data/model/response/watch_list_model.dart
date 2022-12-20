class WatchListModel {
  WatchListModel({
    this.watchId,
    this.postId,
    this.headerText,
    this.createdAt,
    this.thumbnail,
    this.video,
    this.user,
    this.group,
    this.page,
    this.totalComment,
    this.commentUrl,
    this.totalLiked,
    this.likedByUrl,
    this.totalShared,
    this.sharedByUrl,
    this.isLiked,
    this.isGroup = false,
    this.isPage = false,
  });

  WatchListModel.fromJson(dynamic json) {
    watchId = json['watch_id'];
    postId = json['post_id'];
    headerText = json['header_text'];
    createdAt = json['created_at'];
    thumbnail = json['thumbnail'];
    video = json['video'];
    user = json['user'] != null ? User.fromJson(json['user']) : User();
    group = json['group'] != null ? Group.fromJson(json['group']) : Group();
    page = json['page'] != null ? Page.fromJson(json['page']) : Page();
    totalComment = json['total_comment'];
    commentUrl = json['comment_url'];
    isGroup = json['comment_url'].toString().startsWith('/posts/group/');
    isPage = json['comment_url'].toString().startsWith('/posts/page/');
    totalLiked = json['total_liked'];
    likedByUrl = json['liked_by_url'];
    totalShared = json['total_shared'];
    sharedByUrl = json['shared_by_url'];
    isLiked = json['is_liked'];
  }

  num? watchId;
  num? postId;
  String? headerText;
  String? createdAt;
  String? thumbnail;
  String? video;
  User? user;
  Group? group;
  Page? page;
  num? totalComment;
  String? commentUrl;
  num? totalLiked;
  String? likedByUrl;
  num? totalShared;
  String? sharedByUrl;
  bool? isLiked;
  bool? isGroup;
  bool? isPage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['watch_id'] = watchId;
    map['post_id'] = postId;
    map['header_text'] = headerText;
    map['created_at'] = createdAt;
    map['thumbnail'] = thumbnail;
    map['video'] = video;
    if (user != null) {
      map['user'] = user?.toJson();
    }
    if (group != null) {
      map['group'] = group?.toJson();
    }
    if (page != null) {
      map['page'] = page?.toJson();
    }
    map['total_comment'] = totalComment;
    map['comment_url'] = commentUrl;
    map['total_liked'] = totalLiked;
    map['liked_by_url'] = likedByUrl;
    map['total_shared'] = totalShared;
    map['shared_by_url'] = sharedByUrl;
    map['is_liked'] = isLiked;
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

class Group {
  Group({
    this.id,
    this.name,
    this.coverPhoto,
  });

  Group.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    coverPhoto = json['cover_photo'];
  }

  num? id;
  String? name;
  String? coverPhoto;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['cover_photo'] = coverPhoto;
    return map;
  }
}

class User {
  User({
    this.id,
    this.fullName,
    this.profileImage,
  });

  User.fromJson(dynamic json) {
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
