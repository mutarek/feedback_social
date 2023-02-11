class GroupPolicyModel{
  num?id;
  String?title;
  String?description;

  GroupPolicyModel({this.id, this.title, this.description});

  GroupPolicyModel.fromJson(dynamic json){
    id = json['id'];
    title = json['title'];
    description = json['description'];
  }
}