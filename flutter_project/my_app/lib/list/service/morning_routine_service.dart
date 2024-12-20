import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../models/morning_routine_model.dart';

class MorningRoutineService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Create a new MorningRoutine
  Future<void> createMorningRoutine(MorningRoutineModel routine) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      try {
        await _db
            .collection('morning_routines')
            .doc(user.uid)
            .collection('users_morning_routine')
            .doc(routine.id)
            .set(routine.toMap());
        print("Morning routine added successfully!");
      } catch (e) {
        print("Error adding morning routine: $e");
      }
    } else {
      print('user not login');
    }
  }

  // Read a MorningRoutine by ID
  Future<MorningRoutineModel?> getMorningRoutine(
      MorningRoutineModel routine) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      DocumentSnapshot snapshot = await _db
          .collection('morning_routines')
          .doc(user.uid)
          .collection('users_morning_routine')
          .doc(routine.id)
          .get();
      if (snapshot.exists) {
        return MorningRoutineModel.fromMap(
            snapshot.data() as Map<String, dynamic>);
      }
      return null;
    }
    return null;
  }

  // Update an existing MorningRoutine
  Future<void> updateMorningRoutine(MorningRoutineModel routine) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await _db
          .collection('morning_routines')
          .doc(user.uid)
          .collection('users_morning_routine')
          .doc(routine.id)
          .update(routine.toMap());
      print('routine change checkbox');
    }
  }

  // Delete a MorningRoutine
  Future<void> deleteMorningRoutine(String id) async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await _db
          .collection('morning_routines')
          .doc(user.uid)
          .collection('users_morning_routine')
          .doc(id)
          .delete();
    }
  }

  // Get all MorningRoutines
  Future<List<MorningRoutineModel>?> getAllMorningRoutines() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      QuerySnapshot snapshot = await _db
          .collection('morning_routines')
          .doc(user.uid)
          .collection('users_morning_routine')
          .get();
      return snapshot.docs
          .map((doc) =>
              MorningRoutineModel.fromMap(doc.data() as Map<String, dynamic>))
          .toList();
    }
    return null;
  }
}
