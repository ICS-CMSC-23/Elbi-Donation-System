import 'package:elbi_donation_system/api/firebase_users_api.dart';
import 'package:elbi_donation_system/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../api/firebase_donation_api.dart';
import '../models/donation_model.dart';

class UserProvider with ChangeNotifier {
  late FirebaseUsersAPI firebaseService;
  late Stream<QuerySnapshot> _userStream;
  User? _selectedUser;

  UserProvider() {
    firebaseService = FirebaseUsersAPI();
    fetchUsers();
  }

  // getters
  Stream<QuerySnapshot> get users => _userStream;
  User get selected => _selectedUser!;

  changeSelectedUser(User user) {
    _selectedUser = user;
    notifyListeners();
  }

  void fetchUsers() {
    _userStream = firebaseService.getAllUsers();
    notifyListeners();
  }

  Future<void> fetchUserById(String id) async {
    try {
      DocumentSnapshot doc = await firebaseService.getUserById(id);
      if (doc.exists) {
        _selectedUser = User.fromJson(doc.data() as Map<String, dynamic>);
        notifyListeners();
      } else {
        print("No user found with the given ID");
      }
    } catch (e) {
      print("Failed to fetch user by ID: $e");
    }
  }

  void fetchUserByEmail(String email) {
    _userStream = firebaseService.getUserByEmail(email);
    notifyListeners();
  }

  void updateUser(User user) async {
    if (_selectedUser != null) {
      try {
        String message =
            await firebaseService.updateUser(user.id!, user.toJson());
        print(message);
        notifyListeners();
      } on FirebaseException catch (e) {
        print("Failed to update user: ${e.message}");
      }
    } else {
      print("No user selected for update");
    }
  }

  void deleteUser() async {
    if (_selectedUser != null && _selectedUser!.id != null) {
      try {
        String message = await firebaseService.deleteUser(_selectedUser!.id!);
        print(message);
        notifyListeners();
      } on FirebaseException catch (e) {
        print("Failed to delete user: ${e.message}");
      }
    } else {
      print("No user selected for deletion");
    }
  }
}
