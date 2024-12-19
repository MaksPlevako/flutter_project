import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:my_app/profile/models/user_model.dart';

class UserService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  // Create a new User
  Future<void> createUser(UserModel user) async {
    try {
      await _db.collection('users').add(user.toMap());
      print("User created");
    } catch (e) {
      print("Error adding user: $e");
    }
  }

  // Read a User by Email
  Future<UserModel?> getUser(String email) async {
    DocumentSnapshot snapshot = await _db.collection('users').doc(email).get();
    if (snapshot.exists) {
      return UserModel.fromMap(snapshot.data() as Map<String, dynamic>);
    }
    return null;
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
