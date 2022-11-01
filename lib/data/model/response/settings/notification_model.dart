class NotificationSettingsModel {
  NotificationSettingsModel({
      this.isPush, 
      this.isFriend, 
      this.isFollower, 
      this.isFollowing, 
      this.isLike, 
      this.isComment, 
      this.isShare,});

  NotificationSettingsModel.fromJson(dynamic json) {
    isPush = json['is_push'];
    isFriend = json['is_friend'];
    isFollower = json['is_follower'];
    isFollowing = json['is_following'];
    isLike = json['is_like'];
    isComment = json['is_comment'];
    isShare = json['is_share'];
  }
  bool? isPush;
  bool? isFriend;
  bool? isFollower;
  bool? isFollowing;
  bool? isLike;
  bool? isComment;
  bool? isShare;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['is_push'] = isPush;
    map['is_friend'] = isFriend;
    map['is_follower'] = isFollower;
    map['is_following'] = isFollowing;
    map['is_like'] = isLike;
    map['is_comment'] = isComment;
    map['is_share'] = isShare;
    return map;
  }

}