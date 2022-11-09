
class FriendModel {
  FriendModel({
    this.id,
    this.full_name,

    this.profileImage,
  });

  FriendModel.fromJson(dynamic json) {
    id = json['id'];
    full_name = json['full_name'];

    profileImage = json['profile_image'];
  }

  num? id;
  String? full_name;
  String? profileImage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['full_name'] = full_name;
    map['profile_image'] = profileImage;
    return map;
  }
}
