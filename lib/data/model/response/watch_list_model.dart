class WatchListModel{
  num? watch_id;
  String? header_text;
  num? actor;
  String? action_time;
  String? thumbnail;
  String? video;

  WatchListModel({this.watch_id, this.header_text, this.actor, this.action_time,
      this.thumbnail, this.video});

  WatchListModel.fromJson(dynamic json){
    watch_id = json["watch_id"];
    header_text = json["header_text"];
    actor = json["actor"];
    action_time = json["action_time"];
    thumbnail = json["thumbnail"]??"";
    video = json["video"]??"";
  }
}