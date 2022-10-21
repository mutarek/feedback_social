// To parse this JSON data, do
//
//     final notificationModel = notificationModelFromJson(jsonString);

import 'dart:convert';

OldNotificationModel notificationModelFromJson(String str) => OldNotificationModel.fromJson(json.decode(str));

String notificationModelToJson(OldNotificationModel data) => json.encode(data.toJson());

class OldNotificationModel {
  OldNotificationModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  int? count;
  String? next;
  dynamic previous;
  List<OldResult>? results;

  factory OldNotificationModel.fromJson(Map<String, dynamic> json) => OldNotificationModel(
        count: json["count"],
        next: json["next"],
        previous: json["previous"],
        results: List<OldResult>.from(json["results"].map((x) => OldResult.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "count": count,
        "next": next,
        "previous": previous,
        "results": List<dynamic>.from(results!.map((x) => x.toJson())),
      };
}

class OldResult {
  OldResult({
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
  OldActor? actor;
  String? noticeType;
  String? url;
  String? verb;
  String? description;
  bool? deleted;
  bool? emailed;
  bool? isRead;
  String? timestamp;

  factory OldResult.fromJson(Map<String, dynamic> json) => OldResult(
        id: json["id"],
        actor: OldActor.fromJson(json["actor"]),
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

class OldActor {
  OldActor({
    this.id,
    this.fullName,
    this.profileImage,
  });

  int? id;
  String? fullName;
  String? profileImage;

  factory OldActor.fromJson(Map<String, dynamic> json) => OldActor(
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
