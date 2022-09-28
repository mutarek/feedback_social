// To parse required this JSON data, do
//
//     final authorGroupDetailsModel = authorGroupDetailsModelFromJson(jsonString);

import 'dart:convert';

AuthorGroupDetailsModel authorGroupDetailsModelFromJson(String str) =>
    AuthorGroupDetailsModel.fromJson(json.decode(str));

String authorGroupDetailsModelToJson(AuthorGroupDetailsModel data) =>
    json.encode(data.toJson());

class AuthorGroupDetailsModel {
  AuthorGroupDetailsModel({
    required this.id,
    required this.name,
    required this.category,
    this.coverPhoto,
    required this.isPrivate,
    required this.avatar,
    required this.postApprovedByAdmin,
    required this.creator,
    required this.totalMember,
    required this.members,
    required this.posts,
    required this.photos,
    required this.videos,
    required this.isMember,
  });

  int id;
  String name;
  String category;
  String? coverPhoto;
  bool isPrivate;
  String avatar;
  bool postApprovedByAdmin;
  Creator creator;
  int totalMember;
  List<Member> members;
  List<Post> posts;
  List<Photo> photos;
  List<Video> videos;
  bool isMember;

  factory AuthorGroupDetailsModel.fromJson(Map<String, dynamic> json) =>
      AuthorGroupDetailsModel(
        id: json["id"],
        name: json["name"],
        category: json["category"],
        coverPhoto: json["cover_photo"],
        isPrivate: json["is_private"],
        avatar: json["avatar"],
        postApprovedByAdmin: json["post_approved_by_admin"],
        creator: Creator.fromJson(json["creator"]),
        totalMember: json["total_member"],
        members:
            List<Member>.from(json["members"].map((x) => Member.fromJson(x))),
        posts: List<Post>.from(json["posts"].map((x) => Post.fromJson(x))),
        photos: List<Photo>.from(json["photos"].map((x) => Photo.fromJson(x))),
        videos: List<Video>.from(json["videos"].map((x) => Video.fromJson(x))),
        isMember: json["is_member"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "category": category,
        "cover_photo": coverPhoto,
        "is_private": isPrivate,
        "avatar": avatar,
        "post_approved_by_admin": postApprovedByAdmin,
        "creator": creator.toJson(),
        "total_member": totalMember,
        "members": List<dynamic>.from(members.map((x) => x.toJson())),
        "posts": List<dynamic>.from(posts.map((x) => x.toJson())),
        "photos": List<dynamic>.from(photos.map((x) => x.toJson())),
        "videos": List<dynamic>.from(videos.map((x) => x.toJson())),
        "is_member": isMember,
      };
}

class Creator {
  Creator({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.gender,
    required this.isActive,
    required this.profileImage,
  });

  int id;
  String firstName;
  String lastName;

  dynamic dateOfBirth;
  String gender;
  bool isActive;
  String profileImage;

  factory Creator.fromJson(Map<String, dynamic> json) => Creator(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        dateOfBirth: json["date_of_birth"],
        gender: json["gender"],
        isActive: json["is_active"],
        profileImage: json["profile_image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "date_of_birth": dateOfBirth,
        "gender": gender,
        "is_active": isActive,
        "profile_image": profileImage,
      };
}

class Member {
  Member({
    required this.id,
    required this.group,
    required this.member,
    required this.memberStatus,
    required this.isJoined,
    required this.isBlocked,
    required this.createdAt,
    required this.friend,
  });

  int id;
  int group;
  Creator member;
  String memberStatus;
  bool isJoined;
  bool isBlocked;
  String createdAt;
  bool friend;

  factory Member.fromJson(Map<String, dynamic> json) => Member(
        id: json["id"],
        group: json["group"],
        member: Creator.fromJson(json["member"]),
        memberStatus: json["member_status"],
        isJoined: json["is_joined"],
        isBlocked: json["is_blocked"],
        createdAt: json["created_at"],
        friend: json["friend"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "group": group,
        "member": member.toJson(),
        "member_status": memberStatus,
        "is_joined": isJoined,
        "is_blocked": isBlocked,
        "created_at": createdAt,
        "friend": friend,
      };
}

class Photo {
  Photo({
    required this.id,
    required this.image,
  });

  int id;
  String image;

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
        id: json["id"],
        image: json["image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "image": image,
      };
}

class Post {
  Post({
    required this.id,
    required this.description,
    required this.author,
    required this.group,
    required this.isApprove,
    required this.totalImage,
    required this.images,
    required this.totalVideo,
    required this.videos,
    required this.totalComment,
    required this.comments,
    required this.totalLike,
    required this.likedBy,
    required this.timestamp,
    required this.isShare,
    required this.postType,
    required this.like,
  });

  int id;
  String description;
  Author author;
  Group group;
  bool isApprove;
  int totalImage;
  List<Photo> images;
  int totalVideo;
  List<Video> videos;
  int totalComment;
  List<dynamic> comments;
  int totalLike;
  List<dynamic> likedBy;
  String timestamp;
  bool isShare;
  String postType;
  bool like;

  factory Post.fromJson(Map<String, dynamic> json) => Post(
        id: json["id"],
        description: json["description"],
        author: Author.fromJson(json["author"]),
        group: Group.fromJson(json["group"]),
        isApprove: json["is_approve"],
        totalImage: json["total_image"],
        images: List<Photo>.from(json["images"].map((x) => Photo.fromJson(x))),
        totalVideo: json["total_video"],
        videos: List<Video>.from(json["videos"].map((x) => Video.fromJson(x))),
        totalComment: json["total_comment"],
        comments: List<dynamic>.from(json["comments"].map((x) => x)),
        totalLike: json["total_like"],
        likedBy: List<dynamic>.from(json["liked_by"].map((x) => x)),
        timestamp: json["timestamp"],
        isShare: json["is_share"],
        postType: json["post_type"],
        like: json["like"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "description": description,
        "author": author.toJson(),
        "group": group.toJson(),
        "is_approve": isApprove,
        "total_image": totalImage,
        "images": List<dynamic>.from(images.map((x) => x.toJson())),
        "total_video": totalVideo,
        "videos": List<dynamic>.from(videos.map((x) => x.toJson())),
        "total_comment": totalComment,
        "comments": List<dynamic>.from(comments.map((x) => x)),
        "total_like": totalLike,
        "liked_by": List<dynamic>.from(likedBy.map((x) => x)),
        "timestamp": timestamp,
        "is_share": isShare,
        "post_type": postType,
        "like": like,
      };
}

class Author {
  Author({
    required this.id,
    required this.fullName,
    required this.profileImage,
  });

  int id;
  String fullName;
  String profileImage;

  factory Author.fromJson(Map<String, dynamic> json) => Author(
        id: json["id"],
        fullName: json["full_name"],
        profileImage: json["profile_image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "full_name": fullName,
        "profile_image": profileImage,
      };
}

class Group {
  Group({
    required this.id,
    required this.name,
    required this.category,
    required this.coverPhoto,
    required this.isPrivate,
  });

  int id;
  String name;
  String category;
  String coverPhoto;
  bool isPrivate;

  factory Group.fromJson(Map<String, dynamic> json) => Group(
        id: json["id"],
        name: json["name"],
        category: json["category"],
        coverPhoto: json["cover_photo"],
        isPrivate: json["is_private"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "category": category,
        "cover_photo": coverPhoto,
        "is_private": isPrivate,
      };
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
