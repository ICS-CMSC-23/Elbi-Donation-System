import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../components/rounded_image.dart';
import '../components/custom_tile_container.dart';
import '../components/list_page_sliver_app_bar.dart';
import '../components/list_page_header.dart';
import '../models/route_model.dart';
import '../models/user_model.dart';
import '../providers/user_provider.dart';
import '../screens/donor_profile_page.dart';

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
  // only get the donors
  // List<User> donors = dummyUsers.where((user) => user.role == 'donor').toList();

  // build a widget that returns a list of donors
  Widget displayDonorList(donors) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (BuildContext context, int index) {
          return CustomTileContainer(
            customBorder: CustomTileContainer.customBorderOne,
            customBorderAlt: CustomTileContainer.customBorderTwo,
            context: context,
            index: index,
            child: Stack(
              children: [
                Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 20),
                    child: ListTile(
                      leading: RoundedImage(
                        source: donors[index]['profilePhoto'],
                        size: 50,
                      ),
                      title: Text(
                        donors[index]['email'],
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            donors[index]['contactNo'],
                          ),
                          Text(
                            donors[index]['username'],
                            style: const TextStyle(fontStyle: FontStyle.italic),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 10,
                  bottom: 15,
                  child: ElevatedButton(
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
                      // convert the map to a User object
                      User user = User.fromJson(donors[index].data());

                      // Navigate to donor's profile page
                      context.read<UserProvider>().changeSelectedUser(user);
                      Navigator.pushNamed(context, DonorProfilePage.route.path);
                      // Navigator.pushNamed(context, '/donation-list-page'); // for testing
                    },
                    child: const Text('View Profile'),
                  ),
                ),
              ],
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

  @override
  Widget build(BuildContext context) {
    // get users that are donors
    Stream<QuerySnapshot> donors = FirebaseFirestore.instance
        .collection('users')
        .where('role', isEqualTo: 'donor')
        .snapshots();

    return Scaffold(
      body: CustomScrollView(
        // semanticChildCount: 10,
        // physics: const BouncingScrollPhysics(),
        slivers: [
          displayAppBar(),
          const SliverToBoxAdapter(
            child: SizedBox(height: 10),
          ),
          StreamBuilder<QuerySnapshot>(
            stream: donors,
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

              return displayDonorList(snapshot.data!.docs);
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
                      stream: donors,
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text("Error: ${snapshot.error}");
                        } else if (!snapshot.hasData) {
                          return const Text("Donors: 0");
                        } else {
                          int count = snapshot.data!.docs.length;
                          return Text("Donors: $count");
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
