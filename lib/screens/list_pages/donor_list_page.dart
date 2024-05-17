import 'package:flutter/material.dart';
import '../../models/route_model.dart';
import '../../models/user_model.dart';
import '../../components/rounded_image.dart';
import '../../dummy_data/dummy_users.dart';
import '../../components/bottom_scroll_view_widget.dart';
import '../../components/list_page_sliver_app_bar.dart';
import '../../components/list_page_header.dart';

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
                            Navigator.pushNamed(context, '/donation-list-page');
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

    displayAppBar() {
      return const ListPageSliverAppBar(
          title: "Donors",
          backgroundWidget:
              ListPageHeader(title: "Manage Donors", titleIcon: Icons.people));
    }

    return Scaffold(
      body: CustomScrollView(
        // physics: const BouncingScrollPhysics(),
        slivers: [
          displayAppBar(),
          const SliverToBoxAdapter(
            child: SizedBox(height: 10),
          ),
          displayDonorList(),
          BottomScrollViewWidget(
              listTitle: 'Donors', listLength: donors.length),
        ],
      ),
    );
  }
}
