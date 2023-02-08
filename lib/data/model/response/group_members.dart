import 'package:als_frontend/data/model/response/group/author_group_details_model.dart';

class GroupMembers {
  num? id;
  num? group;
  Member? member;
  String? memberStatus;
  bool? isJoined;
  bool? isBlocked;
  String? createdAt;
  bool? friend;

  GroupMembers({this.id, this.group, this.member, this.memberStatus, this.isJoined, this.isBlocked, this.createdAt, this.friend});

  GroupMembers.fromJson(dynamic json) {
    id = json['id'];
    group = json['group'];
    member = json["member"] == null ? null : Member.fromJson(json["member"]);
    memberStatus = json["member_status"];
    isJoined = json["is_joined"];
    isBlocked = json["is_blocked"];
    createdAt = json["created_at"];
    friend = json["friend"];
  }
}
