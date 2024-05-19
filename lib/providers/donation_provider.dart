import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../api/firebase_donation_api.dart';
import '../models/donation_model.dart';

class DonationProvider with ChangeNotifier {
  late FirebaseDonationAPI firebaseService;
  late Stream<QuerySnapshot> _donationsStream;
  Donation? _selectedDonation;

  DonationProvider() {
    firebaseService = FirebaseDonationAPI();
    fetchDonations();
  }

  // getters
  Stream<QuerySnapshot> get donations => _donationsStream;
  Donation get selected => _selectedDonation!;

  changeSelectedDonation(Donation donation) {
    _selectedDonation = donation;
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
    String message = await firebaseService.addDonation(donation);
    print(message);
    notifyListeners();
  }

  void updateDonation(Donation donation) async {
    String message =
        await firebaseService.updateDonation(donation.id!, donation.toJson());
    print(message);
    notifyListeners();
  }

  void deleteDonation() async {
    String message =
        await firebaseService.deleteDonation(_selectedDonation!.id!);
    print(message);
    notifyListeners();
  }
}
