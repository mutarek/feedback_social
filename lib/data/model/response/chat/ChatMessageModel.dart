class ChatMessageModel {
  ChatMessageModel({
    this.id,
    this.text,
    this.timestamp,
    this.isDelivered,
    this.isSeen,
    this.user,
  });

  ChatMessageModel.fromJson(dynamic json) {
    id = json['id'];
    text = json['text'];
    timestamp = json['timestamp'];
    isDelivered = json['is_delivered'];
    isSeen = json['is_seen'];
    user = json['user'].toString();
  }

  num? id;
  String? text;
  String? timestamp;
  bool? isDelivered;
  bool? isSeen;
  String? user;

  ChatMessageModel copyWith({
    num? id,
    String? text,
    String? timestamp,
    bool? isDelivered,
    bool? isSeen,
    String? user,
  }) =>
      ChatMessageModel(
        id: id ?? this.id,
        text: text ?? this.text,
        timestamp: timestamp ?? this.timestamp,
        isDelivered: isDelivered ?? this.isDelivered,
        isSeen: isSeen ?? this.isSeen,
        user: user ?? this.user,
      );

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['text'] = text;
    map['timestamp'] = timestamp;
    map['is_delivered'] = isDelivered;
    map['is_seen'] = isSeen;
    map['user'] = user;
    return map;
  }
}
