import 'package:elbi_donation_system/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../api/firebase_donation_drive_api.dart';
import '../models/donation_drive_model.dart';

class DonationDriveProvider with ChangeNotifier {
  late FirebaseDonationDriveAPI firebaseService;
  late Stream<QuerySnapshot> _donationDrivesStream;
  DonationDrive? _selectedDonationDrive;
  User? _selectedDonationDriveUser;

  DonationDriveProvider() {
    firebaseService = FirebaseDonationDriveAPI();
    fetchDonationDrives();
  }

  // getters
  Stream<QuerySnapshot> get donationDrives => _donationDrivesStream;

  DonationDrive get selected => _selectedDonationDrive!;

  User get selectedDonationDriveUser => _selectedDonationDriveUser!;

  changeSelectedDonationDrive(DonationDrive donationDrive) {
    _selectedDonationDrive = donationDrive;
    notifyListeners();
  }

  changeSelectedDonationDriveUser(User user) {
    _selectedDonationDriveUser = user;
    notifyListeners();
  }

  void fetchDonationDrives() {
    _donationDrivesStream = firebaseService.getAllDonationDrives();
    notifyListeners();
  }

  void fetchDonationDrivesByOrganizationId(String organizationId) {
    _donationDrivesStream =
        firebaseService.getDonationDrivesByOrganizationId(organizationId);
    notifyListeners();
  }

  void addDonationDrive(DonationDrive donationDrive) async {
    try {
      String message = await firebaseService.addDonationDrive(donationDrive);
      print(message);
      notifyListeners();
    } on FirebaseException catch (e) {
      print("Failed to add donation drive: ${e.message}");
    }
  }

  void updateDonationDrive(DonationDrive donationDrive) async {
    if (_selectedDonationDrive != null) {
      try {
        String message = await firebaseService.updateDonationDrive(
            donationDrive.id!, donationDrive.toJson());
        print(message);
        notifyListeners();
      } on FirebaseException catch (e) {
        print("Failed to update donation drive: ${e.message}");
      }
    } else {
      print("No donation drive selected for update");
    }
  }

  void deleteDonationDrive() async {
    if (_selectedDonationDrive != null && _selectedDonationDrive!.id != null) {
      try {
        String message = await firebaseService
            .deleteDonationDrive(_selectedDonationDrive!.id!);
        print(message);
        notifyListeners();
      } on FirebaseException catch (e) {
        print("Failed to delete donation drive: ${e.message}");
      }
    } else {
      print("No donation drive selected for deletion");
    }
  }
}
