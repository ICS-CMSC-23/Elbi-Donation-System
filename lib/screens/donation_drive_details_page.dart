import 'package:flutter/material.dart';
import '../models/route_model.dart';

class DonationDriveDetails extends StatefulWidget {
  const DonationDriveDetails({super.key});

  @override
  State<DonationDriveDetails> createState() => _DonationDriveDetailsState();
}

class _DonationDriveDetailsState extends State<DonationDriveDetails> {
  RouteModel donationDriveDetails = RouteModel("Donation Details",
      "/donation-drive-details", const DonationDriveDetails());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Donation Drive Details"),
      ),
      body: const Center(child: Text("Insert something here")),
    );
  }
}
