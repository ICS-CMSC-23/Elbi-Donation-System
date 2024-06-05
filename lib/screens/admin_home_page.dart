import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elbi_donation_system/components/main_drawer.dart';
import 'package:elbi_donation_system/models/route_model.dart';
import 'package:elbi_donation_system/screens/donor_list_page.dart';
import 'package:elbi_donation_system/screens/org_list_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> orgStream = FirebaseFirestore.instance
        .collection('users')
        .where('role', isEqualTo: 'organization')
        .snapshots();

    return Scaffold(
      drawer: MainDrawer(
        routes: [
          RouteModel("Logout", "/login"),
          RouteModel("Organization Account Approval", "/org-account-approval"),
          OrgListPage.route,
          DonorListPage.route,
        ],
      ),
      appBar: AppBar(
        title: Text(
          "Admin Home Page",
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.asset('assets/images/banner_biggertext_1.png'),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    childAspectRatio: 0.5,
                    reverse: true,
                    children: [
                      _buildFeatureCard(
                        icon: Icons.business,
                        title: "View All Organizations",
                        description: "View all approved organizations",
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            "/org-list-page",
                          );
                        },
                      ),
                      _buildFeatureCard(
                        icon: Icons.handshake,
                        title: "View All Donors",
                        description: "List of all donors",
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            "/donor-list-page",
                          );
                        },
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Welcome, Admin",
                              style: GoogleFonts.poppins(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF9C27B0),
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              "Manage operations efficiently",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                color: const Color(0xFF9C27B0),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      _buildFeatureCard(
                        icon: Icons.business,
                        title: "Organization Account Approval",
                        description: "View all pending organization accounts",
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            "/org-account-approval",
                          );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String description,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: SizedBox(
        width: double.infinity,
        height: 300,
        child: Card(
          elevation: 10,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          // shadowColor: Colors.grey.withOpacity(0.9),
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 100,
                  color: const Color(0xFF9C27B0),
                ),
                const SizedBox(height: 15),
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF9C27B0),
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 10),
                Expanded(
                  child: Text(
                    description,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF9C27B0),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
