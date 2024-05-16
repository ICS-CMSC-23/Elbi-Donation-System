import 'package:elbi_donation_system/dummy_data/dummy_donation_drives.dart';
import 'package:elbi_donation_system/models/donation_drive_model.dart';
import 'package:flutter/material.dart';

class DonationDriveListProvider with ChangeNotifier {
  final List<DonationDrive> _donationDriveList = dummyDonationDrives;
  List<DonationDrive> get donationDriveList => _donationDriveList;
  DonationDrive _currentDonationDrive = DonationDrive(
    id: "",
    description: '',
    organizationId: '',
    name: '',
  );
  DonationDrive get currentDonationDrive => _currentDonationDrive;

  void setCurrentDonation(String id) {
    _currentDonationDrive =
        donationDriveList.firstWhere((donationDrive) => donationDrive.id == id);
  }
}
