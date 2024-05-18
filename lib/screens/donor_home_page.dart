import 'package:elbi_donation_system/components/main_drawer.dart';
import 'package:elbi_donation_system/dummy_data/dummy_orgs.dart';
import 'package:elbi_donation_system/dummy_data/dummy_users.dart';
import 'package:elbi_donation_system/models/route_model.dart';
import 'package:elbi_donation_system/models/user_model.dart';
import 'package:elbi_donation_system/providers/user_list_provider.dart';
import 'package:elbi_donation_system/screens/donation_drive_list_page.dart';
import 'package:elbi_donation_system/screens/donation_list_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../components/page_cover.dart';

class DonorHomePage extends StatefulWidget {
  const DonorHomePage({super.key});

  @override
  State<DonorHomePage> createState() => _DonorHomePageState();
}

class _DonorHomePageState extends State<DonorHomePage> {
  final _formKey = GlobalKey<FormState>();

  final List<User> organizations =
      dummyUsers.where((user) => user.role == User.organization).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(routes: [
        RouteModel("Logout", "/login"),
        RouteModel("Home", "/"),
        DonationListPage.route,
      ]),
      appBar: AppBar(
        title: const Text("Donor Home Page"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const PageCover(),
              const Padding(
                padding: EdgeInsets.all(30),
                child: Center(
                  child: Text(
                    "Want to Donate Something?",
                    style: TextStyle(
                      fontSize: 30,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              const Center(
                child: SizedBox(
                  width: 200,
                  height: 90,
                  child: Text(
                    "Here are the available organizations you can contact for donation:",
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              ListView.builder(
                  reverse: true,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: organizations.length,
                  itemBuilder: (context, index) {
                    return Card(
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 20),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Center(
                              child: Image.network(
                                organizations[index].profilePhoto!,
                                fit: BoxFit.cover,
                                width: MediaQuery.of(context).size.width / 1.5,
                              ),
                            ),
                            Center(child: Text(organizations[index].name)),
                            Center(
                                child: Text(organizations[index].about ??
                                    "This organization has no tagline.")),
                            Center(
                              child: ElevatedButton(
                                onPressed: () {
                                  context
                                      .read<UserListProvider>()
                                      .changeCurrentUser(
                                          organizations[index].email,
                                          organizations[index].password);
                                  Navigator.pushNamed(
                                    context,
                                    "/org-profile",
                                  );
                                },
                                child: const Text("View Org"),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
