class OfflineChat {
  String? userId;
  String? roomID;
  String? message;
  int? index;

  OfflineChat({this.userId, this.roomID, this.message,this.index});

  OfflineChat.fromJson(dynamic json) {
    userId = json['userid'];
    roomID = json['roomid'];
    message = json['message'];
    index = json['index'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['userid'] = userId;
    map['roomid'] = roomID;
    map['message'] = message;
    map['index'] = index;
    return map;
  }
}
