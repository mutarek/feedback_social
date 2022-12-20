class WatchListModel {
  num? watch_id;
  num? post_id;
  String? header_text;
  String? created_at;
  String? thumbnail;
  String? video;
  User? user;
  // Page? page;
  // Group? group;
  num? totalComment;
  String? commentUrl;
  num? totalLiked;
  String? likedByUrl;
  bool? isLiked;
  String? sharedByUrl;
  num? totalShared;

  WatchListModel(
      this.watch_id,
      this.post_id,
      this.header_text,
      this.created_at,
      this.thumbnail,
      this.video,
      this.user,
      // this.page,
      // this.group,
      this.totalComment,
      this.commentUrl,
      this.isLiked,
      this.likedByUrl,
      this.sharedByUrl,
      this.totalLiked,
      this.totalShared);

  WatchListModel.fromJson(dynamic json) {
    watch_id = json["watch_id"];
    post_id = json["post_id"];
    header_text = json["header_text"];
    created_at = json["created_at"];
    thumbnail = json["thumbnail"] ?? "";
    video = json["video"] ?? "";
    user = User.fromJson(json["user"] ?? "");
    // group = Group.fromJson(json["group"] ?? "");
    // page = Page.fromJson(json["page"] ?? "");
    totalComment = json["total_comment"] ?? "";
    commentUrl = json["comment_url"] ?? "";
    isLiked = json["is_liked"] ?? "";
    likedByUrl = json["liked_by_url"] ?? "";
    sharedByUrl = json["shared_by_url"] ?? "";
    totalLiked = json["total_liked"] ?? "";
    totalShared = json["total_shared"] ?? "";
  }
}

class User {
  num? id;
  String? name;
  String? profile;

  User({this.id, this.name, this.profile});

  User.fromJson(dynamic json) {
    id = json['id'];
    name = json['full_name'];
    profile = json['profile_image'];
  }
}

class Page {
  num? id;
  String? name;
  String? category;
  String? cover_photo;
  String? avatar;

  Page({this.id, this.name, this.category, this.cover_photo, this.avatar});

  Page.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    category = json['category'];
    cover_photo = json['cover_photo'];
    avatar = json['avatar'];
  }
}

class Group {
  num? id;
  String? name;
  String? coverPhoto;

  Group({this.id, this.name, this.coverPhoto});

  Group.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    coverPhoto = json['cover_photo'];
  }
}
