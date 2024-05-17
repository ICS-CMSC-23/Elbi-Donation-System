import 'package:flutter/material.dart';
import '../../models/route_model.dart';
import '../../models/user_model.dart';
import '../../components/rounded_image.dart';
import '../../dummy_data/dummy_users.dart';
import '../../components/bottom_scroll_view_widget.dart';
import '../../components/list_page_sliver_app_bar.dart';
import '../../components/list_page_header.dart';
import '../../components/custom_tile_container.dart';

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
    // build a widget that returns a list of donors
    Widget displayDonorList() {
      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            return CustomTileContainer(
              customBorder: CustomTileContainer.customBorderOne,
              customBorderAlt: CustomTileContainer.customBorderTwo,
              context: context,
              index: index,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top: 20, bottom: 20),
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
                        shape: WidgetStateProperty.all<RoundedRectangleBorder>(
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
