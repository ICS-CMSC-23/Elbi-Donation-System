import 'package:flutter/material.dart';
import '../models/route_model.dart';

class DonationDriveListPage extends StatefulWidget {
  const DonationDriveListPage({super.key});

  // class route model
  static final RouteModel _donationDriveListPage = RouteModel(
    "Donation Drive List Page",
    "/donation-drive-list-page",
  );
  static RouteModel get route => _donationDriveListPage;

  @override
  State<DonationDriveListPage> createState() => _DonationDriveListPageState();
}

class _DonationDriveListPageState extends State<DonationDriveListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(DonationDriveListPage.route.name)),
      body: const Text('MyPage Body'),
    );
  }
}
