class GroupDetailsModel {
  GroupDetailsModel({
    this.id,
    this.name,
    this.bio,
    this.description,
    this.category,
    this.coverPhoto,
    this.isPrivate,
    this.city,
    this.address,
    this.postApprovedByAdmin,
    this.creator,
    this.totalMember,
    this.members,
    this.posts,
    this.photos,
    this.videos,
    this.copyUrl,
    this.isMember,
  });

  GroupDetailsModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    bio = json['bio'];
    description = json['description'];
    category = json['category'];
    coverPhoto = json['cover_photo'];
    isPrivate = json['is_private'];
    city = json['city'];
    address = json['address'];
    postApprovedByAdmin = json['post_approved_by_admin'];
    creator = json['creator'] != null ? Creator.fromJson(json['creator']) : Creator();
    totalMember = json['total_member'];
    members = json['members'];
    posts = json['posts'];
    photos = json['photos'];
    videos = json['videos'];
    copyUrl = json['copy_url'];
    isMember = json['is_member'];
  }

  num? id;
  String? name;
  String? bio;
  String? description;
  String? category;
  String? coverPhoto;
  bool? isPrivate;
  String? city;
  String? address;
  bool? postApprovedByAdmin;
  Creator? creator;
  num? totalMember;
  String? members;
  String? posts;
  String? photos;
  String? videos;
  String? copyUrl;
  bool? isMember;

}

class Creator {
  Creator({this.id, this.fullName, this.profileImage});

  Creator.fromJson(dynamic json) {
    id = json['id'];
    fullName = json['full_name'];
    profileImage = json['profile_image'];
  }

  num? id;
  String? fullName;
  String? profileImage;
}
