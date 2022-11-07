class SuggestFriendRequestModel {
  SuggestFriendRequestModel({
    this.id,
    this.fromUser,
    this.timestamp,});

  SuggestFriendRequestModel.fromJson(dynamic json) {
    id = json['id'];
    fromUser = json['from_user'] != null ? FromUser.fromJson(json['from_user']) : null;
    timestamp = json['timestamp'];
  }
  num? id;
  FromUser? fromUser;
  String? timestamp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    if (fromUser != null) {
      map['from_user'] = fromUser?.toJson();
    }
    map['timestamp'] = timestamp;
    return map;
  }

}

class FromUser {
  FromUser({
    this.id,
    this.firstName,
    this.lastName,
    this.profileImage,});

  FromUser.fromJson(dynamic json) {
    id = json['id'];
    firstName = json['first_name'];
    lastName = json['last_name'];
    profileImage = json['profile_image'];
  }
  num? id;
  String? firstName;
  String? lastName;
  String? profileImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['first_name'] = firstName;
    map['last_name'] = lastName;
    map['profile_image'] = profileImage;
    return map;
  }

}