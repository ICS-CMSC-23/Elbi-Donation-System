import 'package:elbi_donation_system/components/main_drawer.dart';
import 'package:flutter/material.dart';
import '../models/route_model.dart';

class DonationDriveDetails extends StatefulWidget {
  const DonationDriveDetails({super.key});

  // class route model
  static final RouteModel _donationDriveDetails = RouteModel(
    "Donation Drive Details",
    "/donation-drive-details",
  );
  static RouteModel get route => _donationDriveDetails;

  @override
  State<DonationDriveDetails> createState() => _DonationDriveDetailsState();
}

class _DonationDriveDetailsState extends State<DonationDriveDetails> {
  RouteModel donationDriveDetails =
      RouteModel("Donation Details", "/donation-drive-details");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(routes: [
        RouteModel("Home", "/"),
        RouteModel("Logout", "/login"),
      ]),
      appBar: AppBar(
        title: const Text("Donation Drive Details"),
      ),
      body: const Center(child: Text("Insert something here")),
    );
  }
}
