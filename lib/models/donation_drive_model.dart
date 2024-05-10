import 'donation_model.dart';
import 'organization_model.dart';

class DonationDrive {
  // id for firestore
  final String id;
  final String name;
  final List<String> photos;
  final List<Donation> donations;
  // what organization is this donation drive for?
  final Organization organization;

  DonationDrive({
    required this.id,
    required this.name,
    required this.photos,
    required this.donations,
    required this.organization,
  });
}
