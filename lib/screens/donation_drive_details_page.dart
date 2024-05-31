import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elbi_donation_system/components/header_with_pic.dart';
import 'package:elbi_donation_system/components/main_drawer.dart';
import 'package:elbi_donation_system/components/rounded_image.dart';
import 'package:elbi_donation_system/components/square_image.dart';
import 'package:elbi_donation_system/components/title_detail.dart';
import 'package:elbi_donation_system/models/donation_drive_model.dart';
import 'package:elbi_donation_system/models/user_model.dart';
import 'package:elbi_donation_system/providers/auth_provider.dart';
import 'package:elbi_donation_system/providers/donation_drive_list_provider.dart';
import 'package:elbi_donation_system/providers/donation_drive_provider.dart';
import 'package:elbi_donation_system/providers/donation_list_provider.dart';
import 'package:elbi_donation_system/providers/donation_provider.dart';
import 'package:elbi_donation_system/providers/user_list_provider.dart';
import 'package:elbi_donation_system/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/donation_model.dart';
import '../models/route_model.dart';
import 'edit_donation_drive.dart';

class DonationDriveDetails extends StatefulWidget {
  const DonationDriveDetails({super.key});

  static final RouteModel _donationDriveDetails = RouteModel(
    "Donation Drive Details",
    "/donation-drive-details",
  );
  static RouteModel get route => _donationDriveDetails;

  @override
  State<DonationDriveDetails> createState() => _DonationDriveDetailsState();
}

class _DonationDriveDetailsState extends State<DonationDriveDetails> {
  RouteModel donationDriveDetails =
      RouteModel("Donation Details", "/donation-drive-details");

  @override
  Widget build(BuildContext context) {
    DonationDrive donationDrive =
        context.watch<DonationDriveProvider>().selected;
    String userType = context
        .watch<AuthProvider>()
        .currentUser
        .role; //donor, organization, admin

    Stream<QuerySnapshot> donationsStream =
        context.watch<DonationProvider>().donations;

    Row actionButtons;
    if (userType == User.organization) {
      actionButtons = Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: TextButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          EditDonationDrive(donationDrive: donationDrive),
                    ),
                  );
                },
                icon: const Icon(Icons.edit),
                label: const Text("Edit Donation Drive")),
          ),
          Flexible(
            child: TextButton.icon(
              onPressed: () async {
                print("Deleting");
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Deleting donation drive...")),
                );
                await context
                    .read<DonationDriveProvider>()
                    .deleteDonationDrive();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                      content: Text("Successfully deleted donation drive!")),
                );
                Navigator.pop(context);
              },
              icon: const Icon(Icons.delete_rounded),
              label: const Text("Delete Donation Drive"),
              style: ButtonStyle(
                  foregroundColor: MaterialStatePropertyAll(
                      Theme.of(context).colorScheme.error)),
            ),
          )
        ],
      );
    } else if (userType == "donor") {
      actionButtons = Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton.icon(
            onPressed: () {
              Navigator.pushNamed(
                context,
                "/add-donation",
              );
            },
            icon: const Icon(Icons.add),
            label: const Text("Add Donation"),
            style: ButtonStyle(
                foregroundColor: MaterialStatePropertyAll(
                    Theme.of(context).colorScheme.error)),
          ),
        ],
      );
    } else {
      actionButtons = const Row(
        children: [],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Donation Drive Details"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              HeaderWithPic(
                  imageUrl: donationDrive.photos![0],
                  title: donationDrive.name,
                  subtitle: donationDrive.isCompleted
                      ? "Event Finished"
                      : "Event Ongoing",
                  description:
                      "Organization: ${context.watch<DonationDriveProvider>().selectedDonationDriveUser.name}"),
              TitleDetail(
                title: "Description",
                detail: donationDrive.description,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: TitleDetail(
                        title: "Start Date",
                        detail: DateFormat("yy-MM-dd")
                            .format(donationDrive.startDate)),
                  ),
                  Expanded(
                    flex: 1,
                    child: TitleDetail(
                        title: "End Date",
                        detail: DateFormat("yy-MM-dd")
                            .format(donationDrive.endDate)),
                  ),
                ],
              ),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  "Photo Details",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemCount: donationDrive.photos!.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                        padding: const EdgeInsets.all(5.00),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: SquareImage(
                              source: donationDrive.photos![index], size: 80),
                        ));
                  }),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  "Donations",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              StreamBuilder(
                stream: donationsStream,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    print("Error encountered: ${snapshot.error}");
                    return Center(
                      child: Text("Error encountered! ${snapshot.error}"),
                    );
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    print("Loading donations...");
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    print("No donations found.");
                    return const Center(
                      child: Text("No Donations Found"),
                    );
                  }

                  var filteredDonations = snapshot.data!.docs.where((doc) {
                    Map<String, dynamic> docMap =
                        doc.data() as Map<String, dynamic>;
                    docMap["id"] = doc.id;
                    Donation donation = Donation.fromJson(docMap);
                    return donation.donationDriveId == donationDrive.id;
                  }).toList();

                  if (filteredDonations.isEmpty) {
                    print("No donations for this drive.");
                    return const Center(
                      child: Text(
                          "This donation drive doesn't have a donation yet"),
                    );
                  }

                  return ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: filteredDonations.length,
                    itemBuilder: (context, index) {
                      Map<String, dynamic> docMap = filteredDonations[index]
                          .data() as Map<String, dynamic>;
                      docMap["id"] = filteredDonations[index].id;
                      Donation donation = Donation.fromJson(docMap);
                      return ListTile(
                        leading:
                            RoundedImage(source: donation.photos![0], size: 50),
                        title: Text(donation.category),
                        subtitle: Text(donation.description),
                        trailing: IconButton(
                          icon: const Icon(Icons.more_vert),
                          onPressed: () async {
                            context
                                .read<DonationProvider>()
                                .changeSelectedDonation(donation);
                            context
                                .read<DonationProvider>()
                                .changeSelectedDonor(await context
                                    .read<UserProvider>()
                                    .fetchUserById(donation.donorId));
                            Navigator.pushNamed(context, "/donation-details");
                          },
                        ),
                      );
                    },
                  );
                },
              ),
              actionButtons,
            ],
          ),
        ),
      ),
    );
  }
}
