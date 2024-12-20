import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:my_app/profile/models/user_model.dart';

class UserService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Create a new User
  Future<void> createUser(UserModel user) async {
    User? userProfile = FirebaseAuth.instance.currentUser;
    if(userProfile != null){
      try {
        String userId = userProfile.uid;
        _db.collection('fire_and_ice_streak').doc(userId);
        await _db.collection('users').doc(userId).set(user.toMap());
        print("User created");
      } catch (e) {
        print("Error adding user: $e");
      }
    }else{
      print('user not login');
    }
  }

  // Read a User by Email
  Future<UserModel?> getUserByEmail(String email) async {
    try {
      QuerySnapshot snapshot = await _db
          .collection('users')
          .where('email', isEqualTo: email)
          .limit(1)
          .get();

      if (snapshot.docs.isNotEmpty) {
        return UserModel.fromMap(
            snapshot.docs.first.data() as Map<String, dynamic>);
      }
      return null;
    } catch (e) {
      print('Error fetching user by email: $e');
      return null;
    }
  }

  // Update an existing User
  Future<void> updateUser(UserModel user) async {
    await _db.collection('users').doc(user.id).update(user.toMap());
  }

  // Delete a User
  Future<void> deleteUser(String id) async {
    await _db.collection('users').doc(id).delete();
  }
}
