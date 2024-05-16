import 'package:elbi_donation_system/dummy_data/dummy_donation_drives.dart';
import 'package:elbi_donation_system/models/donation_drive_model.dart';
import 'package:flutter/material.dart';

class DonationDriveListProvider with ChangeNotifier {
  final List<DonationDrive> _donationDriveList = dummyDonationDrives;
  List<DonationDrive> get donationDriveList => _donationDriveList;
  DonationDrive _currentDonationDrive = DonationDrive(
      id: "undefined",
      description: 'Donation Drive Description undefined',
      organizationId: '2',
      name: 'Undefined',
      startDate: DateTime.now(),
      endDate: DateTime.now(),
      photos: [
        "https://th.bing.com/th/id/OIP.TFTRdGI9wbF8sryCviymzAHaJO?rs=1&pid=ImgDetMain"
      ]);
  DonationDrive get currentDonationDrive => _currentDonationDrive;

  void setCurrentDonationDrive(String id) {
    _currentDonationDrive =
        donationDriveList.firstWhere((donationDrive) => donationDrive.id == id);
  }
}
