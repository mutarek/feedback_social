class CommentModels {
  CommentModels({
    this.id,
    this.comment,
    this.post,
    this.author,
    this.replies,
  });

  CommentModels.fromJson(dynamic json) {
    id = json['id'];
    comment = json['comment'];
    post = json['post'];
    author = json['author'] != null ? Author.fromJson(json['author']) : null;
    if (json['replies'] != null) {
      replies = [];
    }
  }

  num? id;
  String? comment;
  num? post;
  Author? author;
  List<dynamic>? replies;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['comment'] = comment;
    map['post'] = post;
    if (author != null) {
      map['author'] = author?.toJson();
    }
    if (replies != null) {
      map['replies'] = replies?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Author {
  Author({
    this.id,
    this.fullName,
    this.profileImage,
  });

  Author.fromJson(dynamic json) {
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
