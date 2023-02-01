class AuthorPageModel {
  AuthorPageModel({this.id, this.name, this.coverPhoto, this.avatar, this.followers});

  AuthorPageModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    coverPhoto = json['cover_photo'];
    avatar = json['avatar'];
    followers = json['followers'];
  }

  num? id;
  String? name;
  String? coverPhoto;
  String? avatar;
  num? followers;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['cover_photo'] = coverPhoto;
    map['avatar'] = avatar;
    map['followers'] = followers;
    return map;
  }
}
