import 'package:flutter/material.dart';
import 'package:elbi_donation_system/components/main_drawer.dart';
import 'package:elbi_donation_system/models/route_model.dart';
import 'package:elbi_donation_system/screens/log_in_page.dart';
import 'package:elbi_donation_system/models/donation_model.dart';
import 'package:elbi_donation_system/models/organization_model.dart';
import 'package:elbi_donation_system/models/donation_drive_model.dart';
import 'package:elbi_donation_system/screens/donation_details_page.dart';
import 'package:elbi_donation_system/screens/donation_drive_details_page.dart';
import 'dart:math';

class OrgHomePage extends StatefulWidget {
  const OrgHomePage({super.key});

  @override
  State<OrgHomePage> createState() => _OrgHomePageState();
}

// sample organization datum
Organization organizationA = Organization(
  id: "1",
  name: "Elbi Donation System",
  about: "A donation system for the people of Los Baños",
  proofOfLegitimacy: ["BIR Registration"],
  isApproved: true,
  isOpenForDonation: true,
);

class _OrgHomePageState extends State<OrgHomePage> {
  final _formKey = GlobalKey<FormState>();
  RouteModel orgHomepage =
      RouteModel("Home", "/org-home-page", const OrgHomePage());

  // generate dummy data for donations and donation drives
  List<Donation> donations = List.generate(20, (index) {
    return Donation(
      organization: organizationA,
      category: DonationCategory.values
          .elementAt(Random().nextInt(DonationCategory.values.length)),
      donorName: "Donor $index",
      donorContactNo: "0912-345-67$index",
      dateTime: DateTime.now().subtract(Duration(days: index)),
      address: "Address $index",
      isPickup: false,
      weightInKg: Random().nextDouble() * 10.0,
      photoUrl: "https://via.placeholder.com/150",
      status: DonationStatus.values
          .elementAt(Random().nextInt(DonationStatus.values.length)),
    );
  });

  List<DonationDrive> donationDrives = List.generate(20, (index) {
    return DonationDrive(
      organization: organizationA,
      id: "DD-$index",
      name: "Donation Drive $index",
      photos: List.generate(2, (photoIndex) {
        return "https://via.placeholder.com/150";
      }),
      donations: [],
    );
  });

  // scrollable list of donations
  Widget donationList() {
    return ListView.builder(
      itemCount: donations.length,
      itemBuilder: (context, index) {
        // https://stackoverflow.com/questions/51508438/flutter-inkwell-does-not-work-with-card
        return Card(
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            splashColor: Colors.blue,
            onTap: () {
              // navigate to donation details page
              Navigator.pushNamed(
                context,
                "/donation-details",
              );
            },
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(donations[index].photoUrl!),
              ),
              title: Text(donations[index].donorName.toString()),
              subtitle: Text(donations[index].category.name),
              trailing: Text(donations[index].status.name),
            ),
          ),
        );
      },
    );
  }

  // horizontal scrollable list of donation drives
  Widget donationDriveList() {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: donationDrives.length,
      itemBuilder: (context, index) {
        return Card(
          // elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          child: InkWell(
            borderRadius: BorderRadius.circular(8),
            splashColor: Colors.blue,
            onTap: () {
              // navigate to donation drive details page
              Navigator.pushNamed(
                context,
                "/donation-drive-details",
              );
            },
            child: Column(
              children: [
                Image.network(donationDrives[index].photos[0]),
                Text(donationDrives[index].name.toString()),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(routes: [
        orgHomepage,
        RouteModel("Logout", "/", const LoginPage()),
      ]),
      appBar: AppBar(
        title: const Text("Organization Home Page"),
      ),
      body: Form(
        key: _formKey,
        // insert widgets here
        child: Column(
          children: [
            Text(organizationA.name),
            Text(organizationA.about),
            Expanded(
              flex: 7,
              child: donationDriveList(),
            ),
            Expanded(
              flex: 10,
              child: donationList(),
            ),
          ],
        ),
      ),
    );
  }
}
