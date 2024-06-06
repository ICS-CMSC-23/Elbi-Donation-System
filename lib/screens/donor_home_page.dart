import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elbi_donation_system/components/main_drawer.dart';
import 'package:elbi_donation_system/components/square_image.dart';
import 'package:elbi_donation_system/models/route_model.dart';
import 'package:elbi_donation_system/models/user_model.dart';
import 'package:elbi_donation_system/providers/donation_drive_provider.dart';
import 'package:elbi_donation_system/providers/user_provider.dart';
import 'package:elbi_donation_system/screens/donation_list_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:google_fonts/google_fonts.dart';

class DonorHomePage extends StatefulWidget {
  const DonorHomePage({super.key});

  @override
  State<DonorHomePage> createState() => _DonorHomePageState();
}

class _DonorHomePageState extends State<DonorHomePage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> orgStream = FirebaseFirestore.instance
        .collection('users')
        .where('role', isEqualTo: 'organization')
        .snapshots();

    return Scaffold(
      drawer: MainDrawer(routes: [
        RouteModel("Logout", "/login"),
        RouteModel("Home", "/"),
        DonationListPage.route,
      ]),
      appBar: AppBar(
        title: Text(
          "Donor Home Page",
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              Navigator.pushNamed(
                context,
                "/donor-profile",
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Image.asset('assets/images/banner_biggertext_1.png'),
              Padding(
                padding: const EdgeInsets.all(30),
                child: Center(
                  child: Text(
                    "Want to Donate Something?",
                    style: GoogleFonts.poppins(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF9C27B0),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Center(
                child: SizedBox(
                  width: 200,
                  height: 90,
                  child: Text(
                    "Here are the available organizations you can contact for donation:",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: const Color.fromARGB(255, 83, 21, 94),
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              StreamBuilder<QuerySnapshot>(
                stream: orgStream,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text("Error: ${snapshot.error}"),
                    );
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(
                      child: Text("No organizations found."),
                    );
                  }

                  List<User> allOrganizations = snapshot.data!.docs.map((doc) {
                    Map<String, dynamic> docMap =
                        doc.data() as Map<String, dynamic>;
                    docMap["id"] = doc.id;
                    return User.fromJson(docMap);
                  }).toList();

                  List<User> organizations = allOrganizations
                      .where((organization) => organization.isApproved!)
                      .toList();

                  return ListView.builder(
                    reverse: true,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: organizations.length,
                    itemBuilder: (context, index) {
                      final organization = organizations[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        elevation: 5,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Center(
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: SquareImage(
                                    source: organization.profilePhoto!,
                                    size:
                                        MediaQuery.of(context).size.width / 1.5,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Center(
                                child: Text(
                                  organization.name,
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Center(
                                child: Text(
                                  organization.about ??
                                      "This organization has no tagline.",
                                  style: GoogleFonts.poppins(
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Center(
                                child: ElevatedButton(
                                  onPressed: () {
                                    WidgetsBinding.instance
                                        .addPostFrameCallback((_) {
                                      context
                                          .read<UserProvider>()
                                          .changeSelectedUser(
                                            organization,
                                          );
                                      context
                                          .read<DonationDriveProvider>()
                                          .fetchDonationDrivesByOrganizationId(
                                              organization.id!);
                                      Navigator.pushNamed(
                                        context,
                                        "/org-profile",
                                      );
                                    });
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFF9C27B0),
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 15, horizontal: 30),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                  child: Text(
                                    "View Organization",
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
