import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elbi_donation_system/components/main_drawer.dart';
import 'package:elbi_donation_system/models/route_model.dart';
import 'package:elbi_donation_system/models/user_model.dart';
import 'package:elbi_donation_system/providers/auth_provider.dart';
import 'package:elbi_donation_system/providers/user_provider.dart';
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

  @override
  Widget build(BuildContext context) {
    final currentUser = context.watch<AuthProvider>().currentUser;

    Stream<QuerySnapshot> orgStream = FirebaseFirestore.instance.collection('users')
        .where('role', isEqualTo: 'organization')
        .snapshots();

    return Scaffold(
      drawer: MainDrawer(routes: [
        RouteModel("Logout", "/login"),
        RouteModel("Home", "/"),
        DonationListPage.route,
      ]),
      appBar: AppBar(
        title: const Text("Donor Home Page"),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              // Navigate to Donor Profile Page
              Navigator.pushNamed(
                context,
                "/donor-profile",
              );
            },
          ),
        ],
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
              StreamBuilder<QuerySnapshot>(
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
                    return User.fromJson(doc.data() as Map<String, dynamic>);
                  }).toList();

                  return ListView.builder(
                    reverse: true,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: organizations.length,
                    itemBuilder: (context, index) {
                      final organization = organizations[index];
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Center(
                                child: Image.network(
                                  organization.profilePhoto ?? 'https://via.placeholder.com/150',
                                  fit: BoxFit.cover,
                                  width: MediaQuery.of(context).size.width / 1.5,
                                ),
                              ),
                              Center(child: Text(organization.name)),
                              Center(
                                  child: Text(organization.about ?? "This organization has no tagline.")),
                              Center(
                                child: ElevatedButton(
                                  onPressed: () {
                                    WidgetsBinding.instance.addPostFrameCallback((_) {
                                      context.read<UserProvider>().changeSelectedUser(
                                        organization,
                                      );
                                      Navigator.pushNamed(
                                        context,
                                        "/org-profile",
                                      );
                                    });
                                  },
                                  child: const Text("View Org"),
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
