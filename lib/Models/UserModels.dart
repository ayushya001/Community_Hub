class UserModel {
  UserModel({
    required this.name,
    required this.uid,
    required this.image,
  });

  late final String name;
  late final String uid;
  late final String image;

  UserModel.fromJson(Map<String, dynamic> json){
    name = json['name'] ?? '';
    uid = json['uid'] ?? '';
    image = json['image'] ?? '';
  }
}