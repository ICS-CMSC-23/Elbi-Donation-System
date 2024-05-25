import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elbi_donation_system/components/main_drawer.dart';
import 'package:elbi_donation_system/models/donation_drive_model.dart';
import 'package:elbi_donation_system/models/route_model.dart';
import 'package:elbi_donation_system/providers/auth_provider.dart';
import 'package:elbi_donation_system/providers/donation_drive_provider.dart';
import 'package:elbi_donation_system/providers/user_provider.dart';
import 'package:elbi_donation_system/screens/donation_drive_list_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrgHomePage extends StatelessWidget {
  const OrgHomePage({super.key, this.detailList});

  final List<String>? detailList;

  @override
  Widget build(BuildContext context) {
    // Accessing DonationDriveListProvider
    // final donationDriveListProvider =
    //     Provider.of<DonationDriveListProvider>(context);

    Stream<QuerySnapshot> donationDriveStream =
        context.watch<DonationDriveProvider>().donationDrives;

    return Scaffold(
      drawer: MainDrawer(routes: [
        RouteModel("Logout", "/login"),
        RouteModel("Home", "/"),
        DonationDriveListPage.route
      ]),
      appBar: AppBar(
        title: const Text('Organization Home Page'),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              // Navigate to Donor Profile Page
              Navigator.pushNamed(
                context,
                "/org-profile",
              );
            },
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
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
                return const Center(
                  child: Text("No Donation Drives Found"),
                );
              }

              var filteredDonationDrives = snapshot.data!.docs.where((doc) {
                DonationDrive donationDrive =
                    DonationDrive.fromJson(doc.data() as Map<String, dynamic>);
                return donationDrive.organizationId ==
                    context.read<AuthProvider>().currentUser.id;
              }).toList();

              if (filteredDonationDrives.isEmpty) {
                return const Center(
                  child: Text(
                      "No Donation Drives found for the specified organization"),
                );
              }

              return ListView.builder(
                itemCount: filteredDonationDrives.length,
                itemBuilder: (context, index) {
                  DonationDrive donationDrive = DonationDrive.fromJson(
                      filteredDonationDrives[index].data()
                          as Map<String, dynamic>);
                  return Card(
                    child: ListTile(
                      title: Text(donationDrive.name),
                      subtitle: Text(donationDrive.description),
                      leading: SizedBox(
                        width: 100,
                        child: Image.network(
                          donationDrive.photos![0],
                          fit: BoxFit.cover,
                        ),
                      ),
                      trailing: SizedBox(
                        width: 50,
                        child: IconButton(
                          icon: const Icon(Icons.more_vert),
                          onPressed: () {
                            context
                                .read<DonationDriveProvider>()
                                .changeSelectedDonationDrive(donationDrive);
                            context.read<UserProvider>().changeSelectedUser(
                                context.read<AuthProvider>().currentUser);
                            Navigator.pushNamed(
                                context, "/donation-drive-details");
                          },
                        ),
                      ),
                    ),
                  );
                },
              );
            },
          )),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                // Navigate to Create Donation Drive Page
                Navigator.pushNamed(
                  context,
                  "/add-donation-drive",
                );
              },
              child: const Text('Create Donation Drive'),
            ),
          ),
        ],
      ),
    );
  }
}
