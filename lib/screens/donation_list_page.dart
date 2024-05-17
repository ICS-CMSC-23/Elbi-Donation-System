import 'package:flutter/material.dart';
import '../models/route_model.dart';
import '../models/donation_model.dart';
import '../dummy_data/dummy_donations.dart';

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

    Widget displayDonationList() {
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
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(20.0),
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
                                        padding: i <
                                                donations[index]
                                                        .photos!
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
                                              image: Image.network(
                                                      donations[index]
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
                            Text("Donated by: Donor ${index}"),
                            Text("Status: ${donations[index].status}"),
                            Text(
                                "Description: ${donations[index].description}"),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
          childCount: donations.length,
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
                    Icons.people_rounded,
                    size: 100,
                  )),
                ),
                const Flexible(
                  child: Text(
                    "Manage Donors",
                    style: TextStyle(fontSize: 30),
                  ),
                )
              ],
            ),
          ],
        ),
      );
    }

    displayAppBar() {
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
                child: Text(DonationListPage.route.name),
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
                  "Donations: ${donations.length}",
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
        slivers: [
          displayAppBar(),
          const SliverToBoxAdapter(
            child: SizedBox(height: 10),
          ),
          displayDonationList(),
          displayFooter(),
        ],
      ),
    );
  }
}
