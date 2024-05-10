import 'package:flutter/material.dart';
import '../models/route_model.dart';

class DonationDetails extends StatefulWidget {
  const DonationDetails({super.key});

  // class route model
  static final RouteModel _donationDetails = RouteModel(
    "Donation Details",
    "/donation-details",
    const DonationDetails(),
  );
  static RouteModel get route => _donationDetails;

  @override
  State<DonationDetails> createState() => _DonationDetailsState();
}

class _DonationDetailsState extends State<DonationDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Donation Details"),
      ),
      body: const Center(child: Text("Insert something here")),
    );
  }
}
