import 'package:elbi_donation_system/components/header_with_pic.dart';
import 'package:elbi_donation_system/components/main_drawer.dart';
import 'package:elbi_donation_system/components/title_detail.dart';
import 'package:elbi_donation_system/components/title_detail_list.dart';
import 'package:elbi_donation_system/dummy_data/dummy_donations.dart';
import 'package:elbi_donation_system/models/donation_model.dart';
import 'package:elbi_donation_system/providers/donation_list_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/route_model.dart';

class DonationDetails extends StatefulWidget {
  const DonationDetails({super.key});

  // class route model
  static final RouteModel _donationDetails = RouteModel(
    "Donation Details",
    "/donation-details",
  );
  static RouteModel get route => _donationDetails;

  @override
  State<DonationDetails> createState() => _DonationDetailsState();
}

class _DonationDetailsState extends State<DonationDetails> {
  @override
  Widget build(BuildContext context) {
    Donation dummyDonation =
        context.watch<DonationListProvider>().currentDonation;
    String userType = "donor"; //donor, organization, admin
    Row actionButtons;
    if (userType == "donor") {
      actionButtons = Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton.icon(
              onPressed: () {},
              icon: const Icon(Icons.edit),
              label: const Text("Edit Donation")),
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.delete_rounded),
            label: const Text("Cancel Donation"),
            style: ButtonStyle(
                foregroundColor: MaterialStatePropertyAll(
                    Theme.of(context).colorScheme.error)),
          )
        ],
      );
    } else {
      actionButtons = Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton.icon(
            onPressed: () {},
            icon: const Icon(Icons.delete_rounded),
            label: const Text("Cancel Donation"),
            style: ButtonStyle(
                foregroundColor: MaterialStatePropertyAll(
                    Theme.of(context).colorScheme.error)),
          ),
        ],
      );
    }

    return Scaffold(
      drawer: MainDrawer(routes: [
        RouteModel("Home", "/"),
        RouteModel("Logout", "/login"),
      ]),
      appBar: AppBar(
        title: const Text("Donation Details"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              HeaderWithPic(
                  imageUrl: dummyDonation.photos![0],
                  title: dummyDonation.category,
                  subtitle: dummyDonation.status,
                  description: dummyDonation.description),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TitleDetail(
                            title: "Donor", detail: dummyDonation.donorId),
                        TitleDetail(
                            title: "Date",
                            detail: DateFormat("yy-MM-dd")
                                .format(dummyDonation.dateTime)),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TitleDetail(
                            title: "Weight (in kg)",
                            detail: dummyDonation.weightInKg.toString()),
                        const TitleDetail(
                          title: "Contact Number",
                          detail: "09762946252",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              TitleDetailList(
                  title: "Address", detailList: dummyDonation.addresses),
              const Text(
                "Photo Details",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemCount: dummyDonation.photos?.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                        padding: const EdgeInsets.all(5.00),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: Image.network(dummyDonation.photos![index],
                              fit: BoxFit.cover),
                        ));
                  }),
              actionButtons
            ],
          ),
        ),
      ),
    );
  }
}
