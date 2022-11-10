
class FollowersModel {
  FollowersModel.FollowersModel({
    this.id,
    this.full_name,
    this.is_friend,
    this.profileImage,
  });

  FollowersModel.fromJson(dynamic json) {
    id = json['id'];
    full_name = json['full_name'];
    is_friend = json['is_friend'];
    profileImage = json['profile_image'];
  }

  num? id;
  String? full_name;
  String? profileImage;
  bool? is_friend;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['full_name'] = full_name;
    map['is_friend'] = is_friend;
    map['profile_image'] = profileImage;
    return map;
  }
}
