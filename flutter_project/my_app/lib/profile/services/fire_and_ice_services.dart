import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_app/profile/models/fire_and_ice_model.dart';

class FireAndIceServices {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Create a new FireAndIceStreak
  Future<void> createStreak() async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      print('user active');

      String userId = user.uid;
      print(userId);

      DocumentReference userStreakRef =
      _db.collection('fire_and_ice_streak').doc(userId);

      Map<String, dynamic> streakData = {
        'fire': 0,
        'ice': 0,
        'user': userId, // Идентификатор пользователя для связи
      };

      try {
        await userStreakRef.set(streakData,
            SetOptions(merge: true)); // Добавляем или обновляем документ
        print('Streak data saved successfully');
      } catch (e) {
        print('Error saving streak data: $e');
      }
    } else {
      print('User not authenticated');
    }
  }

  // Read a Streak by User
  Future<FireAndIceModel?> getStreakByUser() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      print('user active');
      print(user);
      String userId = user.uid;
      print(userId);
      DocumentSnapshot snapshot =
      await _db.collection('fire_and_ice_streak').doc(userId).get();
      if (snapshot.exists) {
        return FireAndIceModel.fromMap(snapshot.data() as Map<String, dynamic>);
      }
      return null;
    } else {
      print('User not logged in');
      return null;
    }
  }

  // Update an existing Streak
  Future<void> updateStreak(FireAndIceModel fireAndIceStreak) async {
    await _db
        .collection('fire_and_ice_streak')
        .doc(fireAndIceStreak.userUID)
        .update(fireAndIceStreak.toMap());
  }

  // Delete a Streak
  Future<void> deleteStreak(String userUID) async {
    await _db.collection('fire_and_ice_streak').doc(userUID).delete();
  }
}
