class AuthorGroupDetailsModel {
  AuthorGroupDetailsModel({
    this.id,
    this.name,
    this.category,
    this.coverPhoto,
    this.isPrivate,
    this.avatar,
    this.postApprovedByAdmin,
    this.creator,
    this.totalMember,
    this.members,
    this.posts,
    this.photos,
    this.videos,
    this.isMember,
  });

  AuthorGroupDetailsModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    category = json['category'];
    coverPhoto = json['cover_photo']??"";
    isPrivate = json['is_private'];
    avatar = json['avatar'];
    postApprovedByAdmin = json['post_approved_by_admin'];
    creator = json['creator'] != null ? Creator.fromJson(json['creator']) : null;
    totalMember = json['total_member'];
    if (json['members'] != null) {
      members = [];
      json['members'].forEach((v) {
        members?.add(Members.fromJson(v));
      });
    }
    if (json['posts'] != null) {
      posts = [];
      json['posts'].forEach((v) {
        posts?.add(Posts.fromJson(v));
      });
    }
    if (json['photos'] != null) {
      photos = [];
      json['photos'].forEach((v) {
        photos?.add(Photos.fromJson(v));
      });
    }
    if (json['videos'] != null) {
      videos = [];
      json['videos'].forEach((v) {
        videos?.add(Videos.fromJson(v));
      });
    }
    isMember = json['is_member'];
  }

  num? id;
  String? name;
  String? category;
  String? coverPhoto;
  bool? isPrivate;
  String? avatar;
  bool? postApprovedByAdmin;
  Creator? creator;
  num? totalMember;
  List<Members>? members;
  List<Posts>? posts;
  List<Photos>? photos;
  List<Videos>? videos;
  bool? isMember;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['category'] = category;
    map['cover_photo'] = coverPhoto;
    map['is_private'] = isPrivate;
    map['avatar'] = avatar;
    map['post_approved_by_admin'] = postApprovedByAdmin;
    if (creator != null) {
      map['creator'] = creator?.toJson();
    }
    map['total_member'] = totalMember;
    if (members != null) {
      map['members'] = members?.map((v) => v.toJson()).toList();
    }
    if (posts != null) {
      map['posts'] = posts?.map((v) => v.toJson()).toList();
    }
    if (photos != null) {
      map['photos'] = photos?.map((v) => v.toJson()).toList();
    }
    if (videos != null) {
      map['videos'] = videos?.map((v) => v.toJson()).toList();
    }
    map['is_member'] = isMember;
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

class Posts {
  Posts({
    this.id,
    this.description,
    this.author,
    this.group,
    this.isApprove,
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
  });

  Posts.fromJson(dynamic json) {
    id = json['id'];
    description = json['description'];
    author = json['author'] != null ? Author.fromJson(json['author']) : null;
    group = json['group'] != null ? Group.fromJson(json['group']) : null;
    isApprove = json['is_approve'];
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
        likedBy?.add(LikedByGroup.fromJson(v));
      });
    }
    timestamp = json['timestamp'];
    isShare = json['is_share'];
    postType = json['post_type'];
    like = json['like'];
  }

  num? id;
  String? description;
  Author? author;
  Group? group;
  bool? isApprove;
  num? totalImage;
  List<Images>? images;
  num? totalVideo;
  List<dynamic>? videos;
  num? totalComment;
  List<Comments>? comments;
  num? totalLike;
  List<LikedByGroup>? likedBy;
  String? timestamp;
  bool? isShare;
  String? postType;
  bool? like;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['description'] = description;
    if (author != null) {
      map['author'] = author?.toJson();
    }
    if (group != null) {
      map['group'] = group?.toJson();
    }
    map['is_approve'] = isApprove;
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
      json['replies'].forEach((v) {
        replies?.add(Reply.fromJson(v));
      });
    }
  }

  num? id;
  String? comment;
  num? post;
  Author? author;
  List<Reply>? replies;

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

class Group {
  Group({
    this.id,
    this.name,
    this.category,
    this.coverPhoto,
    this.isPrivate,
  });

  Group.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    category = json['category'].toString();
    coverPhoto = json['cover_photo']??"";
    isPrivate = json['is_private']??false;
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

class Members {
  Members({
    this.id,
    this.group,
    this.member,
    this.memberStatus,
    this.isJoined,
    this.isBlocked,
    this.createdAt,
    this.friend,
  });

  Members.fromJson(dynamic json) {
    id = json['id'];
    group = json['group'];
    member = json['member'] != null ? Member.fromJson(json['member']) : null;
    memberStatus = json['member_status'];
    isJoined = json['is_joined'];
    isBlocked = json['is_blocked'];
    createdAt = json['created_at'];
    friend = json['friend'];
  }

  num? id;
  num? group;
  Member? member;
  String? memberStatus;
  bool? isJoined;
  bool? isBlocked;
  String? createdAt;
  bool? friend;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['group'] = group;
    if (member != null) {
      map['member'] = member?.toJson();
    }
    map['member_status'] = memberStatus;
    map['is_joined'] = isJoined;
    map['is_blocked'] = isBlocked;
    map['created_at'] = createdAt;
    map['friend'] = friend;
    return map;
  }
}

class Member {
  Member({
    this.id,
    this.fullName,
    this.profileImage,
  });

  Member.fromJson(dynamic json) {
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

class Creator {
  Creator({
    this.id,
    this.fullName,
    this.profileImage,
  });

  Creator.fromJson(dynamic json) {
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

class LikedByGroup {
  LikedByGroup({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.isActive,
    required this.profileImage,
  });

  int id;
  String firstName;
  String lastName;
  bool isActive;
  String profileImage;

  factory LikedByGroup.fromJson(Map<String, dynamic> json) => LikedByGroup(
        id: json["id"] ?? 0,
        firstName: json["first_name"] ?? "",
        lastName: json["last_name"] ?? '',
        isActive: json["is_active"] ?? false,
        profileImage: json["profile_image"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "is_active": isActive,
        "profile_image": profileImage,
      };
}

class Reply {
  Reply({
    required this.id,
    required this.comment,
    required this.parent,
    required this.post,
    required this.author,
    required this.replies,
  });

  int id;
  String comment;
  int parent;
  int post;
  LikedByGroup author;
  List<dynamic> replies;

  factory Reply.fromJson(Map<String, dynamic> json) => Reply(
        id: json["id"],
        comment: json["comment"],
        parent: json["parent"],
        post: json["post"],
        author: LikedByGroup.fromJson(json["author"]),
        replies: List<dynamic>.from(json["replies"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "comment": comment,
        "parent": parent,
        "post": post,
        "author": author.toJson(),
        "replies": List<dynamic>.from(replies.map((x) => x)),
      };
}

class Video {
  Video({
    required this.id,
    required this.thumbnail,
    required this.video,
  });

  int id;
  String thumbnail;
  String video;

  factory Video.fromJson(Map<String, dynamic> json) => Video(
        id: json["id"],
        thumbnail: json["thumbnail"],
        video: json["video"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "thumbnail": thumbnail,
        "video": video,
      };
}
