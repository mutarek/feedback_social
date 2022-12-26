

class UserLiveCallDetail {
  int id = 0;
  int startTime = 0;
  int? endTime;
  int? totalTime;
  int status = 0;
  String token = '';
  String channelName = '';

  UserLiveCallDetail();

  factory UserLiveCallDetail.fromJson(dynamic json) {
    UserLiveCallDetail model = UserLiveCallDetail();
    model.id = json['id'];
    model.status = json['status'];
    model.startTime = json['start_time'];
    model.endTime = json['end_time'];
    model.totalTime = json['total_time'];
    model.token = json['token'] ?? '';
    model.channelName = json['channel_name'] ?? '';

    return model;
  }
}

class GiftSummary {
  int totalGift = 0;
  int totalCoin = 0;

  GiftSummary();

  factory GiftSummary.fromJson(dynamic json) {
    GiftSummary model = GiftSummary();
    model.totalGift = json['totalGift'];
    model.totalCoin = json['totalCoin'];
    return model;
  }
}

class UserModel {
  int id = 0;

  // String? name;
  String userName = '';

  String? email = '';
  String? picture;
  String? bio = '';
  String? phone = '';
  String? country = '';
  String? countryCode = '';
  String? city = '';
  String? gender = ''; //sex : 1=male, 2=female, 3=others

  int coins = 0;
  bool? isReported = false;
  String? paypalId;
  String balance = '';
  int? isBioMetricLoginEnabled = 0;

  int commentPushNotificationStatus = 0;
  int likePushNotificationStatus = 0;

  bool isFollowing = false;
  bool isFollower = false;
  bool isVerified = false;

  bool isOnline = false;
  int? chatLastTimeOnline = 0;
  int accountCreatedWith = 0;

  int totalPost = 0;
  int totalFollowing = 0;
  int totalFollower = 0;
  int totalWinnerPost = 0;

  String? latitude;
  String? longitude;

  UserLiveCallDetail? liveCallDetail;
  GiftSummary? giftSummary;

  // next release
  int isDatingEnabled = 0;

  UserModel();

}
