
class FollowersModel {
  FollowersModel({
    this.id,
    this.fullName,
    this.isFriend,
    this.profileImage,
  });

  FollowersModel.fromJson(dynamic json) {
    id = json['id'];
    fullName = json['full_name'];
    isFriend = json['is_friend'];
    profileImage = json['profile_image'];
  }

  num? id;
  String? fullName;
  String? profileImage;
  bool? isFriend;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['full_name'] = fullName;
    map['is_friend'] = isFriend;
    map['profile_image'] = profileImage;
    return map;
  }
}
