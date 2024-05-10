import 'organization_model.dart';

// Enums for donation status
enum DonationStatus {
  Pending,
  Confirmed,
  ScheduledForPickup,
  Complete,
  Canceled,
}

// Enum for donation item category
enum DonationCategory {
  Food,
  Clothes,
  Cash,
  Necessities,
  Others,
}

class Donation {
  final Organization organization;
  final DonationCategory category;
  final String donorName;
  final String donorContactNo;
  final DateTime dateTime;
  final String address;
  final bool isPickup;
  final double weightInKg;
  final String? photoUrl; // URL of the photo uploaded by donor
  DonationStatus status;

  Donation({
    required this.organization,
    required this.category,
    required this.donorName,
    required this.donorContactNo,
    required this.dateTime,
    required this.address,
    required this.isPickup,
    required this.weightInKg,
    this.photoUrl,
    this.status = DonationStatus.Pending,
  });
}
