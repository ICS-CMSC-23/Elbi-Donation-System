import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elbi_donation_system/components/rounded_image.dart';
import 'package:elbi_donation_system/dummy_data/dummy_donations.dart';
import 'package:elbi_donation_system/models/donation_model.dart';
import 'package:elbi_donation_system/providers/auth_provider.dart';
import 'package:elbi_donation_system/providers/donation_list_provider.dart';
import 'package:elbi_donation_system/providers/donation_provider.dart';
import 'package:elbi_donation_system/providers/user_list_provider.dart';
import 'package:elbi_donation_system/providers/user_provider.dart';
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
    User user = authUser.role == User.donor
        ? authUser
        : context.watch<UserProvider>().selected;
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

    Stream<QuerySnapshot> donationsStream =
        context.watch<DonationProvider>().donations;
    // List<Donation> userDonations = dummyDonations
    //     .where((donation) => donation.donorId == user.id)
    //     .toList();

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
                  child: StreamBuilder(
                stream: donationsStream,
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
                  } else if (!snapshot.hasData) {
                    return const Center(
                      child: Text("No Donations Found"),
                    );
                  }

                  // Filter donations by donorId
                  var filteredDonations = snapshot.data!.docs.where((doc) {
                    Donation donation =
                        Donation.fromJson(doc.data() as Map<String, dynamic>);
                    return donation.donorId == user.id;
                  }).toList();

                  if (filteredDonations.isEmpty) {
                    return const Center(
                      child: Text("No Donations Found for the specified donor"),
                    );
                  }

                  return ListView.builder(
                      itemCount: filteredDonations.length,
                      itemBuilder: (context, index) {
                        Donation donation = Donation.fromJson(
                            filteredDonations[index].data()
                                as Map<String, dynamic>);
                        return ListTile(
                          leading: RoundedImage(
                              source: donation.photos![0], size: 50),
                          title: Text(donation.category),
                          subtitle: Text(donation.description),
                          trailing: IconButton(
                            icon: const Icon(Icons.more_vert),
                            onPressed: () {
                              context
                                  .read<DonationProvider>()
                                  .changeSelectedDonation(donation);
                              Navigator.pushNamed(context, "/donation-details");
                            },
                          ),
                        );
                      });
                },
              )),
            ],
          ),
        ));
  }
}
