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
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Username',
                  prefixIcon: Icon(Icons.person),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your username';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Email',
                  prefixIcon: Icon(Icons.email),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your email';
                  }
                  // Add email validation if necessary
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                ),
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter your password';
                  }
                  // Add password strength validation if necessary
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  // Implement sign up logic here
                  if (_formKey.currentState!.validate()) {
                    // if the form is valid, proceed with sign up
                    // access form field values using _formKey.currentState
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
                child: const Text('Sign Up', 
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
