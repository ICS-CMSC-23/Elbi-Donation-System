import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/donation_model.dart';

class FirebaseUsersAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getAllUsers() {
    return db.collection("users").snapshots();
  }

  Stream<QuerySnapshot> getUserByEmail(String email) {
    return db.collection("users").where("email", isEqualTo: email).snapshots();
  }

  Future<DocumentSnapshot> getUserById(String id) {
    return db.collection('users').doc(id).get();
  }

  Future<String> updateUser(String id, Map<String, dynamic> updatedData) async {
    try {
      await db.collection("users").doc(id).update(updatedData);
      return "Successfully updated user!";
    } on FirebaseException catch (e) {
      return "Failed to update user: ${e.message}";
    }
  }

  Future<String> deleteUser(String id) async {
    try {
      await db.collection("users").doc(id).delete();
      return "Successfully deleted user!";
    } on FirebaseException catch (e) {
      return "Failed to delete user: ${e.message}";
    }
  }
}
