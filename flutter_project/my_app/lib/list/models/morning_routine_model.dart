class MorningRoutineModel {
  String id; // Unique identifier for the routine
  bool checkbox;
  String title; // Title of the routine
  int hour;
  int minute; // List of activities in the routine

  MorningRoutineModel({
    required this.id,
    required this.checkbox,
    required this.title,
    required this.hour,
    required this.minute,
  });

  // Convert a MorningRoutine object into a Map
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'checkbox': checkbox,
      'title': title,
      'hour': hour,
      'minute': minute,
    };
  }

  // Create a MorningRoutine object from a Map
  factory MorningRoutineModel.fromMap(Map<String, dynamic> map) {
    return MorningRoutineModel(
      id: map['id'],
      checkbox: map['checkbox'] ?? false,
      title: map['title'] ?? '',
      hour: map['hour'] ?? 0,
      minute: map['minute'] ?? 0,
    );
  }
}
