import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/route_model.dart';
import '../../models/donation_model.dart';
import '../../dummy_data/dummy_donations.dart';
import '../../providers/user_list_provider.dart';
import '../../models/user_model.dart';
import '../../components/bottom_scroll_view_widget.dart';

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

    Widget createTextWithStyle(String text, TextStyle style) {
      return RichText(
        text: TextSpan(
          // Note: Styles for TextSpans must be explicitly defined.
          // Child text spans will inherit styles from parent
          style: const TextStyle(
            fontSize: 14.0,
            color: Colors.black,
          ),
          children: <TextSpan>[
            TextSpan(
              text: text,
              style: style,
            ),
          ],
        ),
      );
    }

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
                            Padding(
                              padding: const EdgeInsets.only(
                                  top: 7, left: 5, right: 5, bottom: 5),
                              child: RichText(
                                textAlign: TextAlign.justify,
                                text: TextSpan(
                                  style: TextStyle(
                                    // fontSize: 14.0,
                                    color:
                                        Theme.of(context).colorScheme.onSurface,
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
                                      text: '${donations[index].description}',
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
                                        // Implement delete functionality
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
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  flex: 1,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width / 3,
                    child: const Center(
                        child: Icon(
                      Icons.volunteer_activism_rounded,
                      size: 100,
                    )),
                  ),
                ),
                // space
                const SizedBox(width: 10),
                const Flexible(
                  flex: 3,
                  child: Text(
                    "Manage Donations",
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

    return Scaffold(
      body: CustomScrollView(
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
    );
  }
}
