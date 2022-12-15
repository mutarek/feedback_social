
class ProfileImagesModel {
  ProfileImagesModel({required this.id, required this.image});

  int id;
  String image;

  factory ProfileImagesModel.fromJson(Map<String, dynamic> json) => ProfileImagesModel(id: json["id"], image: json["image"]);

  Map<String, dynamic> toJson() => {"id": id, "image": image};
}
