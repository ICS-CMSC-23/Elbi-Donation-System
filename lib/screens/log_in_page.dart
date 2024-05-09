import 'package:elbi_donation_system/components/main_drawer.dart';
import 'package:elbi_donation_system/models/route_model.dart';
import 'package:elbi_donation_system/screens/donor_home_page.dart';
import 'package:elbi_donation_system/screens/org_home_page.dart';
import 'package:elbi_donation_system/screens/sign_up_page.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  RouteModel orgHomepage = RouteModel(
      "Organization Homepage", "/org-home-page", const OrgHomePage());
  RouteModel donorHomePage =
      RouteModel("Donor Homepage", "/donor-home-page", const DonorHomePage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(routes: [
        orgHomepage,
        donorHomePage,
        RouteModel("Sign Up", "/signup", const SignUpPage()),
      ]),
      appBar: AppBar(
        title: const Text("Log In"),
      ),
      body: Form(
        key: _formKey,
        child: const Center(child: Text("Insert something here")),
      ),
    );
  }
}
