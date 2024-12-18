import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/morning_routine_model.dart';

class MorningRoutineService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Create a new MorningRoutine
  Future<void> createMorningRoutine(MorningRoutineModel routine) async {
    await _db
        .collection('morning_routines')
        .doc(routine.id)
        .set(routine.toMap());
  }

  // Read a MorningRoutine by ID
  Future<MorningRoutineModel?> getMorningRoutine(String id) async {
    DocumentSnapshot snapshot =
        await _db.collection('morning_routines').doc(id).get();
    if (snapshot.exists) {
      return MorningRoutineModel.fromMap(
          snapshot.data() as Map<String, dynamic>);
    }
    return null;
  }

  // Update an existing MorningRoutine
  Future<void> updateMorningRoutine(MorningRoutineModel routine) async {
    await _db
        .collection('morning_routines')
        .doc(routine.id)
        .update(routine.toMap());
  }

  // Delete a MorningRoutine
  Future<void> deleteMorningRoutine(String id) async {
    await _db.collection('morning_routines').doc(id).delete();
  }

  // Get all MorningRoutines
  Future<List<MorningRoutineModel>> getAllMorningRoutines() async {
    QuerySnapshot snapshot = await _db.collection('morning_routines').get();
    return snapshot.docs
        .map((doc) =>
            MorningRoutineModel.fromMap(doc.data() as Map<String, dynamic>))
        .toList();
  }
}
