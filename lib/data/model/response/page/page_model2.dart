class PageModel2 {
  num? id;
  PageResponse? page;

  PageModel2({this.id, this.page});

  PageModel2.fromJson(dynamic json) {
    id = json['id'];
    page = json['page'] != null ? PageResponse.fromJson(json['page']) : null;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    if (page != null) {
      map['page'] = page?.toJson();
    }
    return map;
  }
}

class PageResponse {
  PageResponse({this.id, this.name, this.avatar});

  PageResponse.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    avatar = json['avatar'] ?? "";
  }

  num? id;
  String? name;
  String? avatar;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['avatar'] = avatar;
    return map;
  }
}
