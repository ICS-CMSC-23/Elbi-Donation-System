import 'package:elbi_donation_system/components/header_with_pic.dart';
import 'package:elbi_donation_system/components/main_drawer.dart';
import 'package:elbi_donation_system/components/title_detail.dart';
import 'package:elbi_donation_system/components/title_detail_list.dart';
import 'package:elbi_donation_system/models/donation_model.dart';
import 'package:elbi_donation_system/models/route_model.dart';
import 'package:elbi_donation_system/models/user_model.dart';
import 'package:elbi_donation_system/providers/auth_provider.dart';
import 'package:elbi_donation_system/providers/user_list_provider.dart';
import 'package:elbi_donation_system/screens/donation_drive_list_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OrgProfilePage extends StatefulWidget {
  const OrgProfilePage({super.key});

  @override
  State<OrgProfilePage> createState() => _OrgProfilePageState();
}

class _OrgProfilePageState extends State<OrgProfilePage> {
  @override
  Widget build(BuildContext context) {
    User user = context.watch<UserListProvider>().currentUser;

    Row actionButtons;
    String userType = context.watch<AuthProvider>().currentUser.role;
    if (userType == User.admin) {
      actionButtons = Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.check),
              label: const Text("Approve")),
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.delete_rounded),
            label: const Text("Disapprove"),
            style: ButtonStyle(
                foregroundColor: MaterialStatePropertyAll(
                    Theme.of(context).colorScheme.error)),
          )
        ],
      );
    } else if (userType == User.donor) {
      actionButtons = Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, DonationDriveListPage.route.path);
              },
              icon: const Icon(Icons.real_estate_agent_rounded),
              label: const Text("View Donation Drives")),
        ],
      );
    } else {
      actionButtons = Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.edit),
              label: const Text("Edit Profile")),
        ],
      );
    }

    return Scaffold(
        appBar: AppBar(
          title: const Text("Organization Profile Page"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              HeaderWithPic(
                imageUrl: user.profilePhoto ?? "",
                title: user.name,
                subtitle: user.username,
                description: user.about ?? "No tagline to display...",
              ),
              TitleDetailList(title: "Address", detailList: user.address),
              const TitleDetail(
                title: "Contact Number",
                detail: "09762946252",
              ),
              actionButtons
            ],
          ),
        ));
  }
}
