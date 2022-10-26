// To parse this JSON data, do
//
//     final blockListModel = blockListModelFromJson(jsonString);

import 'dart:convert';

BlockListModel blockListModelFromJson(String str) => BlockListModel.fromJson(json.decode(str));

String blockListModelToJson(BlockListModel data) => json.encode(data.toJson());

class BlockListModel {
  BlockListModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  int? count;
  dynamic next;
  dynamic previous;
  List<Result>? results;

  factory BlockListModel.fromJson(Map<String, dynamic> json) => BlockListModel(
    count: json["count"],
    next: json["next"],
    previous: json["previous"],
    results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "next": next,
    "previous": previous,
    "results": List<dynamic>.from(results!.map((x) => x.toJson())),
  };
}

class Result {
  Result({
   required this.id,
    required this.fullName,
    required this.profileImage,
  });

  int id;
  String? fullName;
  String? profileImage;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    fullName: json["full_name"],
    profileImage: json["profile_image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "full_name": fullName,
    "profile_image": profileImage,
  };
}
