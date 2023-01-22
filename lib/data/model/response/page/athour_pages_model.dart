class AuthorPageModel {
  AuthorPageModel({
    this.id,
    this.name,
    this.bio,
    this.category,
    this.contact,
    this.email,
    this.website,
    this.city,
    this.address,
    this.coverPhoto,
    this.avatar,
    this.followers,});

  AuthorPageModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    bio = json['bio'];
    category = json['category'];
    contact = json['contact'];
    email = json['email'];
    website = json['website'];
    city = json['city'];
    address = json['address'];
    coverPhoto = json['cover_photo'];
    avatar = json['avatar'];
    followers = json['followers'];
  }
  num? id;
  String? name;
  String? bio;
  String? category;
  String? contact;
  String? email;
  String? website;
  String? city;
  String? address;
  String? coverPhoto;
  String? avatar;
  num? followers;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['bio'] = bio;
    map['category'] = category;
    map['contact'] = contact;
    map['email'] = email;
    map['website'] = website;
    map['city'] = city;
    map['address'] = address;
    map['cover_photo'] = coverPhoto;
    map['avatar'] = avatar;
    map['followers'] = followers;
    return map;
  }

}