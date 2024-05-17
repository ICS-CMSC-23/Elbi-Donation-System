import 'package:flutter/material.dart';
import '../../models/route_model.dart';
import '../../models/donation_drive_model.dart';
import '../../dummy_data/dummy_donation_drives.dart';
import '../../components/bottom_scroll_view_widget.dart';
import '../../components/list_page_sliver_app_bar.dart';
import '../../components/list_page_header.dart';
import '../../components/custom_tile_container.dart';
import '../../screens/donation_drive_details_page.dart';

class DonationDriveListPage extends StatefulWidget {
  const DonationDriveListPage({super.key});

  // class route model
  static final RouteModel _donationDriveListPage = RouteModel(
    "Donation Drive List Page",
    "/donation-drive-list-page",
  );
  static RouteModel get route => _donationDriveListPage;

  @override
  State<DonationDriveListPage> createState() => _DonationDriveListPageState();
}

class _DonationDriveListPageState extends State<DonationDriveListPage> {
  // get dummy data for donation drives
  List<DonationDrive> donationDrives = dummyDonationDrives;

  @override
  Widget build(BuildContext context) {
    Widget displayDonationDriveList() {
      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            // bool hasPhotos = donations[index].photos != null && donations[index].photos!.isNotEmpty;
            return CustomTileContainer(
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
                              donationDrives[index].name,
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
                              children: [
                                for (int i = 0;
                                    i < donationDrives[index].photos!.length;
                                    i++)
                                  Padding(
                                    padding: i <
                                            donationDrives[index]
                                                    .photos!
                                                    .length -
                                                1
                                        ? const EdgeInsets.only(right: 8.0)
                                        : EdgeInsets.zero,
                                    child: Container(
                                      height: 100,
                                      width: 200,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          image: Image.network(
                                                  donationDrives[index]
                                                      .photos![i])
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
                                      '${donationDrives[index].startDate.toString().substring(0, 10)}\n',
                                ),
                                const TextSpan(
                                  text: 'End Date:\t\t\t',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                TextSpan(
                                  text: donationDrives[index]
                                      .endDate
                                      .toString()
                                      .substring(0, 10),
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
                        // Implement view full details functionality
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

    return Scaffold(
      body: CustomScrollView(
        // physics: const BouncingScrollPhysics(),
        slivers: [
          displayAppBar(),
          const SliverToBoxAdapter(
            child: SizedBox(height: 10),
          ),
          displayDonationDriveList(),
          BottomScrollViewWidget(
              listTitle: 'Donation Drives', listLength: donationDrives.length),
        ],
      ),
    );
  }
}
