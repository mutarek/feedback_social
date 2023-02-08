// To parse this JSON data, do
//
//     final joinedGroupModel = joinedGroupModelFromJson(jsonString);

import 'dart:convert';

JoinedGroupModel joinedGroupModelFromJson(String str) => JoinedGroupModel.fromJson(json.decode(str));

String joinedGroupModelToJson(JoinedGroupModel data) => json.encode(data.toJson());

class JoinedGroupModel {
  JoinedGroupModel({
    required this.count,
    required this.next,
    required this.previous,
    required this.results,
  });

  int count;
  String next;
  String previous;
  List<Result> results;

  factory JoinedGroupModel.fromJson(Map<String, dynamic> json) => JoinedGroupModel(
    count: json["count"],
    next: json["next"],
    previous: json["previous"],
    results: List<Result>.from(json["results"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "count": count,
    "next": next,
    "previous": previous,
    "results": List<dynamic>.from(results.map((x) => x.toJson())),
  };
}

class Result {
  Result({
    required this.id,
    required this.name,
    required this.category,
    required this.coverPhoto,
    required this.isPrivate,
  });

  int id;
  String name;
  int category;
  String coverPhoto;
  bool isPrivate;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["id"],
    name: json["name"],
    category: json["category"],
    coverPhoto: json["cover_photo"],
    isPrivate: json["is_private"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "category": category,
    "cover_photo": coverPhoto,
    "is_private": isPrivate,
  };
}
