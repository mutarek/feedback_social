class AllMessageChatListModel {
  AllMessageChatListModel({
    this.id,
    this.roomType,
    this.updateAt,
    this.lastSms,
    this.users,
    //this.chatGroup,
  });

  AllMessageChatListModel.fromJson(dynamic json) {
    id = json['id'];
    roomType = json['room_type'];
    updateAt = json['update_at'];
    lastSms = json['last_sms'];
    if (json['users'] != null) {
      users = [];
      json['users'].forEach((v) {
        users?.add(Users.fromJson(v));
      });
    }
    //chatGroup = json['chat_group'] != null ? ChatGroup.fromJson(json['chat_group']) : ChatGroup(name: '', avatar: '');
  }

  String? id;
  String? roomType;
  String? updateAt;
  String? lastSms;
  List<Users>? users;
  // ChatGroup? chatGroup;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['room_type'] = roomType;
    map['update_at'] = updateAt;
    map['last_sms'] = lastSms;
    if (users != null) {
      map['users'] = users?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

// class ChatGroup {
//   ChatGroup({
//     this.name,
//     this.avatar,
//   });
//
//   ChatGroup.fromJson(dynamic json) {
//     name = json['name'];
//     avatar = json['avatar'];
//   }
//
//   String? name;
//   String? avatar;
//
//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['name'] = name;
//     map['avatar'] = avatar;
//     return map;
//   }
// }

class Users {
  Users({
    this.id,
    this.fullName,
    this.profileImage,
  });

  Users.fromJson(dynamic json) {
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
