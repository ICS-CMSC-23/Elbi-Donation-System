import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/route_model.dart';
import '../models/donation_model.dart';
import '../dummy_data/dummy_donations.dart';
import '../providers/user_list_provider.dart';
import '../models/user_model.dart';
import '../components/bottom_scroll_view_widget.dart';
import '../components/list_page_sliver_app_bar.dart';
import '../components/list_page_header.dart';
import '../components/custom_tile_container.dart';
import '../screens/donation_details_page.dart';

class DonationListPage extends StatefulWidget {
  const DonationListPage({super.key});

  // class route model
  static final RouteModel _donationListPage = RouteModel(
    "Donation List Page",
    "/donation-list-page",
  );
  static RouteModel get route => _donationListPage;

  @override
  State<DonationListPage> createState() => _DonationListPageState();
}

class _DonationListPageState extends State<DonationListPage> {
  // get dummy data for donations
  List<Donation> donations = dummyDonations;

  @override
  Widget build(BuildContext context) {
    // get dummy user data
    final userListProvider = context.watch<UserListProvider>();
    User currentUser = userListProvider.currentUser;

    Widget displayDonationList() {
      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            // bool hasPhotos = donations[index].photos != null && donations[index].photos!.isNotEmpty;
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
                            children: [
                              for (int i = 0;
                                  i < donations[index].photos!.length;
                                  i++)
                                Padding(
                                  padding:
                                      i < donations[index].photos!.length - 1
                                          ? const EdgeInsets.only(right: 8.0)
                                          : EdgeInsets.zero,
                                  child: Container(
                                    height: 100,
                                    width: 200,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: Image.network(
                                                donations[index].photos![i])
                                            .image,
                                        fit: BoxFit.cover,
                                      ),
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
                              const TextSpan(
                                text: 'Donated by: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: 'Donor $index\n',
                              ),
                              const TextSpan(
                                text: 'Status: ',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              TextSpan(
                                text: '${donations[index].status}\n',
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
                                text: donations[index].description,
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
                              // Implement view full details functionality
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
                                    // Implement edit functionality
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
                                            onPressed: () {
                                              // Implement delete functionality
                                              // not yet implemented
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

    Widget displayAddDonationButton() {
      if (currentUser.role == 'donor') {
        return SizedBox(
          height: 30,
          child: ElevatedButton(
            onPressed: () {
              // Implement the functionality to add a donation
            },
            style: ButtonStyle(
              shape: WidgetStateProperty.all<RoundedRectangleBorder>(
                const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
              ),
              elevation: WidgetStateProperty.all<double>(0),
              backgroundColor: WidgetStateProperty.resolveWith<Color>(
                (Set<WidgetState> states) {
                  if (states.contains(WidgetState.pressed)) {
                    return Theme.of(context)
                        .colorScheme
                        .primary
                        .withOpacity(0.8);
                  }
                  return Theme.of(context).colorScheme.surface;
                },
              ),
            ),
            child: const Center(
              child: Text(
                'Add Donation',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      } else {
        return const SizedBox(); // Return an empty SizedBox if the user is not a donor
      }
    }

    Widget displayAppBar() {
      return const ListPageSliverAppBar(
          title: 'Donations',
          backgroundWidget: ListPageHeader(
            title: 'Manage Donations',
            titleIcon: Icons.volunteer_activism_rounded,
          ));
    }

    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: CustomScrollView(
              slivers: [
                displayAppBar(),
                const SliverToBoxAdapter(
                  child: SizedBox(height: 10),
                ),
                displayDonationList(),
                BottomScrollViewWidget(
                    listTitle: 'Donations', listLength: donations.length),
              ],
            ),
          ),
          displayAddDonationButton(),
        ],
      ),
    );
  }
}
