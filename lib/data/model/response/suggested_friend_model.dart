class SuggestFriendModel {
  SuggestFriendModel({
    this.id,
    this.firstName,
    this.lastName,
    this.profileImage,
  });

  SuggestFriendModel.fromJson(dynamic json) {
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
