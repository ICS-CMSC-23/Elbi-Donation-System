import 'package:elbi_donation_system/components/header_with_pic.dart';
import 'package:elbi_donation_system/components/main_drawer.dart';
import 'package:elbi_donation_system/components/square_image.dart';
import 'package:elbi_donation_system/components/title_detail.dart';
import 'package:elbi_donation_system/components/title_detail_list.dart';
import 'package:elbi_donation_system/dummy_data/dummy_donations.dart';
import 'package:elbi_donation_system/models/donation_drive_model.dart';
import 'package:elbi_donation_system/models/donation_model.dart';
import 'package:elbi_donation_system/models/user_model.dart';
import 'package:elbi_donation_system/providers/auth_provider.dart';
import 'package:elbi_donation_system/providers/donation_drive_provider.dart';
import 'package:elbi_donation_system/providers/dummy_providers/donation_list_provider.dart';
import 'package:elbi_donation_system/providers/donation_provider.dart';
import 'package:elbi_donation_system/providers/dummy_providers/user_list_provider.dart';
import 'package:elbi_donation_system/providers/user_provider.dart';
import 'package:elbi_donation_system/screens/qr_code_generator.dart';
import 'package:elbi_donation_system/screens/qr_code_scanner.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../models/route_model.dart';
import "package:flutter_sms/flutter_sms.dart";
import 'package:http/http.dart' as http;
import 'dart:convert';

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
  Future<void> _sendEmail({
    required String donorName,
    required String donorEmail,
    required String donationCategory,
    required String donationWeight,
    required String donationDateTime,
    required String newStatus,
    required String organizationName,
  }) async {
    const serviceId = 'service_pct82j9';
    const templateId = 'template_pu5t2dp';
    const userId = 'FRSsKAVv_SMXAD7bo';

    const subject = 'Donation Status Update';

    final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
    final response = await http.post(
      url,
      headers: {
        'origin': 'http://localhost',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'service_id': serviceId,
        'template_id': templateId,
        'user_id': userId,
        'template_params': {
          'subject': subject,
          'donor_email': donorEmail,
          'donor_name': donorName,
          'donation_category': donationCategory,
          'donation_weight': donationWeight,
          'donation_date_time': donationDateTime,
          'new_status': newStatus,
          'organization_name': organizationName,
        },
      }),
    );

    if (response.statusCode == 200) {
      print('Email sent successfully');
    } else {
      print('Failed to send email');
    }
  }

  @override
  Widget build(BuildContext context) {
    Donation donation = context.watch<DonationProvider>().selected;
    String userType = context
        .watch<AuthProvider>()
        .currentUser
        .role; //donor, organization, admin

    Widget cancelButton;
    Widget editButton;
    Widget qrButton;

    // add a button to scan the QR code
    Widget qrScanButton = TextButton.icon(
        onPressed: () {
          Navigator.pushNamed(context, QrCodeScanner.route.path);
        },
        icon: const Icon(Icons.qr_code_scanner),
        label: const Text("Scan QR Code"));

    // button for generating QR code
    Widget qrGenerateButton = TextButton.icon(
        onPressed: () {
          Navigator.pushNamed(context, QrCodeGenerator.route.path);
        },
        icon: const Icon(Icons.qr_code),
        label: const Text("Generate QR Code"));

    if (donation.status != Donation.STATUS_CANCELED &&
        donation.status != Donation.STATUS_COMPLETE) {
      cancelButton = TextButton.icon(
        onPressed: () async {
          print("Deleting");
          await context.read<DonationProvider>().deleteDonation();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Successfully cancelled donation!")),
          );
          Navigator.pop(context);
        },
        icon: const Icon(Icons.delete_rounded),
        label: const Text("Cancel Donation"),
        style: ButtonStyle(
            foregroundColor:
                MaterialStatePropertyAll(Theme.of(context).colorScheme.error)),
      );

      editButton = TextButton.icon(
          onPressed: () async {
            context.read<DonationProvider>().changeSelectedDonation(donation);
            context.read<DonationProvider>().changeSelectedDonor(await context
                .read<UserProvider>()
                .fetchUserById(donation.donorId));
            Navigator.pushNamed(context, "/edit-donation");
          },
          icon: const Icon(Icons.edit),
          label: const Text("Edit Donation"));

      if (donation.isForPickup == false &&
          donation.status == Donation.STATUS_SCHEDULED_FOR_DROPOFF) {
        if (userType == User.donor) {
          qrButton = qrGenerateButton;
        } else if (userType == User.organization) {
          qrButton = qrScanButton;
        } else {
          qrButton = SizedBox.shrink();
        }
      } else {
        qrButton = SizedBox.shrink();
      }
    } else {
      cancelButton = SizedBox.shrink();
      editButton = SizedBox.shrink();
      qrButton = SizedBox.shrink();
    }

    Widget actionButtons;
    if (userType == User.donor) {
      actionButtons = SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: donation.status == Donation.STATUS_SCHEDULED_FOR_DROPOFF
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [qrButton, editButton, cancelButton],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [editButton, cancelButton],
              ),
      );
    } else if (userType == User.organization) {
      actionButtons =
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const Padding(
          padding: EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            "Change Donation Status",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Column(
          children: Donation.statuses.map((status) {
            if (donation.isForPickup == true) {
              if (status == Donation.STATUS_SCHEDULED_FOR_DROPOFF) {
                return const SizedBox.shrink();
              }
            } else {
              if (status == Donation.STATUS_SCHEDULED_FOR_PICKUP) {
                return const SizedBox.shrink();
              }
            }

            return Column(
              children: [
                RadioListTile<String>(
                  title: Text(status),
                  value: status,
                  groupValue: context.watch<DonationProvider>().selected.status,
                  onChanged: (value) {
                    donation.status = value!;
                    context.read<DonationProvider>().updateDonation(donation);

                    print("Sending email");
                    _sendEmail(
                      donorName:
                          context.read<DonationProvider>().selectedDonor.name,
                      donorEmail:
                          context.read<DonationProvider>().selectedDonor.email,
                      donationCategory: donation.category,
                      donationWeight: donation.weightInKg.toString(),
                      donationDateTime: DateFormat.yMMMMd()
                          .add_jm()
                          .format(donation.dateTime),
                      newStatus: value,
                      organizationName:
                          context.read<AuthProvider>().currentUser.name,
                    );
                  },
                  controlAffinity: ListTileControlAffinity.leading,
                  dense: true,
                  contentPadding: EdgeInsets.all(0),
                ),
              ],
            );
          }).toList(),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: donation.status == Donation.STATUS_SCHEDULED_FOR_DROPOFF
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [qrButton, editButton, cancelButton],
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [editButton, cancelButton],
                ),
        )
      ]);
    } else {
      actionButtons = Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [cancelButton],
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
                  imageUrl: donation.photos![0],
                  title: donation.category,
                  subtitle: donation.status,
                  description:
                      // "Donor: Try"),
                      "Donor: ${context.watch<DonationProvider>().selectedDonor.name}"),
              TitleDetail(title: "Description", detail: donation.description),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TitleDetail(
                            title: "Weight (in kg)",
                            detail: donation.weightInKg.toString()),
                        TitleDetail(
                            title: "Date",
                            detail: DateFormat("yy-MM-dd")
                                .format(donation.dateTime)),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TitleDetail(
                          title: "Contact Number",
                          detail: context
                              .watch<DonationProvider>()
                              .selectedDonor
                              .contactNo,
                        ),
                        FutureBuilder(
                            future: context
                                .read<DonationDriveProvider>()
                                .getDonationDriveById(
                                    donation.donationDriveId!),
                            builder: (context, snapshot) {
                              if (snapshot.hasError) {
                                print("Error encountered: ${snapshot.error}");
                                return Center(
                                  child: Text(
                                      "Error encountered! ${snapshot.error}"),
                                );
                              } else if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                print("Loading donations...");
                                return const Center(
                                  child: CircularProgressIndicator(),
                                );
                              } else if (!snapshot.hasData) {
                                print("No drive found.");
                                return const Center(
                                  child: Text("No Donations Found"),
                                );
                              }
                              return TitleDetail(
                                  title: "Donation Drive",
                                  detail: snapshot.data!.name);
                            }),
                      ],
                    ),
                  ),
                ],
              ),
              TitleDetailList(
                  title: "Address",
                  detailList:
                      context.watch<DonationProvider>().selected.addresses),
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
                  itemCount: donation.photos?.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                        padding: const EdgeInsets.all(5.00),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10.0),
                          child: SquareImage(
                            source: donation.photos![index],
                            size: 80,
                          ),
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
