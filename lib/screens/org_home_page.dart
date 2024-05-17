import 'package:elbi_donation_system/providers/donation_drive_list_provider.dart';
import '../screens/donor_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'donation_drive_details_page.dart';

class OrgHomePage extends StatelessWidget {
  const OrgHomePage({super.key, this.detailList});

  final List<String>? detailList;

  @override
  Widget build(BuildContext context) {
    // Accessing DonationDriveListProvider
    final donationDriveListProvider = Provider.of<DonationDriveListProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Organization Home Page'),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                // Navigate to Donor Profile Page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DonorProfilePage()),
                );
              },
              child: const Text('Profile'),
            ),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                // Navigate to Donor Profile Page
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DonorProfilePage()),
                );
              },
              child: const Text('Profile Page'),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: donationDriveListProvider.donationDriveList.length,
              itemBuilder: (context, index) {
                final donationDrive = donationDriveListProvider.donationDriveList[index];
                return Card(
                  child: ListTile(
                    title: Text(donationDrive.name),
                    subtitle: Text(donationDrive.description),
                    leading: SizedBox(
                      width: 100,
                      child: Image.network(
                        donationDrive.photos![0],
                        fit: BoxFit.cover,
                      ),
                    ),
                    trailing: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DonationDriveDetails(),
                          ),
                        );
                      },
                      child: const Text('View Donation Drive'),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(
              onPressed: () {
                // Navigate to Create Donation Drive Page
              },
              child: const Text('Create Donation Drive'),
            ),
          ),
        ],
      ),
    );
  }
}