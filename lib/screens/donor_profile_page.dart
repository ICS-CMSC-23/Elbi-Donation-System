import 'package:elbi_donation_system/components/rounded_image.dart';
import 'package:elbi_donation_system/dummy_data/dummy_donations.dart';
import 'package:elbi_donation_system/models/donation_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/widgets.dart';
import '../models/user_model.dart';

import '../components/main_drawer.dart';
import 'package:flutter/material.dart';

import '../models/route_model.dart';
import 'log_in_page.dart';
import 'org_home_page.dart';
import '../components/header_with_pic.dart';
import '../components/title_detail.dart';
import '../components/title_detail_list.dart';

class DonorProfilePage extends StatefulWidget {
  const DonorProfilePage({super.key});

  @override
  State<DonorProfilePage> createState() => _DonorProfilePageState();
}

class _DonorProfilePageState extends State<DonorProfilePage> {
  @override
  Widget build(BuildContext context) {
    User dummyUser = User(
      address: [
        "Blk 11, Lot 10, Camella Homes, Brgy. Cabuco, TMC",
        "Brgy. Batong Malake, Men's Residence Hall",
      ],
      name: "Jomar Monreal",
      username: "Jomamos",
      email: "jpmonreal@up.edu.ph",
      password: "12345678",
      contactNo: '09762946252',
      role: 'donor',
      about: "My dream is to become a potato with crispy texture.",
      profilePhoto:
          "https://i.pinimg.com/originals/f5/24/e1/f524e1e728b829b039c84f5ee4f1478a.webp",
    );

    List<Donation> userDonations = dummyDonations;

    return Scaffold(
        drawer: MainDrawer(routes: [
          RouteModel("Home", "/"),
          RouteModel("Logout", "/login"),
        ]),
        appBar: AppBar(
          title: const Text("Donor Profile Page"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                HeaderWithPic(
                  imageUrl: dummyUser.profilePhoto ?? "",
                  title: dummyUser.name,
                  subtitle: dummyUser.username,
                  description: dummyUser.about ?? "No biography to display...",
                ),
                TitleDetailList(
                    title: "Address", detailList: dummyUser.address),
                const TitleDetail(
                  title: "Contact Number",
                  detail: "09762946252",
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text(
                    "Your Donations",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: SizedBox(
                    height: 500,
                    child: ListView.builder(
                        itemCount: userDonations.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: RoundedImage(
                                source: userDonations[index].photos![0],
                                size: 50),
                            title: Text(userDonations[index].category),
                            subtitle: Text(userDonations[index].description),
                            trailing: IconButton(
                              icon: const Icon(Icons.card_giftcard_outlined),
                              onPressed: () {
                                Navigator.pushNamed(
                                    context, "/donation-details");
                              },
                            ),
                          );
                        }),
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
