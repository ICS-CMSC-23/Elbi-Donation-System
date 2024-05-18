import 'package:elbi_donation_system/components/rounded_image.dart';
import 'package:elbi_donation_system/dummy_data/dummy_donations.dart';
import 'package:elbi_donation_system/models/donation_model.dart';
import 'package:elbi_donation_system/providers/auth_provider.dart';
import 'package:elbi_donation_system/providers/donation_list_provider.dart';
import 'package:elbi_donation_system/providers/user_list_provider.dart';
import 'package:provider/provider.dart';
import '../models/user_model.dart';

import '../components/main_drawer.dart';
import 'package:flutter/material.dart';

import '../models/route_model.dart';
import '../components/header_with_pic.dart';
import '../components/title_detail.dart';
import '../components/title_detail_list.dart';

class DonorProfilePage extends StatefulWidget {
  const DonorProfilePage({super.key});

// class route model
  static final RouteModel _donorProfie = RouteModel(
    "Donor Profile Page",
    "/donor-profile",
  );
  static RouteModel get route => _donorProfie;

  @override
  State<DonorProfilePage> createState() => _DonorProfilePageState();
}

class _DonorProfilePageState extends State<DonorProfilePage> {
  @override
  Widget build(BuildContext context) {
    User authUser = context.watch<AuthProvider>().currentUser;
    User user = context.watch<UserListProvider>().currentUser;
    Row actionButtons;
    if (authUser.role == User.donor) {
      actionButtons = Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.edit),
              label: const Text("Edit Profile")),
        ],
      );
    } else {
      actionButtons = const Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [],
      );
    }

    List<Donation> userDonations = dummyDonations
        .where((donation) => donation.donorId == user.id)
        .toList();

    return Scaffold(
        appBar: AppBar(
          title: Text(user.name),
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
                description: user.about ?? "No biography to display...",
              ),
              TitleDetailList(title: "Address", detailList: user.address),
              const TitleDetail(
                title: "Contact Number",
                detail: "09762946252",
              ),
              actionButtons,
              const Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  "Donations",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: userDonations.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        leading: RoundedImage(
                            source: userDonations[index].photos![0], size: 50),
                        title: Text(userDonations[index].category),
                        subtitle: Text(userDonations[index].description),
                        trailing: IconButton(
                          icon: const Icon(Icons.card_giftcard_outlined),
                          onPressed: () {
                            context
                                .read<DonationListProvider>()
                                .setCurrentDonation(
                                    userDonations[index].id ?? "donation_0");
                            Navigator.pushNamed(context, "/donation-details");
                          },
                        ),
                      );
                    }),
              ),
            ],
          ),
        ));
  }
}
