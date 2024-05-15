import 'package:flutter/material.dart';
import '../components/main_drawer.dart';
import '../models/route_model.dart';
import '../models/organization_model.dart';

class OrgHomePage extends StatefulWidget {
  const OrgHomePage({super.key});

  // class route model
  static final RouteModel _orgHomePage = RouteModel(
    "Organization Home Page",
    "/org-home-page",
  );
  static RouteModel get route => _orgHomePage;

  @override
  State<OrgHomePage> createState() => _OrgHomePageState();
}

// sample organization datum
Organization organizationA = Organization(
  id: "1",
  name: "Elbi Donation System",
  about: "A donation system for the people of Los Baños",
  proofOfLegitimacy: ["BIR Registration"],
  isApproved: true,
  isOpenForDonation: true,
);

class _OrgHomePageState extends State<OrgHomePage> {
  final _formKey = GlobalKey<FormState>();
  // // generate dummy data for donations and donation drives
  // List<Donation> donations = List.generate(20, (index) {
  //   return Donation(
  //     category: DonationCategory.values
  //         .elementAt(Random().nextInt(DonationCategory.values.length)),
  //     donorId: "Donor $index",
  //     donorContactNo: "0912-345-67$index",
  //     dateTime: DateTime.now().subtract(Duration(days: index)),
  //     address: "Address $index",
  //     isPickup: false,
  //     weightInKg: Random().nextDouble() * 10.0,
  //     photoUrl: "https://via.placeholder.com/150",
  //     status: DonationStatus.values
  //         .elementAt(Random().nextInt(DonationStatus.values.length)), donorId: '',
  //   );
  // });

  // List<DonationDrive> donationDrives = List.generate(20, (index) {
  //   return DonationDrive(
  //     organizationId: organizationA,
  //     id: "DD-$index",
  //     name: "Donation Drive $index",
  //     photos: List.generate(2, (photoIndex) {
  //       return "https://via.placeholder.com/150";
  //     }),
  //     donations: [], description: organizationA.about,
  //   );
  // });

  // // scrollable list of donations
  // Widget donationList() {
  //   return ListView.builder(
  //     itemCount: donations.length,
  //     itemBuilder: (context, index) {
  //       // https://stackoverflow.com/questions/51508438/flutter-inkwell-does-not-work-with-card
  //       return Card(
  //         child: InkWell(
  //           borderRadius: BorderRadius.circular(8),
  //           splashColor: Colors.blue,
  //           onTap: () {
  //             // navigate to donation details page
  //             Navigator.pushNamed(
  //               context,
  //               DonationDetails.route.path,
  //             );
  //           },
  //           child: ListTile(
  //             leading: CircleAvatar(
  //               backgroundImage: NetworkImage(donations[index].photoUrl!),
  //             ),
  //             title: Text(donations[index].donorName.toString()),
  //             subtitle: Text(donations[index].category.name),
  //             trailing: Text(donations[index].status.name),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  // // horizontal scrollable list of donation drives
  // Widget donationDriveList() {
  //   return ListView.builder(
  //     scrollDirection: Axis.horizontal,
  //     itemCount: donationDrives.length,
  //     itemBuilder: (context, index) {
  //       return Card(
  //         // elevation: 2,
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.circular(8),
  //         ),
  //         child: InkWell(
  //           borderRadius: BorderRadius.circular(8),
  //           splashColor: Colors.blue,
  //           onTap: () {
  //             // navigate to donation drive details page
  //             Navigator.pushNamed(
  //               context,
  //               DonationDriveDetails.route.path,
  //             );
  //           },
  //           child: Column(
  //             children: [
  //               Image.network(donationDrives[index].photos[0]),
  //               Text(donationDrives[index].name.toString()),
  //             ],
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(routes: [
        RouteModel("Logout", "/login"),
      ]),
      appBar: AppBar(
        title: Text(OrgHomePage.route.name),
      ),
      body: Form(
        key: _formKey,
        // insert widgets here
        child: Column(
          children: [
            Text(organizationA.name),
            Text(organizationA.about),
            // Expanded(
            //   flex: 7,
            //   child: donationDriveList(),
            // ),
            // Expanded(
            //   flex: 10,
            //   child: donationList(),
            // ),
          ],
        ),
      ),
    );
  }
}
