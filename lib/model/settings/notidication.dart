import 'dart:convert';

SettingsNotificationModel notificationValueFromJson(String str) =>
    SettingsNotificationModel.fromJson(json.decode(str));

String notificationValueToJson(SettingsNotificationModel data) =>
    json.encode(data.toJson());

class SettingsNotificationModel {
  SettingsNotificationModel({
    this.isLikePost,
    this.isSharePost,
    this.isCommentPost,
    this.isFollowerAlert,
    this.isWaitingAlert,
    this.isFriendPostAlert,
    this.isMilestoneAlert,
    this.isIconWinsAward,
    this.isPointWinsAward,
  });

  bool? isLikePost;
  bool? isSharePost;
  bool? isCommentPost;
  bool? isFollowerAlert;
  bool? isWaitingAlert;
  bool? isFriendPostAlert;
  bool? isMilestoneAlert;
  bool? isIconWinsAward;
  bool? isPointWinsAward;

  factory SettingsNotificationModel.fromJson(Map<String, dynamic> json) =>
      SettingsNotificationModel(
        isLikePost: json["is_like_post"],
        isSharePost: json["is_share_post"],
        isCommentPost: json["is_comment_post"],
        isFollowerAlert: json["is_follower_alert"],
        isWaitingAlert: json["is_waiting_alert"],
        isFriendPostAlert: json["is_friend_post_alert"],
        isMilestoneAlert: json["is_milestone_alert"],
        isIconWinsAward: json["is_icon_wins_award"],
        isPointWinsAward: json["is_point_wins_award"],
      );

  Map<String, dynamic> toJson() => {
        "is_like_post": isLikePost,
        "is_share_post": isSharePost,
        "is_comment_post": isCommentPost,
        "is_follower_alert": isFollowerAlert,
        "is_waiting_alert": isWaitingAlert,
        "is_friend_post_alert": isFriendPostAlert,
        "is_milestone_alert": isMilestoneAlert,
        "is_icon_wins_award": isIconWinsAward,
        "is_point_wins_award": isPointWinsAward,
      };
}
