import 'package:elbi_donation_system/screens/donor_home_page.dart';
import 'package:elbi_donation_system/screens/log_in_page.dart';
import 'package:elbi_donation_system/screens/org_home_page.dart';
import 'package:elbi_donation_system/screens/sign_up_page.dart';
import 'package:elbi_donation_system/themes/sample_theme._2.dart';
import 'package:elbi_donation_system/themes/sample_theme.dart';
import 'package:elbi_donation_system/themes/sample_theme_3.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Elbi Donation System',
      initialRoute: '/',
      theme: blueTheme(),
      routes: {
        '/': (context) => const LoginPage(),
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignUpPage(),
        '/donor-home-page': (context) => const DonorHomePage(),
        '/org-home-page': (context) => const OrgHomePage(),
      },
    );
  }
}
