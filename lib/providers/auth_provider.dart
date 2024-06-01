import 'package:elbi_donation_system/api/firebase_users_api.dart';
import 'package:elbi_donation_system/dummy_data/dummy_users.dart';
import 'package:elbi_donation_system/models/user_model.dart' as user_model;
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import '../api/firebase_auth_api.dart';

import '../screens/admin_home_page.dart';
import '../screens/donor_home_page.dart';
import '../screens/log_in_page.dart';
import '../screens/org_home_page.dart';

class AuthProvider with ChangeNotifier {
  final List<user_model.User> _userList = dummyUsers;
  List<user_model.User> get userList => _userList;

  user_model.User _currentUser = user_model.User(
    id: '-1',
    name: 'Guest',
    username: 'guest',
    password: 'none',
    address: [],
    contactNo: 'none',
    role: 'guest',
    email: 'guest@example.com',
    profilePhoto: 'none',
    about: 'guest data',
    proofsOfLegitimacy: [],
    isApproved: false,
    isOpenForDonation: false,
  );

  Widget _homeElement = const LoginPage();

  Widget get homeElement => _homeElement;

  user_model.User get currentUser => _currentUser;

  late FirebaseAuthAPI authService;
  late FirebaseUsersAPI firebaseService;
  late Stream<firebase_auth.User?> uStream;
  firebase_auth.User? firebaseUser;

  AuthProvider() {
    authService = FirebaseAuthAPI();
    firebaseService = FirebaseUsersAPI();
    fetchAuthentication();
  }

  Stream<firebase_auth.User?> get userStream => uStream;

  void fetchAuthentication() {
    uStream = authService.getUser();
    uStream.listen((firebase_auth.User? user) {
      firebaseUser = user;
      if (firebaseUser != null) {
        _loadUserData(firebaseUser!.uid);
      } else {
        _setGuestUser();
      }
      notifyListeners();
    });
  }

  Future<void> _loadUserData(String uid) async {
    try {
      DocumentSnapshot userDoc =
          await FirebaseFirestore.instance.collection('users').doc(uid).get();
      if (userDoc.exists) {
        Map<String, dynamic> userData = userDoc.data() as Map<String, dynamic>;
        _currentUser = user_model.User(
          id: uid,
          name: userData['name'],
          username: userData['username'],
          email: userData['email'],
          password: '', // Don't store password locally
          address: List<String>.from(userData['address']),
          contactNo: userData['contactNo'],
          role: userData['role'],
          profilePhoto: userData['profilePhoto'],
          about: userData['about'],
          proofsOfLegitimacy: List<String>.from(userData['proofsOfLegitimacy']),
          isApproved: userData['isApproved'],
          isOpenForDonation: userData['isOpenForDonation'],
        );
        _setHomeElementBasedOnRole();
      } else {
        _setGuestUser();
      }
    } catch (e) {
      print("Error loading user data");
      _setGuestUser();
    }
    notifyListeners();
  }

  Future<String?> signUp(user_model.User user) async {
    String? error = await authService.signUp(user);
    if (error == null && firebaseUser != null) {
      await _loadUserData(firebaseUser!.uid);
    }
    notifyListeners();
    return error;
  }

  Future<String?> signIn(String email, String password) async {
    String? error = await authService.signIn(email, password);
    if (error == null && firebaseUser != null) {
      await _loadUserData(firebaseUser!.uid);
    }
    notifyListeners();
    return error;
  }

  Future<void> signOut() async {
    await authService.signOut();
    _setGuestUser();
    notifyListeners();
  }

  void _setGuestUser() {
    _currentUser = user_model.User(
      id: '-1',
      name: 'Guest',
      username: 'guest',
      password: 'none',
      address: [],
      contactNo: 'none',
      role: 'guest',
      email: 'guest@example.com',
      profilePhoto: 'none',
      about: 'guest data',
      proofsOfLegitimacy: [],
      isApproved: false,
      isOpenForDonation: false,
    );
    _homeElement = const LoginPage();
  }

  void _setHomeElementBasedOnRole() {
    if (_currentUser.role == "donor") {
      _homeElement = const DonorHomePage();
    } else if (_currentUser.role == "organization") {
      _homeElement = const OrgHomePage();
    } else if (_currentUser.role == "admin") {
      _homeElement = const AdminHomePage();
    } else {
      _homeElement = const LoginPage();
    }
  }

  user_model.User changeCurrentUser(String email, String password) {
    user_model.User? foundUser;
    for (user_model.User user in _userList) {
      if (user.email == email && user.password == password) {
        foundUser = user;
      }
    }
    if (foundUser != null) {
      _currentUser = foundUser;
    } else {
      _setGuestUser();
    }

    _setHomeElementBasedOnRole();
    notifyListeners();
    return _currentUser;
  }

  void updateUser(user_model.User user) async {
    if (currentUser != null) {
      try {
        String message =
            await firebaseService.updateUser(user.id!, user.toJson());
        _loadUserData(user.id!);
        print(message);
        notifyListeners();
      } on FirebaseException catch (e) {
        print("Failed to update user");
      }
    } else {
      print("No user selected for update");
    }
  }
}
