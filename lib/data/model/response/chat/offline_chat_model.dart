class OfflineChat{
  final String message;

  OfflineChat({required this.message});

  factory OfflineChat.fromJson(Map<String,dynamic> json){
    return OfflineChat(message:json['message']);
  }
  static Map<String,dynamic> toMap(OfflineChat offlineChat) => {
    "message" : offlineChat.message
  };
}