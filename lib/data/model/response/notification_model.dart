class NotificationModel {
  NotificationModel({
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

  NotificationModel.fromJson(dynamic json) {
    id = json['id'];
    actor = json['actor'] != null ? Actor.fromJson(json['actor']) : null;
    noticeType = json['notice_type'];
    url = json['url'];
    verb = json['verb'];
    description = json['description'];
    deleted = json['deleted'];
    emailed = json['emailed'];
    isRead = json['is_read'];
    timestamp = json['timestamp'];
  }

  num? id;
  Actor? actor;
  String? noticeType;
  String? url;
  String? verb;
  String? description;
  bool? deleted;
  bool? emailed;
  bool? isRead;
  String? timestamp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    if (actor != null) {
      map['actor'] = actor?.toJson();
    }
    map['notice_type'] = noticeType;
    map['url'] = url;
    map['verb'] = verb;
    map['description'] = description;
    map['deleted'] = deleted;
    map['emailed'] = emailed;
    map['is_read'] = isRead;
    map['timestamp'] = timestamp;
    return map;
  }
}

class Actor {
  Actor({
    this.id,
    this.fullName,
    this.profileImage,
  });

  Actor.fromJson(dynamic json) {
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
