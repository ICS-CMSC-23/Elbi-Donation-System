import 'package:flutter/material.dart';
import '../models/route_model.dart';

class DonationDetails extends StatefulWidget {
  const DonationDetails({super.key});

  @override
  State<DonationDetails> createState() => _DonationDetailsState();
}

class _DonationDetailsState extends State<DonationDetails> {
  RouteModel donationDetails = RouteModel(
      "Donation Details", "/donation-details", const DonationDetails());

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
