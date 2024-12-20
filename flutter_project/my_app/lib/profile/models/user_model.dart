class UserModel {
  String id;
  String name;
  String email;
  String? img;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    String?
        img, // img может быть null, но если не передан, установим значение по умолчанию
  }) : img = img ??
            'https://cdn-icons-png.flaticon.com/512/147/147144.png'; // значениe по умолчанию

// Convert a User object into a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'img': img,
    };
  }

// Create a User object from a Map
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      img:
          map['img'] ?? 'https://cdn-icons-png.flaticon.com/512/147/147144.png',
    );
  }
}
