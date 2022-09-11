// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

NotificationModel notificationModelFromJson(String str) =>
    NotificationModel.fromJson(json.decode(str));

String notificationModelToJson(NotificationModel data) =>
    json.encode(data.toJson());

class NotificationModel {
  NotificationModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  int? count;
  dynamic next;
  dynamic previous;
  List<Results>? results;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results:
            List<Results>.from(json["results"].map((x) => Results.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class Results {
  Results({
    this.id,
    this.actor,
    this.noticeType,
    this.url,
    this.verb,
    this.description,
    this.deleted,
    this.emailed,
    this.isRead,
    this.timestamp,
  });

  int? id;
  Actor? actor;
  String? noticeType;
  String? url;
  String? verb;
  String? description;
  bool? deleted;
  bool? emailed;
  bool?isRead;
  String? timestamp;

  factory Results.fromJson(Map<String, dynamic> json) => Results(
        id: json["id"],
        actor: Actor.fromJson(json["actor"]),
        noticeType: json["notice_type"],
        url: json["url"],
        verb: json["verb"],
        description: json["description"],
        deleted: json["deleted"],
        emailed: json["emailed"],
        isRead: json["is_read"],
        timestamp: json["timestamp"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "actor": actor!.toJson(),
        "notice_type": noticeType,
        "url": url,
        "verb": verb,
        "description": description,
        "deleted": deleted,
        "emailed": emailed,
        "is_read": isRead,
        "timestamp": timestamp,
      };
}

class Actor {
  Actor({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.dateOfBirth,
    this.gender,
    this.isActive,
    this.profileImage,
  });

  int? id;
  String? firstName;
  String? lastName;
  String? email;
  dynamic dateOfBirth;
  String? gender;
  bool? isActive;
  String? profileImage;

  factory Actor.fromJson(Map<String, dynamic> json) => Actor(
        id: json["id"],
        firstName: json["first_name"],
        lastName: json["last_name"],
        email: json["email"],
        dateOfBirth: json["date_of_birth"],
        gender: json["gender"],
        isActive: json["is_active"],
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
        "profile_image": profileImage,
      };
}
