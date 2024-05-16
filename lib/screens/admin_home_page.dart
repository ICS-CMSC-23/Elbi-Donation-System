import 'package:elbi_donation_system/components/main_drawer.dart';
import 'package:elbi_donation_system/models/route_model.dart';
import 'package:flutter/material.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: MainDrawer(routes: [
          RouteModel("Org Profile Test", "/org-profile"),
          RouteModel("Donor Profile Test", "/donor-profile"),
          RouteModel("Logout", "/login"),
        ]),
        appBar: AppBar(
          title: const Text("Admin Home Page"),
        ),
        body: const Center(
          child: Text("Insert here"),
        ));
  }
}
