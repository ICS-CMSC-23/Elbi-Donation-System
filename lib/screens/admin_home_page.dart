import 'package:elbi_donation_system/components/main_drawer.dart';
import 'package:elbi_donation_system/models/route_model.dart';
import 'package:flutter/material.dart';
import 'package:elbi_donation_system/dummy_data/dummy_orgs.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(
        routes: [
          RouteModel("Org Profile Test", "/org-profile"),
          RouteModel("Donor Profile Test", "/donor-profile"),
          RouteModel("Logout", "/login"),
        ],
      ),
      appBar: AppBar(
        title: const Text("Admin Home Page"),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              // Navigate to Profile Page
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: dummyOrgs.length,
        itemBuilder: (context, index) {
          final organization = dummyOrgs[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: NetworkImage(organization.imageUrl),
              ),
              title: Text(organization.name),
              subtitle: Text(organization.description),
              trailing: ElevatedButton(
                onPressed: () {
                  // Link Org Profile page
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
