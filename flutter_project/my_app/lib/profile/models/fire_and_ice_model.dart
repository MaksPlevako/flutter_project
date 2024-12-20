class FireAndIceModel {
  int fire;
  int ice;
  String userUID;

  FireAndIceModel(
      {required this.fire, required this.ice, required this.userUID});

// Convert a User object into a Map
  Map<String, dynamic> toMap() {
    return {
      'fire': fire,
      'ice': ice,
    };
  }

// Create a User object from a Map
  factory FireAndIceModel.fromMap(Map<String, dynamic> map) {
    return FireAndIceModel(
      fire: map['fire'] ?? 0,
      ice: map['ice'] ?? 0,
      userUID: map['userUID'] ?? '',
    );
  }
}
