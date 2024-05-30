import 'package:elbi_donation_system/dummy_data/dummy_users.dart';
import 'package:elbi_donation_system/models/user_model.dart';
import 'package:elbi_donation_system/screens/admin_home_page.dart';
import 'package:elbi_donation_system/screens/donor_home_page.dart';
import 'package:elbi_donation_system/screens/log_in_page.dart';
import 'package:elbi_donation_system/screens/org_home_page.dart';
import 'package:flutter/material.dart';

class UserListProvider with ChangeNotifier {
  final List<User> _userList = dummyUsers;
  List<User> get userList => _userList;
  User _currentUser = User(
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

  User get currentUser => _currentUser;

  User changeCurrentUser(String email) {
    User? foundUser;
    for (User user in _userList) {
      if (user.email == email) {
        foundUser = user;
      }
    }
    _currentUser = foundUser ??
        User(
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

    notifyListeners();
    if (foundUser == null) {
      return User(
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
    }
    return foundUser;
  }
}
