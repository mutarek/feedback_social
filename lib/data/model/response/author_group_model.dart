import 'group/author_group_details_model.dart';

class AuthorGroupModel {
  num? id;
  String? name;
  String? coverPhoto;
  num? totalMember;
  String? visitGroupUrl;
  String? copyLinkUrl;

  AuthorGroupModel({this.id, this.name, this.coverPhoto, this.totalMember, this.visitGroupUrl, this.copyLinkUrl});

  AuthorGroupModel.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    coverPhoto = json['cover_photo'];
    totalMember = json['total_member'];
    visitGroupUrl = json['visit_group_url'];
    copyLinkUrl = json['copy_link_url'];
  }
}