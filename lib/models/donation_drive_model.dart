import 'donation_model.dart';
import 'organization_model.dart';

class DonationDrive {
  final String? id;
  final String organizationId; // what organization is this donation drive for?

  String name;
  String description;
  List<String>? photos;
  bool isCompleted; // for notification

  DonationDrive({
    this.id,
    required this.organizationId,
    required this.name,
    required this.description,
    this.photos,
    this.isCompleted = false,
  });
}
