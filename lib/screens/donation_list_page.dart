import 'package:flutter/material.dart';
import '../models/route_model.dart';

class DonationListPage extends StatefulWidget {
  const DonationListPage({super.key});

  // class route model
  static final RouteModel _donationListPage = RouteModel(
    "Donation List Page",
    "/donation-list-page",
  );
  static RouteModel get route => _donationListPage;

  @override
  State<DonationListPage> createState() => _DonationListPageState();
}

class _DonationListPageState extends State<DonationListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(DonationListPage.route.name)),
      body: const Text('MyPage Body'),
    );
  }
}
