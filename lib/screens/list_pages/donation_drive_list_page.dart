import 'package:flutter/material.dart';
import '../../models/route_model.dart';
import '../../models/donation_drive_model.dart';
import '../../dummy_data/dummy_donation_drives.dart';

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
    BorderRadius customBorder = const BorderRadius.only(
      topLeft: Radius.circular(30),
      topRight: Radius.circular(4),
      bottomLeft: Radius.circular(4),
      bottomRight: Radius.circular(30),
    );

    BorderRadius customBorderAlt = const BorderRadius.only(
      topLeft: Radius.circular(4),
      topRight: Radius.circular(30),
      bottomLeft: Radius.circular(30),
      bottomRight: Radius.circular(4),
    );

    Widget displayDonationDriveList() {
      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            // bool hasPhotos = donations[index].photos != null && donations[index].photos!.isNotEmpty;
            return Padding(
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 4, bottom: 10),
              child: Container(
                // height: 200,
                decoration: BoxDecoration(
                  borderRadius:
                      (index % 2 == 0) ? customBorder : customBorderAlt,
                  color: Theme.of(context).colorScheme.surface, // white
                ),
                child: Card(
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius:
                        (index % 2 == 0) ? customBorder : customBorderAlt,
                  ),
                  child: InkWell(
                    splashColor: Theme.of(context).colorScheme.primary,
                    borderRadius:
                        (index % 2 == 0) ? customBorder : customBorderAlt,
                    onTap: () {/*for effects only*/},
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 15, left: 20, right: 20, bottom: 15),
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
                                          i <
                                              donationDrives[index]
                                                  .photos!
                                                  .length;
                                          i++)
                                        Padding(
                                          padding: i <
                                                  donationDrives[index]
                                                          .photos!
                                                          .length -
                                                      1
                                              ? const EdgeInsets.only(
                                                  right: 8.0)
                                              : EdgeInsets.zero,
                                          child: Container(
                                            height: 100,
                                            width: 200,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(10),
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
                                      color: Theme.of(context)
                                          .colorScheme
                                          .onSurface,
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
                          right: 10,
                          child: ElevatedButton(
                            style: ButtonStyle(
                              elevation: WidgetStateProperty.all(0),
                            ),
                            onPressed: () {
                              // Implement view full details functionality
                            },
                            child: const Text('View Full Details'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
          childCount: donationDrives.length,
        ),
      );
    }

    Widget displayHeader() {
      return Container(
        decoration: BoxDecoration(color: Theme.of(context).cardColor),
        child: Column(
          children: [
            const SizedBox(height: 75),
            Row(
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width / 3,
                  height: 125,
                  child: const Center(
                      child: Icon(
                    Icons.real_estate_agent_rounded,
                    size: 100,
                  )),
                ),
                const Flexible(
                  child: Text(
                    "Donation Drives",
                    style: TextStyle(fontSize: 30),
                  ),
                )
              ],
            ),
          ],
        ),
      );
    }

    Widget displayAppBar() {
      return SliverAppBar(
        automaticallyImplyLeading: true,
        elevation: 0,
        pinned: true,
        centerTitle: false,
        expandedHeight: 200,
        flexibleSpace: LayoutBuilder(
          builder: (BuildContext context, BoxConstraints constraints) {
            var top = constraints.biggest.height;
            return FlexibleSpaceBar(
              collapseMode: CollapseMode.parallax,
              title: AnimatedOpacity(
                duration: const Duration(milliseconds: 10),
                opacity: top <= kToolbarHeight + 50 ? 1.0 : 0.0,
                child: Text(DonationDriveListPage.route.name),
              ),
              centerTitle: false,
              background: displayHeader(),
            );
          },
        ),
      );
    }

    Widget displayFooter() {
      return SliverList(
        delegate: SliverChildListDelegate(
          [
            Container(
              decoration: BoxDecoration(color: Theme.of(context).cardColor),
              child: Center(
                child: Text(
                  "Donation Drives: ${donationDrives.length}",
                  style: const TextStyle(fontSize: 12),
                ),
              ),
            ),
          ],
        ),
      );
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
          displayFooter(),
        ],
      ),
    );
  }
}
