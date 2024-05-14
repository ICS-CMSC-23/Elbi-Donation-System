import 'package:elbi_donation_system/components/header_with_pic.dart';
import 'package:elbi_donation_system/components/title_detail.dart';
import 'package:elbi_donation_system/components/title_detail_list.dart';
import 'package:elbi_donation_system/dummy_data/dummy_donations.dart';
import 'package:elbi_donation_system/models/donation_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import '../models/route_model.dart';

class DonationDetails extends StatefulWidget {
  const DonationDetails({super.key});

  // class route model
  static final RouteModel _donationDetails = RouteModel(
    "Donation Details",
    "/donation-details",
    const DonationDetails(),
  );
  static RouteModel get route => _donationDetails;

  @override
  State<DonationDetails> createState() => _DonationDetailsState();
}

class _DonationDetailsState extends State<DonationDetails> {
  @override
  Widget build(BuildContext context) {
    Donation dummyDonation = dummyDonations[1];
    String userType = "donor"; //donor, organization, admin
    Row actionButtons;
    if (userType == "donor") {
      actionButtons = Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          TextButton.icon(
              onPressed: () {},
              icon: Icon(Icons.edit),
              label: Text("Edit Donation")),
          TextButton.icon(
            onPressed: () {},
            icon: Icon(Icons.delete_rounded),
            label: Text("Cancel Donation"),
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
            icon: Icon(Icons.delete_rounded),
            label: Text("Cancel Donation"),
            style: ButtonStyle(
                foregroundColor: MaterialStatePropertyAll(
                    Theme.of(context).colorScheme.error)),
          ),
        ],
      );
    }

    return Scaffold(
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
              actionButtons
            ],
          ),
        ),
      ),
    );
  }
}
