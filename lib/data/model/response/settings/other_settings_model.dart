class OtherSettingsModel {
  OtherSettingsModel({
      this.isAnyoneTag, 
      this.isFollowerTag, 
      this.isFollowingTag, 
      this.isAnyoneShare, 
      this.isFollowerShare, 
      this.isFollowingShare, 
      this.isAnyoneMessage, 
      this.isFollowerMessage, 
      this.isFollowingMessage,});

  OtherSettingsModel.fromJson(dynamic json) {
    isAnyoneTag = json['is_anyone_tag'];
    isFollowerTag = json['is_follower_tag'];
    isFollowingTag = json['is_following_tag'];
    isAnyoneShare = json['is_anyone_share'];
    isFollowerShare = json['is_follower_share'];
    isFollowingShare = json['is_following_share'];
    isAnyoneMessage = json['is_anyone_message'];
    isFollowerMessage = json['is_follower_message'];
    isFollowingMessage = json['is_following_message'];
  }
  bool? isAnyoneTag;
  bool? isFollowerTag;
  bool? isFollowingTag;
  bool? isAnyoneShare;
  bool? isFollowerShare;
  bool? isFollowingShare;
  bool? isAnyoneMessage;
  bool? isFollowerMessage;
  bool? isFollowingMessage;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['is_anyone_tag'] = isAnyoneTag;
    map['is_follower_tag'] = isFollowerTag;
    map['is_following_tag'] = isFollowingTag;
    map['is_anyone_share'] = isAnyoneShare;
    map['is_follower_share'] = isFollowerShare;
    map['is_following_share'] = isFollowingShare;
    map['is_anyone_message'] = isAnyoneMessage;
    map['is_follower_message'] = isFollowerMessage;
    map['is_following_message'] = isFollowingMessage;
    return map;
  }

}