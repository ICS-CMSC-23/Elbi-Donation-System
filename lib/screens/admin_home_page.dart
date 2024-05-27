import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elbi_donation_system/components/main_drawer.dart';
import 'package:elbi_donation_system/components/rounded_image.dart';
import 'package:elbi_donation_system/models/route_model.dart';
import 'package:elbi_donation_system/models/user_model.dart';
import 'package:elbi_donation_system/providers/user_provider.dart';
import 'package:elbi_donation_system/screens/donor_list_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  @override
  Widget build(BuildContext context) {
    // Fetching the list of organizations from Firestore
    Stream<QuerySnapshot> orgStream = FirebaseFirestore.instance
        .collection('users')
        .where('role', isEqualTo: 'organization')
        .snapshots();

    return Scaffold(
      drawer: MainDrawer(
        routes: [
          RouteModel("Logout", "/login"),
          RouteModel("Organization Account Approval", "/org-account-approval"),
          DonorListPage.route,
        ],
      ),
      appBar: AppBar(
        title: const Text("Admin Home Page"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset('assets/images/banner_biggertext_1.png'),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Icon(
                    Icons.handshake,
                    size: 100,
                  ),
                  Center(
                    child: Text(
                      "View All Donors",
                      style: GoogleFonts.poppins(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF9C27B0),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Center(
                    child: SizedBox(
                      width: 200,
                      child: Text(
                        "Show the list of all donor accounts in the system.",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: const Color.fromARGB(255, 83, 21, 94),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Center(
                    child: ElevatedButton(
                        onPressed: () {}, child: const Text("View All Donors")),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Icon(
                    Icons.business,
                    size: 100,
                  ),
                  Center(
                    child: Text(
                      "Organization Account Approval",
                      style: GoogleFonts.poppins(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF9C27B0),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  Center(
                    child: SizedBox(
                      width: 200,
                      child: Text(
                        "Shows all pending organization account on approval.",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: const Color.fromARGB(255, 83, 21, 94),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Center(
                    child: ElevatedButton(
                        onPressed: () {},
                        child: const Text("Check Organizations")),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
