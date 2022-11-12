
class FriendModel {
  FriendModel({
    this.id,
    this.fullName,

    this.profileImage,
  });

  FriendModel.fromJson(dynamic json) {
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
