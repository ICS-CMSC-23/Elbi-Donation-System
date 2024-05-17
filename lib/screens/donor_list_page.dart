import 'package:elbi_donation_system/components/rounded_image.dart';
import 'package:flutter/material.dart';
import '../models/route_model.dart';
import '../models/user_model.dart';
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

  // List<User> donors = List.generate(20, (index) {
  //   return User(
  //     id: "donor_$index",
  //     name: "Donor ${index + 1}",
  //     username: "donor${index + 1}_username",
  //     email: "donor${index + 1}@example.com",
  //     password: "password${index + 1}",
  //     address: ["Address ${index + 1}"],
  //     contactNo: "+123456789${index + 1}",
  //     role: UserRole.donor.toString(),
  //     profilePhoto:
  //         "https://i.pinimg.com/originals/f5/24/e1/f524e1e728b829b039c84f5ee4f1478a.webp",
  //   );
  // });

  @override
  Widget build(BuildContext context) {
    // build a widget that returns a list of donors
    Widget displayDonorList() {
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

      return ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: donors.length,
        itemBuilder: (context, index) {
          return Padding(
            padding:
                const EdgeInsets.only(left: 10, right: 10, top: 4, bottom: 10),
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                borderRadius: (index % 2 == 0) ? customBorder : customBorderAlt,
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
                                  borderRadius: BorderRadius.circular(20.0)),
                            ),
                            overlayColor:
                                WidgetStateProperty.resolveWith((states) {
                              return states.contains(WidgetState.pressed)
                                  ? Theme.of(context).cardColor
                                  : null;
                            })),
                        onPressed: () {
                          // Navigate to donor profile page
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
      );
    }

    Widget displayHeader() {
      return Container(
        decoration: BoxDecoration(color: Theme.of(context).cardColor),
        child: Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              height: 200,
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
      );
    }

    // build a widget that returns a column of widgets in singlescrollview
    Widget buildSingleChildScrollView() {
      return SingleChildScrollView(
        child: Column(
          children: [
            displayHeader(),
            const SizedBox(height: 20),
            displayDonorList(),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Donation List Page')),
      body: Container(
        child: buildSingleChildScrollView(),
      ),
    );
  }
}
