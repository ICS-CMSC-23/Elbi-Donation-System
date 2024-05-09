import 'package:elbi_donation_system/components/main_drawer.dart';
import 'package:elbi_donation_system/models/route_model.dart';
import 'package:elbi_donation_system/screens/donor_home_page.dart';
import 'package:elbi_donation_system/screens/log_in_page.dart';
import 'package:elbi_donation_system/screens/org_home_page.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  RouteModel orgHomepage =
      RouteModel("Home", "/org-home-page", const OrgHomePage());
  RouteModel donorHomePage =
      RouteModel("Home", "/donor-home-page", const DonorHomePage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(routes: [
        orgHomepage,
        RouteModel("Logout", "/", const LoginPage()),
      ]),
      appBar: AppBar(
        title: const Text("Sign Up"),
      ),
      body: Form(
        key: _formKey,
        child: const Center(child: Text("Insert something here")),
      ),
    );
  }
}
