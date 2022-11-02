// To parse required this JSON data, do
//
//     final groupMembersModel = groupMembersModelFromJson(jsonString);

import 'dart:convert';

List<GroupMembersModel> groupMembersModelFromJson(String str) =>
    List<GroupMembersModel>.from(json.decode(str).map((x) => GroupMembersModel.fromJson(x)));

String groupMembersModelToJson(List<GroupMembersModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class GroupMembersModel {
  GroupMembersModel({
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
  Member member;
  String memberStatus;
  bool isJoined;
  bool isBlocked;
  String createdAt;
  bool friend;

  factory GroupMembersModel.fromJson(Map<String, dynamic> json) => GroupMembersModel(
        id: json["id"],
        group: json["group"],
        member: Member.fromJson(json["member"]),
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

class Member {
  Member({
    required this.id,
    required this.fullName,
    required this.profileImage,
  });

  int id;
  String fullName;
  String profileImage;

  factory Member.fromJson(Map<String, dynamic> json) => Member(
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
