import 'package:elbi_donation_system/components/main_drawer.dart';
import 'package:elbi_donation_system/models/route_model.dart';
import 'package:elbi_donation_system/screens/log_in_page.dart';
import 'package:flutter/material.dart';

class OrgHomePage extends StatefulWidget {
  const OrgHomePage({super.key});

  @override
  State<OrgHomePage> createState() => _OrgHomePageState();
}

class _OrgHomePageState extends State<OrgHomePage> {
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
        title: const Text("Organization Home Page"),
      ),
      body: Form(
        key: _formKey,
        child: const Center(child: Text("Insert something here")),
      ),
    );
  }
}
