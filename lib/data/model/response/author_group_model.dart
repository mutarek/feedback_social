import 'group/author_group_details_model.dart';

class AuthorGroupModel {
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

  AuthorGroupModel(
      {this.id,
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
      this.copyUrl});

  AuthorGroupModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    bio = json['bio'];
    description = json['description'];
    category  = json['category'];
    coverPhoto = json['cover_photo'];
    isPrivate = json['is_private'];
    city = json['city'];
    address = json['address'];
    postApprovedByAdmin = json['post_approved_by_admin'];
    creator = Creator.fromJson(json['creator']);
    totalMember = json['total_member'];
    members = json['members'];
    posts = json['posts'];
    photos  = json['photos'];
    videos  = json['videos'];
    copyUrl = json['copy_url'];
  }
}
