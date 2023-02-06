class InvitedPageModel{
  num? id;
  Page? page;


  InvitedPageModel({this.id, this.page});

  InvitedPageModel.fromJson(dynamic json) {
    id = json['id'];
    page = json['page'] != null ? Page.fromJson(json['page']) : null;
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

class Page {
  Page({this.id, this.name, this.avatar});

  Page.fromJson(dynamic json) {
    id = json['id'];
    name = json['name'];
    avatar = json['avatar']??"";
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