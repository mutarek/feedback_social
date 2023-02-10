class NewsFeedModel {
  NewsFeedModel({
    this.id,
    this.newsfeedID,
    this.description,
    this.author,
    this.totalImage,
    this.images,
    this.totalVideo,
    this.videos,
    this.totalComment,
    this.commentUrl,
    this.isShare,
    this.postType,
    this.timestamp,
    this.sharedByUrl,
    this.totalShared,
    this.totalReaction,
    this.totalLiked,
    this.totalLoved,
    this.totalSad,
    this.loveReactUrl,
    this.allReactUserUrl,
    this.likeReactUrl,
    this.sadReactUrl,
    this.postHideUrl,
    this.copyUrl,
    this.reaction,
  });

  NewsFeedModel.fromJson(dynamic json) {
    id = json['id'];
    newsfeedID = json['newsfeed_id'] ?? json['bookmark_id'] ?? 0;
    description = json['description'] ?? "";
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
        videos?.add(VideosData.fromJson(v));
      });
    }
    totalComment = json['total_comment'];
    commentUrl = json['comment_url'];
    isShare = json['is_share'];
    postType = json['post_type'];
    timestamp = json['timestamp'];
    sharedByUrl = json['shared_by_url'];
    totalShared = json['total_shared'];
    totalReaction = json['total_reaction'];
    totalLiked = json['total_liked'];
    totalLoved = json['total_loved'];
    totalSad = json['total_sad'];
    loveReactUrl = json['love_react_user_url'];
    likeReactUrl = json['like_react_user_url'];
    sadReactUrl = json['sad_react_user_url'];
    allReactUserUrl = json['all_react_user_url'];
    postHideUrl = json['post_hide_url'];
    copyUrl = json['copy_url'];
    reaction = json['reaction'] ?? -1;
    sharePost = json['share_post'] != null ? SharePost.fromJson(json['share_post']) : SharePost();
    groupModel = json['group'] != null ? GroupModel.fromJson(json['group']) : GroupModel();
    pageModel = json['page'] != null ? PageModel.fromJson(json['page']) : PageModel();
  }

  num? id;
  num? newsfeedID;
  String? description;
  Author? author;
  num? totalImage;
  List<ImagesData>? images;
  num? totalVideo;
  List<VideosData>? videos;
  num? totalComment;
  String? commentUrl;
  bool? isShare;
  String? postType;
  String? timestamp;
  String? sharedByUrl;
  num? totalShared;
  num? totalReaction;
  num? totalLiked;
  num? totalLoved;
  num? totalSad;
  String? loveReactUrl;
  String? likeReactUrl;
  String? sadReactUrl;
  String? allReactUserUrl;
  String? copyUrl;
  String? postHideUrl;
  int? reaction;
  SharePost? sharePost;
  GroupModel? groupModel;
  PageModel? pageModel;

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
    map['comment_url'] = commentUrl;
    map['is_share'] = isShare;
    map['post_type'] = postType;
    map['timestamp'] = timestamp;
    map['shared_by_url'] = sharedByUrl;
    map['total_shared'] = totalShared;
    map['total_reaction'] = totalReaction;
    map['total_liked'] = totalLiked;
    map['total_loved'] = totalLoved;
    map['total_sad'] = totalSad;
    map['love_react_url'] = loveReactUrl;
    map['like_react_url'] = likeReactUrl;
    map['sad_react_url'] = sadReactUrl;
    map['all_react_user_url'] = allReactUserUrl;
    map['reaction'] = reaction;
    return map;
  }
}

class VideosData {
  VideosData({
    this.id,
    this.thumbnail,
    this.video,
  });

  VideosData.fromJson(dynamic json) {
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

class ImagesData {
  ImagesData({
    this.id,
    this.image,
    this.totalComment,
    this.totalShare,
    this.commentUrl,
    this.sharedByUrl,
    this.totalReaction,
    this.totalLiked,
    this.totalLoved,
    this.totalSad,
    this.loveReactUrl,
    this.likeReactUrl,
    this.sadReactUrl,
    this.allReactUserUrl,
    this.reaction,
  });

  ImagesData.fromJson(dynamic json) {
    id = json['id'];
    image = json['image'];
    totalComment = json['total_comment'];
    totalShare = json['total_share'];
    commentUrl = json['comment_url'];
    sharedByUrl = json['shared_by_url'];
    totalReaction = json['total_reaction'];
    totalLiked = json['total_liked'];
    totalLoved = json['total_loved'];
    totalSad = json['total_sad'];
    loveReactUrl = json['love_react_user_url'];
    likeReactUrl = json['like_react_user_url'];
    sadReactUrl = json['sad_react_user_url'];
    allReactUserUrl = json['all_react_user_url'];
    reaction = json['reaction'] ?? -1;
  }

  num? id;
  String? image;
  num? totalComment;
  num? totalShare;
  String? commentUrl;
  String? sharedByUrl;
  num? totalReaction;
  num? totalLiked;
  num? totalLoved;
  num? totalSad;
  String? loveReactUrl;
  String? likeReactUrl;
  String? sadReactUrl;
  String? allReactUserUrl;
  int? reaction;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['image'] = image;
    map['total_comment'] = totalComment;
    map['total_share'] = totalShare;
    map['comment_url'] = commentUrl;
    map['shared_by_url'] = sharedByUrl;
    map['total_reaction'] = totalReaction;
    map['total_liked'] = totalLiked;
    map['total_loved'] = totalLoved;
    map['total_sad'] = totalSad;
    map['love_react_url'] = loveReactUrl;
    map['like_react_url'] = likeReactUrl;
    map['sad_react_url'] = sadReactUrl;
    map['all_react_user_url'] = allReactUserUrl;
    map['reaction'] = reaction;
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
    totalImage = json['total_image'] ?? 0;
    if (json['images'] != null) {
      images = [];
      json['images'].forEach((v) {
        images?.add(ImagesData.fromJson(v));
      });
    } else {
      images = [];
    }
    totalVideo = json['total_video'] ?? 0;
    if (json['videos'] != null) {
      videos = [];
      json['videos'].forEach((v) {
        videos?.add(VideosData.fromJson(v));
      });
    } else {
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
  List<VideosData>? videos;

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
  PageModel({this.id, this.name, this.avatar});

  PageModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    avatar = json['avatar'] ?? "";
  }

  num? id;
  String? name;
  String? avatar;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['avatar'] = avatar;
    return map;
  }
}

class ImagesVideoModel {
  final List<ImagesData>? imagesData;
  final List<VideosData>? videosData;

  ImagesVideoModel({this.imagesData, this.videosData});
}
