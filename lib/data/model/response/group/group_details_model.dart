import 'package:als_frontend/data/model/response/news_feed_model.dart';

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
    this.createAt,
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
    creator = json['creator'] != null ? Author.fromJson(json['creator']) : Author();
    totalMember = json['total_member'];
    members = json['members'];
    posts = json['posts'];
    photos = json['photos'];
    videos = json['videos'];
    copyUrl = json['copy_url'];
    isMember = json['is_member'];
    createAt = json['created_at'];
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
  Author? creator;
  num? totalMember;
  String? members;
  String? posts;
  String? photos;
  String? videos;
  String? copyUrl;
  String? createAt;
  bool? isMember;

}
