import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elbi_donation_system/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../components/custom_tile_container.dart';
import '../components/list_page_header.dart';
import '../components/list_page_sliver_app_bar.dart';
import '../components/upload_helper.dart';
import '../models/donation_model.dart';
import '../models/route_model.dart';
import '../models/user_model.dart';
import '../providers/auth_provider.dart';
import '../providers/donation_provider.dart';
import '../screens/donation_details_page.dart';

class DonationListPage extends StatefulWidget {
  const DonationListPage({super.key});

  // class route model
  static final RouteModel _donationListPage = RouteModel(
    "Donation List",
    "/donation-list-page",
  );
  static RouteModel get route => _donationListPage;

  @override
  State<DonationListPage> createState() => _DonationListPageState();
}

class _DonationListPageState extends State<DonationListPage> {
  Widget displayDonationList(donations, currentUser) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          bool hasPhotos = donations[index]['photos'] != null &&
              donations[index]['photos'] is List &&
              donations[index]['photos'].isNotEmpty;

          return CustomTileContainer(
            customBorder: CustomTileContainer.customBorderOne,
            customBorderAlt: CustomTileContainer.customBorderTwo,
            context: context,
            index: index,
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 20, left: 20, right: 20, bottom: 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // donation images
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: hasPhotos
                              ? [
                                  for (int i = 0;
                                      i < donations[index]['photos'].length;
                                      i++)
                                    Padding(
                                      padding: i <
                                              donations[index]['photos']
                                                      .length -
                                                  1
                                          ? const EdgeInsets.only(right: 8.0)
                                          : EdgeInsets.zero,
                                      child: Image.network(
                                        donations[index]['photos'][i],
                                        height: 100,
                                        width: 200,
                                        fit: BoxFit.cover,
                                        errorBuilder:
                                            (context, error, stackTrace) {
                                          try {
                                            return Image.memory(
                                              decodeBase64Image(donations[index]
                                                  ['photos'][i]),
                                              height: 100,
                                              width: 200,
                                              fit: BoxFit.cover,
                                              errorBuilder:
                                                  (context, error, stackTrace) {
                                                return Image.asset(
                                                  'assets/images/banner_biggertext_1.png',
                                                  height: 100,
                                                  width: 200,
                                                  fit: BoxFit.cover,
                                                );
                                              },
                                            );
                                          } catch (e) {
                                            return Image.asset(
                                              'assets/images/banner_biggertext_1.png',
                                              height: 100,
                                              width: 200,
                                              fit: BoxFit.cover,
                                            );
                                          }
                                        },
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
                          top: 7, left: 5, right: 5, bottom: 5),
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
                            if (currentUser.role != 'donor') ...[
                              const TextSpan(
                                text: 'Donated by: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: '${currentUser.name}\n',
                              ),
                            ],
                            const TextSpan(
                              text: 'Status: ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: '${donations[index]['status']}\n',
                              style: const TextStyle(
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                            const TextSpan(
                              text: 'Description: ',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            TextSpan(
                              text: donations[index]['description'],
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          style: ButtonStyle(
                            elevation: WidgetStateProperty.all(0),
                          ),
                          onPressed: () {
                            // convert donation drive map to donation drive object
                            Donation donation =
                                Donation.fromJson(donations[index].data());

                            // Implement view full details functionality
                            context
                                .read<DonationProvider>()
                                .changeSelectedDonation(donation);
                            context
                                .read<DonationProvider>()
                                .changeSelectedDonor(currentUser);
                            Navigator.pushNamed(
                              context,
                              DonationDetails.route.path,
                            );
                          },
                          child: const Text('View Full Details'),
                        ),
                        Row(
                          children: [
                            if (currentUser.role == 'donor')
                              IconButton(
                                icon: const Icon(Icons.edit),
                                onPressed: () {
                                  Donation donation = Donation.fromJson(
                                      donations[index].data());
                                  // Implement edit functionality
                                  context
                                      .read<DonationProvider>()
                                      .changeSelectedDonation(donation);
                                  context
                                      .read<DonationProvider>()
                                      .changeSelectedDonor(context
                                          .read<AuthProvider>()
                                          .currentUser);
                                  Navigator.pushNamed(
                                      context, "/edit-donation");
                                },
                              ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                // Show confirmation dialog before deletion
                                showDialog(
                                  context: context,
                                  barrierDismissible: false,
                                  builder: (BuildContext context) {
                                    return AlertDialog(
                                      title: const Text('Confirm Deletion'),
                                      content: const Text(
                                          'Are you sure you want to delete this donation?'),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            // Dismiss the dialog
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Cancel'),
                                        ),
                                        TextButton(
                                          onPressed: () async {
                                            // Implement delete functionality
                                            print("Deleting");
                                            await context
                                                .read<DonationProvider>()
                                                .deleteDonation();
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              const SnackBar(
                                                  content: Text(
                                                      "Successfully deleted a donation!")),
                                            );
                                            // Close the dialog
                                            Navigator.pop(context);
                                          },
                                          child: const Text('Delete'),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                  ],
                ),
              ),
            ),
          );
        },
        childCount: donations.length,
      ),
    );
  }

  displayAppBar() {
    return const ListPageSliverAppBar(
        title: 'Donations',
        backgroundWidget: ListPageHeader(
          title: 'Manage Donations',
          titleIcon: Icons.volunteer_activism_rounded,
        ));
  }

  @override
  Widget build(BuildContext context) {
    // get current user
    User currentUser = context.watch<AuthProvider>().currentUser;

    // get donations by donor id
    // check if user is a donor or not
    if (currentUser.role == 'donor') {
      context.read<DonationProvider>().fetchDonationsByDonorId(currentUser.id!);
    } else {
      context.read<DonationProvider>().fetchDonations();
    }

    Stream<QuerySnapshot> donations =
        context.watch<DonationProvider>().donations;

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          displayAppBar(),
          const SliverToBoxAdapter(
            child: SizedBox(height: 10),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: donations,
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
                      "No Donations found",
                      style: GoogleFonts.poppins(
                        fontWeight: FontWeight.bold,
                        color: const Color.fromARGB(255, 247, 129, 139),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }

              return displayDonationList(snapshot.data!.docs, currentUser);
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
                    child: StreamBuilder<QuerySnapshot>(
                      stream: donations,
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text("Error: ${snapshot.error}");
                        } else if (!snapshot.hasData) {
                          return const Text("Donations: 0");
                        } else {
                          int count = snapshot.data!.docs.length;
                          return Text("Donations: $count");
                        }
                      },
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
