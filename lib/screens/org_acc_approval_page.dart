import 'package:elbi_donation_system/dummy_data/dummy_users.dart';
import 'package:elbi_donation_system/models/user_model.dart';
import 'package:elbi_donation_system/providers/user_list_provider.dart';
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

  final List<User> organizations = dummyUsers
      .where((user) => user.role == User.organization)
      .toList(); // Dummy data for organizations

  @override
  Widget build(BuildContext context) {
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
              ListView.builder(
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
                          Image.network(
                            organizations[index].profilePhoto!,
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width / 1.5,
                          ),
                          Text(
                            organizations[index].name,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          Text(
                            organizations[index].about ??
                                "This organization has no description.",
                            textAlign: TextAlign.center,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton.icon(
                                onPressed: () {
                                  context
                                      .read<UserListProvider>()
                                      .changeCurrentUser(
                                        organizations[index].email,
                                      );
                                  Navigator.pushNamed(
                                    context,
                                    '/org-profile',
                                    arguments: organizations[index],
                                  );
                                },
                                icon: const Icon(Icons.info),
                                label: const Text("View Org Details"),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  _showConfirmationDialog(
                                    context,
                                    organizations[index].name,
                                    "approve",
                                    () {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              "${organizations[index].name} approved"),
                                        ),
                                      );
                                      Navigator.of(context).pop();
                                    },
                                  );
                                },
                                child: const Icon(Icons.check,
                                    color: Colors.green),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  _showConfirmationDialog(
                                    context,
                                    organizations[index].name,
                                    "disapprove",
                                    () {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          content: Text(
                                              "${organizations[index].name} disapproved"),
                                        ),
                                      );
                                      Navigator.of(context).pop();
                                    },
                                  );
                                },
                                child:
                                    const Icon(Icons.close, color: Colors.red),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
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
