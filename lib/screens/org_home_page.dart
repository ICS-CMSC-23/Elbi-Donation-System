import 'package:elbi_donation_system/api/firebase_donation_api.dart';
import 'package:elbi_donation_system/components/main_drawer.dart';
import 'package:elbi_donation_system/components/square_image.dart';
import 'package:elbi_donation_system/models/donation_model.dart';
import 'package:elbi_donation_system/models/route_model.dart';
import 'package:elbi_donation_system/providers/auth_provider.dart';
import 'package:elbi_donation_system/providers/donation_provider.dart';
import 'package:elbi_donation_system/providers/user_provider.dart';
import 'package:elbi_donation_system/screens/donation_drive_list_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:auto_size_text/auto_size_text.dart';

class OrgHomePage extends StatefulWidget {
  const OrgHomePage({super.key, this.detailList});

  final List<String>? detailList;

  @override
  State<OrgHomePage> createState() => _OrgHomePageState();
}

class _OrgHomePageState extends State<OrgHomePage> {
  @override
  Widget build(BuildContext context) {
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
            fontSize: 16,
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
          Image.asset('assets/images/transbg.png'),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Manage your donations below.',
              style: GoogleFonts.poppins(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Theme.of(context).textTheme.titleLarge?.color,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: FirebaseDonationAPI().getDonationsByOrgId(
                  context.read<AuthProvider>().currentUser.id!),
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Center(
                    child: Text("Error encountered! ${snapshot.error}"),
                  );
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                  return Center(
                    child: Text(
                      "No Donations found",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 247, 129, 139),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  );
                }

                return ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    Map<String, dynamic> docMap = snapshot.data!.docs[index]
                        .data() as Map<String, dynamic>;
                    docMap["id"] = snapshot.data!.docs[index].id;
                    Donation donation = Donation.fromJson(docMap);
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      elevation: 5,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      color: Theme.of(context).cardColor,
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(10),
                        title: AutoSizeText(
                          donation.category,
                          style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Theme.of(context).textTheme.titleLarge?.color,
                          ),
                          maxLines: 1,
                          minFontSize: 10,
                          overflow: TextOverflow.ellipsis,
                        ),
                        subtitle: Text(
                          donation.status,
                          style: GoogleFonts.poppins(
                            fontSize: 12,
                            color: Theme.of(context).textTheme.bodyLarge?.color,
                          ),
                        ),
                        leading: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: SquareImage(
                                source: donation.photos![0], size: 80)),
                        trailing: IconButton(
                          icon: const Icon(Icons.more_vert),
                          onPressed: () {
                            _handleDonationDetails(context, donation);
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
                Navigator.pushNamed(context, DonationDriveListPage.route.path);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF9C27B0),
                padding: const EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              child: Text(
                'Manage Donation Drives',
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

  void _handleDonationDetails(BuildContext context, Donation donation) async {
    final donationProvider = context.read<DonationProvider>();
    final userProvider = context.read<UserProvider>();

    donationProvider.changeSelectedDonation(donation);

    final selectedDonor = await userProvider.fetchUserById(donation.donorId);

    if (context.mounted) {
      donationProvider.changeSelectedDonor(selectedDonor);
      Navigator.pushNamed(context, "/donation-details");
    }
  }
}
