import 'package:elbi_donation_system/components/main_drawer.dart';
import 'package:elbi_donation_system/dummy_data/dummy_users.dart';
import 'package:elbi_donation_system/models/route_model.dart';
import 'package:elbi_donation_system/models/user_model.dart';
import 'package:elbi_donation_system/providers/user_list_provider.dart';
import 'package:elbi_donation_system/providers/user_provider.dart';
import 'package:elbi_donation_system/screens/donor_list_page.dart';
import 'package:elbi_donation_system/screens/org_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:elbi_donation_system/dummy_data/dummy_orgs.dart';
import 'package:provider/provider.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  @override
  Widget build(BuildContext context) {
    List<User> organizations =
        dummyUsers.where((user) => user.role == User.organization).toList();

    return Scaffold(
      drawer: MainDrawer(
        routes: [
          RouteModel("Logout", "/login"),
          RouteModel("Organization Account Approval", "/org-account-approval"),
          DonorListPage.route
        ],
      ),
      appBar: AppBar(
        title: const Text("Admin Home Page"),
      ),
      body: ListView.builder(
        itemCount: organizations.length,
        itemBuilder: (context, index) {
          final organization = organizations[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(organization.profilePhoto!),
              ),
              title: Text(organization.name),
              subtitle: Text(
                  organization.about ?? "This organization has no description"),
              trailing: ElevatedButton(
                onPressed: () {
                  // Link Org Profile page
                  context.read<UserProvider>().changeSelectedUser(organization);

                  Navigator.pushNamed(context, "/org-profile");
                },
                child: const Text("View Org"),
              ),
            ),
          );
        },
      ),
    );
  }
}
