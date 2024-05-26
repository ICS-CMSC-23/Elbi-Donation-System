import 'package:elbi_donation_system/models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../api/firebase_donation_api.dart';
import '../models/donation_model.dart';

class DonationProvider with ChangeNotifier {
  late FirebaseDonationAPI firebaseService;
  late Stream<QuerySnapshot> _donationsStream;
  Donation? _selectedDonation;
  User? _selectedDonor;

  DonationProvider() {
    firebaseService = FirebaseDonationAPI();
    fetchDonations();
  }

  // getters
  Stream<QuerySnapshot> get donations => _donationsStream;
  Donation get selected => _selectedDonation!;
  User get selectedDonor => _selectedDonor!;

  changeSelectedDonation(Donation donation) {
    _selectedDonation = donation;
    notifyListeners();
  }

  changeSelectedDonor(User user) {
    _selectedDonor = user;
    notifyListeners();
  }

  void fetchDonations() {
    _donationsStream = firebaseService.getAllDonations();
    notifyListeners();
  }

  void fetchDonationsByDonorId(String donorId) {
    _donationsStream = firebaseService.getDonationsByDonorId(donorId);
    notifyListeners();
  }

  void fetchDonationsByDonationDriveId(String donationDriveId) {
    _donationsStream =
        firebaseService.getDonationsByDonationDriveId(donationDriveId);
    notifyListeners();
  }

  void addDonation(Donation donation) async {
    try {
      String message = await firebaseService.addDonation(donation);
      print(message);
      notifyListeners();
    } on FirebaseException catch (e) {
      print("Failed to add donation: ${e.message}");
    }
  }

  void updateDonation(Donation donation) async {
    if (_selectedDonation != null) {
      try {
        String message = await firebaseService.updateDonation(
            donation.id!, donation.toJson());
        print(message);
        notifyListeners();
      } on FirebaseException catch (e) {
        print("Failed to update donation: ${e.message}");
      }
    } else {
      print("No donation selected for update");
    }
  }

  void deleteDonation() async {
    if (_selectedDonation != null && _selectedDonation!.id != null) {
      try {
        String message =
            await firebaseService.deleteDonation(_selectedDonation!.id!);
        print(message);
        notifyListeners();
      } on FirebaseException catch (e) {
        print("Failed to delete donation: ${e.message}");
      }
    } else {
      print("No donation selected for deletion");
    }
  }
}
