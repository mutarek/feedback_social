class IndividualPageDetailsModel{
  num? id;
  String? name;
  String? bio;
  String? description;
  String? category;
  String? contact;
  String? email;
  String? website;
  String? city;
  String? address;

  IndividualPageDetailsModel({
      this.id, this.name, this.bio, this.description, this.category, this.contact, this.email, this.website, this.city, this.address});

  IndividualPageDetailsModel.fromJson(dynamic json){
    id= json["id"];
    name= json["name"];
    bio= json["bio"];
    description= json["description"];
    category= json["category"];
    contact= json["contact"];
    email= json["email"];
    website= json["website"];
    city= json["city"];
    address= json["address"];
  }
}