import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elbi_donation_system/components/main_drawer.dart';
import 'package:elbi_donation_system/components/rounded_image.dart';
import 'package:elbi_donation_system/models/route_model.dart';
import 'package:elbi_donation_system/models/user_model.dart';
import 'package:elbi_donation_system/providers/user_provider.dart';
import 'package:elbi_donation_system/screens/donor_list_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  @override
  Widget build(BuildContext context) {
    // Fetching the list of organizations from Firestore
    Stream<QuerySnapshot> orgStream = FirebaseFirestore.instance
        .collection('users')
        .where('role', isEqualTo: 'organization')
        .snapshots();

    return Scaffold(
      drawer: MainDrawer(
        routes: [
          RouteModel("Logout", "/login"),
          RouteModel("Organization Account Approval", "/org-account-approval"),
          DonorListPage.route,
        ],
      ),
      appBar: AppBar(
        title: const Text("Admin Home Page"),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: orgStream,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text("Error: ${snapshot.error}"),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text("No organizations found."),
            );
          }

          var organizations = snapshot.data!.docs.map((doc) {
            Map<String, dynamic> docMap = doc.data() as Map<String, dynamic>;
            docMap["id"] = doc.id;
            return User.fromJson(docMap);
          }).toList();

          return ListView.builder(
            itemCount: organizations.length,
            itemBuilder: (context, index) {
              final organization = organizations[index];
              return Card(
                margin:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                child: ListTile(
                  leading: RoundedImage(
                      source: organization.profilePhoto!, size: 50),
                  title: Text(organization.name),
                  subtitle: Text(organization.about ??
                      "This organization has no description"),
                  trailing: ElevatedButton(
                    onPressed: () {
                      // Link Org Profile page
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        context
                            .read<UserProvider>()
                            .changeSelectedUser(organization);
                        Navigator.pushNamed(context, "/org-profile");
                      });
                    },
                    child: const Text("View Org"),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
