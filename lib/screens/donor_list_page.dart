import 'package:flutter/material.dart';
import '../models/route_model.dart';
import '../models/user_model.dart';
import '../components/rounded_image.dart';
import '../dummy_data/dummy_users.dart';

class DonorListPage extends StatefulWidget {
  const DonorListPage({super.key});

  // class route model
  static final RouteModel _donorListPage = RouteModel(
    "Donor List Page",
    "/donor-list-page",
  );
  static RouteModel get route => _donorListPage;

  @override
  State<DonorListPage> createState() => _DonorListPageState();
}

class _DonorListPageState extends State<DonorListPage> {
  // page specifications
  // List of donors
  // Each tile/card must have
  //   Donor image
  //   Donor Name
  //   View Donor button
  //   Link to Donor Profile Page

  // get dummy data for donors
  List<User> users = dummyUsers;
  // only get the donors
  List<User> donors = List.generate(
          10, (context) => dummyUsers.where((user) => user.role == 'donor'))
      .expand((list) => list)
      .toList();

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

    // build a widget that returns a list of donors
    Widget displayDonorList() {
      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return Padding(
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 4, bottom: 10),
              child: Container(
                height: 100,
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
                      child: ListTile(
                        leading: RoundedImage(
                          source: donors[index].profilePhoto!,
                          size: 50,
                        ),
                        title: Text(donors[index].name),
                        subtitle: Text(
                          donors[index].username,
                          style: const TextStyle(fontStyle: FontStyle.italic),
                        ),
                        trailing: ElevatedButton(
                          style: ButtonStyle(
                            elevation: WidgetStateProperty.all(0),
                            shape:
                                WidgetStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20.0),
                              ),
                            ),
                            overlayColor: WidgetStateProperty.resolveWith(
                              (states) {
                                return states.contains(WidgetState.pressed)
                                    ? Theme.of(context).cardColor
                                    : null;
                              },
                            ),
                          ),
                          onPressed: () {
                            // Navigate to donor's profile page
                          },
                          child: const Text('View Profile'),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
          childCount: donors.length,
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
                child: const Text("Donation List Page"),
              ),
              centerTitle: false,
              background: displayHeader(),
            );
          },
        ),
      );
    }

    Widget displayFooter() {
      return Container(
        height: 20,
        decoration: BoxDecoration(color: Theme.of(context).cardColor),
        child: Center(
          child: Text(
            "Donors: ${donors.length}",
            style: const TextStyle(fontSize: 12),
          ),
        ),
      );
    }

    return Scaffold(
      // appBar: AppBar(title: const Text('Donation List Page')),
      body: CustomScrollView(
        slivers: [
          displayAppBar(),
          const SliverToBoxAdapter(
            child: SizedBox(height: 10),
          ),
          displayDonorList(),
          SliverToBoxAdapter(
            child: displayFooter(),
          ),
        ],
      ),
    );
  }
}
