// To parse this JSON data, do
//
//     final userProfileModel = userProfileModelFromJson(jsonString);

import 'dart:convert';

UserProfileModel userProfileModelFromJson(String str) =>
    UserProfileModel.fromJson(json.decode(str));

String userProfileModelToJson(UserProfileModel data) =>
    json.encode(data.toJson());

class UserProfileModel {
  UserProfileModel({
    this.id,
    this.livesInAddress,
    this.fromAddress,
    this.religion,
    this.profileImage,
    this.coverImage,
    this.isLocked,
    this.user,
    this.firstName,
    this.lastName,
    this.gender,
    this.presentCompany,
    this.previousCompany,
    this.presentEducation,
    this.previousEducation,
    this.following,
    this.followers,
    this.friends,
    this.isFriend,
    this.friendRequestSent,
    this.friendRequestAccept,
    this.friendRequestSentId,
    this.friendRquestAcceptId,
  });

  int? id;
  String? livesInAddress;
  String? fromAddress;
  String? religion;
  String? profileImage;
  String? coverImage;
  bool? isLocked;
  int? user;
  String? firstName;
  String? lastName;
  String? gender;
  String? presentCompany;
  List<dynamic>? previousCompany;
  String? presentEducation;
  List<dynamic>? previousEducation;
  List<dynamic>? following;
  List<dynamic>? followers;
  List<Friend>? friends;
  bool? isFriend;
  bool? friendRequestSent;
  bool? friendRequestAccept;
  int? friendRequestSentId;
  int? friendRquestAcceptId;

  factory UserProfileModel.fromJson(Map<String, dynamic> json) =>
      UserProfileModel(
        id: json["id"],
        livesInAddress: json["lives_in_address"],
        fromAddress: json["from_address"],
        religion: json["religion"],
        profileImage: json["profile_image"],
        coverImage: json["cover_image"],
        isLocked: json["is_locked"],
        user: json["user"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        gender: json["gender"],
        presentCompany: json["present_company"],
        previousCompany:
            List<dynamic>.from(json["previous_company"].map((x) => x)),
        presentEducation: json["present_education"],
        previousEducation:
            List<dynamic>.from(json["previous_education"].map((x) => x)),
        following: List<dynamic>.from(json["following"].map((x) => x)),
        followers: List<dynamic>.from(json["followers"].map((x) => x)),
        friends:
            List<Friend>.from(json["friends"].map((x) => Friend.fromJson(x))),
        isFriend: json["is_friend"],
        friendRequestSent: json["friend_request_sent"],
        friendRequestAccept: json["friend_request_accept"],
        friendRequestSentId: json["friend_request_sent_id"],
        friendRquestAcceptId: json["friend_request_accept_id"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "lives_in_address": livesInAddress,
        "from_address": fromAddress,
        "religion": religion,
        "profile_image": profileImage,
        "cover_image": coverImage,
        "is_locked": isLocked,
        "user": user,
        "first_name": firstName,
        "last_name": lastName,
        "gender": gender,
        "present_company": presentCompany,
        "previous_company": List<dynamic>.from(previousCompany!.map((x) => x)),
        "present_education": presentEducation,
        "previous_education":
            List<dynamic>.from(previousEducation!.map((x) => x)),
        "following": List<dynamic>.from(following!.map((x) => x)),
        "followers": List<dynamic>.from(followers!.map((x) => x)),
        "friends": List<dynamic>.from(friends!.map((x) => x.toJson())),
        "is_friend": isFriend,
        "friend_request_sent": friendRequestSent,
        "friend_request_accept": friendRequestAccept,
        "friend_request_sent_id": friendRequestSentId,
        "friend_request_accept_id": friendRequestSentId
      };
}

class Friend {
  Friend({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.dateOfBirth,
    this.gender,
    this.isActive,
    this.code,
    this.profileImage,
  });

  int? id;
  String? firstName;
  String? lastName;
  String? email;
  dynamic dateOfBirth;
  String? gender;
  bool? isActive;
  String? code;
  String? profileImage;

  factory Friend.fromJson(Map<String, dynamic> json) => Friend(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        dateOfBirth: json["date_of_birth"],
        gender: json["gender"],
        isActive: json["is_active"],
        code: json["code"],
        profileImage: json["profile_image"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "first_name": firstName,
        "last_name": lastName,
        "email": email,
        "date_of_birth": dateOfBirth,
        "gender": gender,
        "is_active": isActive,
        "code": code,
        "profile_image": profileImage,
      };
}
