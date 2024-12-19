class UserModel {
  String? id;
  String name;
  String email;
  String? img;

  UserModel({this.id, required this.name, required this.email, this.img});

// Convert a MorningRoutine object into a Map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'img': img,
    };
  }

// Create a MorningRoutine object from a Map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'],
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      img: map['img'] ?? '',
    );
  }
}
