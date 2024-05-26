import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elbi_donation_system/components/square_image.dart';
import 'package:elbi_donation_system/models/user_model.dart';
import 'package:elbi_donation_system/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:elbi_donation_system/themes/purple_theme.dart';

class OrgAccApprovalPage extends StatefulWidget {
  const OrgAccApprovalPage({super.key});

  @override
  State<OrgAccApprovalPage> createState() => _OrgAccApprovalPageState();
}

class _OrgAccApprovalPageState extends State<OrgAccApprovalPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Stream<QuerySnapshot> orgStream = FirebaseFirestore.instance
        .collection('users')
        .where('role', isEqualTo: 'organization')
        .where('isApproved', isEqualTo: false)
        .snapshots();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Org Account Approval"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                  "This is where you approve or disapprove organization accounts as an admin.",
                  style: TextStyle(fontSize: 16),
                  textAlign: TextAlign.center,
                ),
              ),
              StreamBuilder<QuerySnapshot>(
                stream: orgStream,
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Center(
                      child: Text("Error: ${snapshot.error}"),
                    );
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return const Center(
                      child: Text("No organizations found."),
                    );
                  }

                  var organizations = snapshot.data!.docs.map((doc) {
                    Map<String, dynamic> docMap =
                        doc.data() as Map<String, dynamic>;
                    docMap["id"] = doc.id;
                    return User.fromJson(docMap);
                  }).toList();

                  return ListView.builder(
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
                              SquareImage(
                                  source: organization.profilePhoto,
                                  size:
                                      MediaQuery.of(context).size.width / 1.5),
                              Text(
                                organization.name,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                              Text(
                                organization.about ??
                                    "This organization has no description.",
                                textAlign: TextAlign.center,
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    ElevatedButton.icon(
                                      onPressed: () {
                                        context
                                            .read<UserProvider>()
                                            .changeSelectedUser(organization);
                                        Navigator.pushNamed(
                                          context,
                                          '/org-profile',
                                          arguments: organization,
                                        );
                                      },
                                      icon: const Icon(Icons.info),
                                      label: const Text("View Org Details"),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        _showConfirmationDialog(
                                          context,
                                          organization.name,
                                          "approve",
                                          () {
                                            FirebaseFirestore.instance
                                                .collection('users')
                                                .doc(organization.id)
                                                .update({'isApproved': true});
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                    "${organization.name} approved"),
                                              ),
                                            );
                                            Navigator.of(context).pop();
                                          },
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Colors.lightGreen,
                                      ),
                                      child: const Icon(Icons.check_rounded,
                                          color: Colors.white),
                                    ),
                                    ElevatedButton(
                                      onPressed: () {
                                        _showConfirmationDialog(
                                          context,
                                          organization.name,
                                          "disapprove",
                                          () {
                                            FirebaseFirestore.instance
                                                .collection('users')
                                                .doc(organization.id)
                                                .update({'isApproved': false});
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                    "${organization.name} disapproved"),
                                              ),
                                            );
                                            Navigator.of(context).pop();
                                          },
                                        );
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: const Color.fromARGB(
                                            255, 240, 84, 72),
                                      ),
                                      child: const Icon(Icons.close_rounded,
                                          color: Colors.white),
                                    ),
                                  ],
                                ),
                              ),
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

  void _showConfirmationDialog(BuildContext context, String orgName,
      String action, VoidCallback onConfirm) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Theme(
          data: purpleTheme(),
          child: AlertDialog(
            title: Text(
              "Confirm $action",
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
            ),
            content: Text(
              "Are you sure you want to $action $orgName?",
              style: const TextStyle(color: Colors.white),
            ),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  "Cancel",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              TextButton(
                onPressed: onConfirm,
                child: const Text(
                  "Confirm",
                  style: TextStyle(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
