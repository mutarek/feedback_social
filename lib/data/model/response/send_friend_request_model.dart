class SendFriendRequestModel {
  SendFriendRequestModel({this.id, this.toUser, this.timestamp});

  SendFriendRequestModel.fromJson(dynamic json) {
    id = json['id'];
    toUser = json['to_user'] != null ? ToUser.fromJson(json['to_user']) : null;
    timestamp = json['timestamp'];
  }

  num? id;
  ToUser? toUser;
  String? timestamp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    if (toUser != null) {
      map['to_user'] = toUser?.toJson();
    }
    map['timestamp'] = timestamp;
    return map;
  }
}

class ToUser {
  ToUser({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.profileImage,
  });

  ToUser.fromJson(dynamic json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    email = json['email'];
    profileImage = json['profile_image'];
  }

  num? id;
  String? firstName;
  String? lastName;
  String? email;
  String? profileImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    map['email'] = email;
    map['profile_image'] = profileImage;
    return map;
  }
}
