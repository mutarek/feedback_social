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
  String? next;
  dynamic previous;
  List<Result>? results;

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results:
            List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class Result {
  Result({
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
  bool? isRead;
  String? timestamp;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
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
    this.fullName,
    this.profileImage,
  });

  int? id;
  String? fullName;
  String? profileImage;

  factory Actor.fromJson(Map<String, dynamic> json) => Actor(
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
