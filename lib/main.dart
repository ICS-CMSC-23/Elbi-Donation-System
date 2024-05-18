import 'package:elbi_donation_system/providers/auth_provider.dart';
import 'package:elbi_donation_system/providers/donation_drive_list_provider.dart';
import 'package:elbi_donation_system/providers/donation_list_provider.dart';
import 'package:elbi_donation_system/providers/theme_provider.dart';
import 'package:elbi_donation_system/providers/user_list_provider.dart';
import 'package:elbi_donation_system/screens/admin_home_page.dart';
import 'package:elbi_donation_system/screens/donation_drive_list_page.dart';
import 'package:elbi_donation_system/screens/donor_home_page.dart';
import 'package:elbi_donation_system/screens/donor_list_page.dart';
import 'package:elbi_donation_system/screens/donor_profile_page.dart';
import 'package:elbi_donation_system/screens/list_pages/donation_list_page.dart';
import 'package:elbi_donation_system/screens/log_in_page.dart';
import 'package:elbi_donation_system/screens/org_acc_approval_page.dart';
import 'package:elbi_donation_system/screens/org_home_page.dart';
import 'package:elbi_donation_system/screens/org_profile_page.dart';
import 'package:elbi_donation_system/screens/sign_up_page.dart';
import 'package:elbi_donation_system/screens/donation_details_page.dart';
import 'package:elbi_donation_system/screens/donation_drive_details_page.dart';
import 'package:elbi_donation_system/themes/dark_purple_theme.dart';
import 'package:elbi_donation_system/themes/purple_theme.dart';
import 'package:elbi_donation_system/themes/sample_theme._2.dart';
import 'package:elbi_donation_system/themes/sample_theme.dart';
import 'package:elbi_donation_system/themes/sample_theme_3.dart';
import 'package:flutter/material.dart';
import "package:provider/provider.dart";

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(create: (context) => AuthProvider()),
    ChangeNotifierProvider(create: (context) => UserListProvider()),
    ChangeNotifierProvider(create: (context) => DonationListProvider()),
    ChangeNotifierProvider(create: (context) => DonationDriveListProvider()),
    ChangeNotifierProvider(create: (context) => ThemeProvider())
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Elbi Donation System',
      initialRoute: '/',
      theme: context.watch<ThemeProvider>().isDarkTheme
          ? darkPurpleTheme()
          : purpleTheme(),
      routes: {
        '/': (context) => context.watch<AuthProvider>().homeElement,
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignUpPage(),
        '/donor-home-page': (context) => const DonorHomePage(),
        '/org-home-page': (context) => const OrgHomePage(),
        '/donation-details': (context) => const DonationDetails(),
        '/donor-profile': (context) => const DonorProfilePage(),
        '/org-profile': (context) => const OrgProfilePage(),
        '/donation-drive-details': (context) => const DonationDriveDetails(),
        '/org-account-approval': (context) => const OrgAccApprovalPage(),
        '/donor-list-page': (context) => const DonorListPage(),
        '/donation-list-page': (context) => const DonationListPage(),
        '/donation-drive-list-page': (context) => const DonationDriveListPage()
      },
    );
  }
}
