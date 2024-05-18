import 'package:elbi_donation_system/dummy_data/dummy_donations.dart';
import 'package:elbi_donation_system/models/donation_model.dart';
import 'package:flutter/material.dart';

class DonationListProvider with ChangeNotifier {
  final List<Donation> _donationList = dummyDonations;
  List<Donation> get donationList => _donationList;
  Donation _currentDonation = Donation(
    id: "",
    description: '',
    donorId: '',
    category: '',
    isForPickup: false,
    dateTime: DateTime.now(),
    weightInKg: 0,
    addresses: [],
    contactNo: '',
  );
  Donation get currentDonation => _currentDonation;

  void setCurrentDonation(String id) {
    _currentDonation = donationList.firstWhere((donation) => donation.id == id);
    notifyListeners();
  }
}
