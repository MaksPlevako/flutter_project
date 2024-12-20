class MorningRoutineModel {
  String id;
  bool? checkbox;
  String title;
  int hour;
  int minute;
  String user;

  MorningRoutineModel({
    required this.id,
    this.checkbox,
    required this.title,
    required this.hour,
    required this.minute,
    required this.user,
  });

  // Convert a MorningRoutine object into a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'checkbox': checkbox,
      'title': title,
      'hour': hour,
      'minute': minute,
      'user': user,
    };
  }

  // Create a MorningRoutine object from a Map
  factory MorningRoutineModel.fromMap(Map<String, dynamic> map) {
    return MorningRoutineModel(
      id: map['id'] ?? '',
      checkbox: map['checkbox'] ?? false,
      title: map['title'] ?? '',
      hour: map['hour'] ?? 0,
      minute: map['minute'] ?? 0,
      user: map['user'] ?? '',
    );
  }
}
