class CommentModels {
  CommentModels({this.id, this.comment, this.post, this.author, this.timestamp, this.replies});

  CommentModels.fromJson(dynamic json) {
    id = json['id'];
    comment = json['comment'];
    post = json['post'];
    author = json['author'] != null ? Author.fromJson(json['author']) : null;
    timestamp = json['timestamp']??DateTime.now().toString();
    if (json['replies'] != null) {
      replies = [];
      json['replies'].forEach((v) {
        replies?.add(Replies.fromJson(v));
      });
    }
  }

  num? id;
  String? comment;
  num? post;
  Author? author;
  String? timestamp;
  List<Replies>? replies;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['comment'] = comment;
    map['post'] = post;
    if (author != null) {
      map['author'] = author?.toJson();
    }
    map['timestamp'] = timestamp;
    if (replies != null) {
      map['replies'] = replies?.map((v) => v.toJson()).toList();
    }
    return map;
  }
}

class Replies {
  Replies({this.id, this.comment, this.parent, this.post, this.author});

  Replies.fromJson(dynamic json) {
    id = json['id'];
    comment = json['comment'];
    parent = json['parent'];
    post = json['post'];
    author = json['author'] != null ? Author.fromJson(json['author']) : null;
  }

  num? id;
  String? comment;
  num? parent;
  num? post;
  Author? author;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['comment'] = comment;
    map['parent'] = parent;
    map['post'] = post;
    if (author != null) {
      map['author'] = author?.toJson();
    }
    return map;
  }
}

class Author {
  Author({this.id, this.fullName, this.profileImage});

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
