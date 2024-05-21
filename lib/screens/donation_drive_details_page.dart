import 'package:elbi_donation_system/components/header_with_pic.dart';
import 'package:elbi_donation_system/components/main_drawer.dart';
import 'package:elbi_donation_system/components/rounded_image.dart';
import 'package:elbi_donation_system/components/title_detail.dart';
import 'package:elbi_donation_system/models/donation_drive_model.dart';
import 'package:elbi_donation_system/models/user_model.dart';
import 'package:elbi_donation_system/providers/auth_provider.dart';
import 'package:elbi_donation_system/providers/donation_drive_list_provider.dart';
import 'package:elbi_donation_system/providers/donation_list_provider.dart';
import 'package:elbi_donation_system/providers/user_list_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/donation_model.dart';
import '../models/route_model.dart';

class DonationDriveDetails extends StatefulWidget {
  const DonationDriveDetails({super.key});

  // class route model
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
        context.watch<DonationDriveListProvider>().currentDonationDrive;
    List<Donation> donations = context
        .read<DonationListProvider>()
        .donationList
        .where((donation) => donation.donationDriveId == donationDrive.id)
        .toList();
    String userType = context
        .watch<AuthProvider>()
        .currentUser
        .role; //donor, organization, admin
    Row actionButtons;
    if (userType == User.organization) {
      actionButtons = Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: TextButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.edit),
                label: const Text("Edit Donation Drive")),
          ),
          Flexible(
            child: TextButton.icon(
              onPressed: () {},
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
            onPressed: () {},
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
      body: Padding(
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
                    "Organization: ${context.read<UserListProvider>().userList.firstWhere((user) => user.id == donationDrive.organizationId).name}"),
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
                      detail:
                          DateFormat("yy-MM-dd").format(donationDrive.endDate)),
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
                itemCount: donationDrive.photos?.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                      padding: const EdgeInsets.all(5.00),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.network(donationDrive.photos![index],
                            fit: BoxFit.cover),
                      ));
                }),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                "Donations",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: donations.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: RoundedImage(
                          source: donations[index].photos![0], size: 50),
                      title: Text(donations[index].category),
                      subtitle: Text(donations[index].description),
                      trailing: IconButton(
                        icon: const Icon(Icons.handshake),
                        onPressed: () {
                          context
                              .read<DonationListProvider>()
                              .setCurrentDonation(
                                  donations[index].id ?? "donation_0");
                          Navigator.pushNamed(context, "/donation-details");
                        },
                      ),
                    );
                  }),
            ),
            actionButtons,
          ],
        ),
      ),
    );
  }
}
