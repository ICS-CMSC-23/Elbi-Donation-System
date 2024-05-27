import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../api/firebase_donation_drive_api.dart';
import '../components/bottom_scroll_view_widget.dart';
import '../components/custom_tile_container.dart';
import '../components/list_page_header.dart';
import '../components/list_page_sliver_app_bar.dart';
import '../dummy_data/dummy_donation_drives.dart';
import '../models/donation_drive_model.dart';
import '../models/route_model.dart';
import '../models/user_model.dart';
import '../providers/donation_drive_list_provider.dart';
import '../providers/donation_drive_provider.dart';
import '../providers/user_list_provider.dart';
import '../screens/donation_drive_details_page.dart';
import '../providers/auth_provider.dart';

class DonationDriveListPage extends StatefulWidget {
  const DonationDriveListPage({super.key});

  // class route model
  static final RouteModel _donationDriveListPage = RouteModel(
    "Donation Drive",
    "/donation-drive-list-page",
  );
  static RouteModel get route => _donationDriveListPage;

  @override
  State<DonationDriveListPage> createState() => _DonationDriveListPageState();
}

class _DonationDriveListPageState extends State<DonationDriveListPage> {
  Widget displayDonationDriveList(donationDrives) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          bool hasPhotos = donationDrives[index]['photos'] != null &&
              donationDrives[index]['photos'] is List &&
              donationDrives[index]['photos'].isNotEmpty;
          return CustomTileContainer(
            key: ObjectKey(index),
            customBorder: CustomTileContainer.customBorderOne,
            customBorderAlt: CustomTileContainer.customBorderTwo,
            context: context,
            index: index,
            child: Stack(
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                      top: 15, left: 18, right: 18, bottom: 15),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 5),
                          child: Text(
                            donationDrives[index]['name'],
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      // donation drive list images
                      ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: hasPhotos
                                ? [
                                    for (int i = 0;
                                        i <
                                            donationDrives[index]['photos']
                                                .length;
                                        i++)
                                      Padding(
                                        padding: i <
                                                donationDrives[index]['photos']
                                                        .length -
                                                    1
                                            ? const EdgeInsets.only(right: 8.0)
                                            : EdgeInsets.zero,
                                        child: Container(
                                          height: 100,
                                          width: 200,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            image: DecorationImage(
                                              image: NetworkImage(
                                                  donationDrives[index]
                                                      ['photos'][i]),
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          child: Image.network(
                                            donationDrives[index]['photos'][i],
                                            fit: BoxFit.cover,
                                            loadingBuilder: (context, child,
                                                loadingProgress) {
                                              if (loadingProgress == null) {
                                                return child;
                                              }
                                              return Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  value: loadingProgress
                                                              .expectedTotalBytes !=
                                                          null
                                                      ? loadingProgress
                                                              .cumulativeBytesLoaded /
                                                          (loadingProgress
                                                                  .expectedTotalBytes ??
                                                              1)
                                                      : null,
                                                ),
                                              );
                                            },
                                            errorBuilder:
                                                (context, error, stackTrace) {
                                              return Image.asset(
                                                'assets/images/banner_biggertext_1.png',
                                                fit: BoxFit.cover,
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                  ]
                                : [
                                    Container(
                                      height: 100,
                                      width: 200,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: const DecorationImage(
                                          image: AssetImage(
                                              'assets/images/banner_biggertext_1.png'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ],
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 7, left: 5, right: 5, bottom: 0),
                        child: RichText(
                          textAlign: TextAlign.justify,
                          text: TextSpan(
                            style: TextStyle(
                              // fontSize: 14.0,
                              color: Theme.of(context).colorScheme.onSurface,
                              height: 1.5,
                              letterSpacing: 1.1,
                            ),
                            children: <TextSpan>[
                              const TextSpan(
                                text: 'Start Date:\t',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text:
                                    '${DateFormat('yyyy-MM-dd').format(donationDrives[index]['startDate'].toDate())}\n',
                              ),
                              const TextSpan(
                                text: 'End Date:\t\t\t',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: DateFormat('yyyy-MM-dd').format(
                                    donationDrives[index]['endDate'].toDate()),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 10,
                  right: 16,
                  child: ElevatedButton(
                    style: ButtonStyle(
                      elevation: WidgetStateProperty.all(0),
                    ),
                    onPressed: () {
                      // convert donation drive map to donation drive object
                      DonationDrive donationDrive =
                          DonationDrive.fromJson(donationDrives[index].data());

                      // Implement view full details functionality
                      context
                          .read<DonationDriveProvider>()
                          .changeSelectedDonationDrive(donationDrive);
                      context
                          .read<DonationDriveProvider>()
                          .changeSelectedDonationDriveUser(
                              context.read<AuthProvider>().currentUser);
                      Navigator.pushNamed(
                        context,
                        DonationDriveDetails.route.path,
                      );
                    },
                    child: const Text('View Full Details'),
                  ),
                ),
              ],
            ),
          );
        },
        childCount: donationDrives.length,
      ),
    );
  }

  Widget displayAppBar() {
    return const ListPageSliverAppBar(
        title: 'Donation Drives',
        backgroundWidget: ListPageHeader(
          title: 'Donation Drives',
          titleIcon: Icons.real_estate_agent_rounded,
        ));
  }

  @override
  Widget build(BuildContext context) {
    // get current user (organization)
    User currentUser = context.watch<AuthProvider>().currentUser;

    // get donation drives by organization id
    context
        .read<DonationDriveProvider>()
        .fetchDonationDrivesByOrganizationId(currentUser.id!);
    context.read<DonationDriveProvider>().fetchDonationDrives();
    Stream<QuerySnapshot> donationDrives =
        context.watch<DonationDriveProvider>().donationDrives;

    return Scaffold(
      body: CustomScrollView(
        // physics: const BouncingScrollPhysics(),
        // semanticChildCount: donationDrives.length,
        slivers: [
          displayAppBar(),
          const SliverToBoxAdapter(
            child: SizedBox(height: 10),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: donationDrives,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Center(
                  child: Text("Error encountered! ${snapshot.error}"),
                );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const SliverFillRemaining(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return SliverFillRemaining(
                  child: Center(
                    child: Text(
                      "No Donation Drives found",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 247, 129, 139),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }

              return displayDonationDriveList(snapshot.data!.docs);
            },
          ),
          SliverFillRemaining(
            hasScrollBody: false,
            child: Column(
              children: [
                const Expanded(child: SizedBox(height: 1)),
                Container(
                  color: Theme.of(context).cardColor,
                  height: 20,
                  child: Center(
                    child: Text(
                      'Donation Drives: ${donationDrives.length}',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
