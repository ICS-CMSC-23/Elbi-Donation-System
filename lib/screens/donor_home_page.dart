import 'package:elbi_donation_system/components/main_drawer.dart';
import 'package:elbi_donation_system/models/route_model.dart';
import 'package:elbi_donation_system/screens/log_in_page.dart';
import 'package:elbi_donation_system/screens/org_home_page.dart';
import 'package:flutter/material.dart';

class DonorHomePage extends StatefulWidget {
  const DonorHomePage({super.key});

  @override
  State<DonorHomePage> createState() => _DonorHomePageState();
}

class _DonorHomePageState extends State<DonorHomePage> {
  final _formKey = GlobalKey<FormState>();
  RouteModel orgHomepage =
      RouteModel("Home", "/org-home-page", const OrgHomePage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(routes: [
        orgHomepage,
        RouteModel("Logout", "/", const LoginPage()),
      ]),
      appBar: AppBar(
        title: const Text("Donor Home Page"),
      ),
      body: Form(
        key: _formKey,
        child: const Center(child: Text("Insert something here")),
      ),
    );
  }
}
