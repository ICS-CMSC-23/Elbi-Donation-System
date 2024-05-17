import 'package:flutter/material.dart';
import 'package:elbi_donation_system/components/main_drawer.dart';
import 'package:elbi_donation_system/dummy_data/dummy_orgs.dart';
import 'package:elbi_donation_system/models/route_model.dart';

class OrgAccApprovalPage extends StatefulWidget {
  const OrgAccApprovalPage({super.key});

  @override
  State<OrgAccApprovalPage> createState() => _OrgAccApprovalPageState();
}

class _OrgAccApprovalPageState extends State<OrgAccApprovalPage> {
  final _formKey = GlobalKey<FormState>();

  final organizations = dummyOrgs; // Dummy data for organizations

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(routes: [
        RouteModel("Home", "/"),
        RouteModel("Profile", "/donor-profile"),
        RouteModel("Logout", "/login"),
      ]),
      appBar: AppBar(
        title: const Text("Organization Account Approval Page"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
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
                            organizations[index].imageUrl,
                            fit: BoxFit.cover,
                            width: MediaQuery.of(context).size.width / 1.5,
                          ),
                          Text(
                            organizations[index].name,
                            style: const TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          Text(
                            organizations[index].description,
                            textAlign: TextAlign.center,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    '/org-profile',
                                    arguments: organizations[index],
                                  );
                                },
                                child: const Text("View Org Details"),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  // Approve action
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          "${organizations[index].name} approved"),
                                    ),
                                  );
                                },
                                child: const Text("Approve"),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  // Disapprove action
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          "${organizations[index].name} disapproved"),
                                    ),
                                  );
                                },
                                child: const Text("Disapprove"),
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
}
