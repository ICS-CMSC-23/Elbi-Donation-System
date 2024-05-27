import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elbi_donation_system/components/main_drawer.dart';
import 'package:elbi_donation_system/models/donation_drive_model.dart';
import 'package:elbi_donation_system/models/route_model.dart';
import 'package:elbi_donation_system/providers/auth_provider.dart';
import 'package:elbi_donation_system/providers/donation_drive_provider.dart';
import 'package:elbi_donation_system/providers/user_provider.dart';
import 'package:elbi_donation_system/screens/donation_drive_list_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';

class OrgHomePage extends StatelessWidget {
  const OrgHomePage({super.key, this.detailList});

  final List<String>? detailList;

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> donationDriveStream =
        context.watch<DonationDriveProvider>().donationDrives;

    return Scaffold(
      drawer: MainDrawer(routes: [
        RouteModel("Logout", "/login"),
        RouteModel("Home", "/"),
        DonationDriveListPage.route
      ]),
      appBar: AppBar(
        title: Text(
          'Organization Home Page',
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
              Navigator.pushNamed(context, "/org-profile");
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset('assets/images/banner_biggertext_1.png'),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Manage your donation drives below.',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF9C27B0),
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: donationDriveStream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text("Error encountered! ${snapshot.error}"),
                  );
                } else if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (!snapshot.hasData) {
                  return Center(
                    child: Text(
                      "No Donation Drives found",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 247, 129, 139),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  );
                }

                var filteredDonationDrives = snapshot.data!.docs.where((doc) {
                  DonationDrive donationDrive =
                      DonationDrive.fromJson(doc.data() as Map<String, dynamic>);
                  return donationDrive.organizationId ==
                      context.read<AuthProvider>().currentUser.id;
                }).toList();

                if (filteredDonationDrives.isEmpty) {
                  return Center(
                    child: Text(
                      "No Donation Drives found",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 247, 129, 139),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: filteredDonationDrives.length,
                  itemBuilder: (context, index) {
                    DonationDrive donationDrive = DonationDrive.fromJson(
                        filteredDonationDrives[index].data()
                            as Map<String, dynamic>);
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(10),
                        title: AutoSizeText(
                          donationDrive.name,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          minFontSize: 10,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(
                          donationDrive.description,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                          ),
                        ),
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: Image.network(
                            donationDrive.photos![0],
                            width: 100,
                            height: 100,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.error);
                            },
                          )
                        ),
                        trailing: IconButton(
                          icon: const Icon(Icons.more_vert),
                          onPressed: () {
                            context.read<DonationDriveProvider>()
                                .changeSelectedDonationDrive(donationDrive);
                            context.read<UserProvider>().changeSelectedUser(
                                context.read<AuthProvider>().currentUser);
                            Navigator.pushNamed(
                                context, "/donation-drive-details");
                          },
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, "/add-donation-drive");
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF9C27B0),
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                'Create Donation Drive',
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
