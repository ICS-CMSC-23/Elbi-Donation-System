class Donation {
  final String? id;
  String description;
  final String donorId;
  String? donationDriveId;

  String category;
  bool isForPickup;
  double weightInKg;
  DateTime dateTime;
  List<String>? photos; // photos of the items to donate
  List<String> addresses;
  String contactNo;
  String status;

  // CONSTANTS
  static const String STATUS_PENDING = "Pending";
  static const String STATUS_CONFIRMED = "Confirmed";
  static const String STATUS_SCHEDULED_FOR_PICKUP = "Scheduled for Pickup";
  static const String STATUS_COMPLETE = "Completed";
  static const String STATUS_CANCELED = "Canceled";

  static const String CATEGORY_FOOD = "Food";
  static const String CATEGORY_CLOTHES = "Clothes";
  static const String CATEGORY_CASH = "Cash";
  static const String CATEGORY_NECESSITIES = "Necessities";
  static const String CATEGORY_OTHERS = "Others";

  Donation({
    this.id,
    this.donationDriveId,
    required this.description,
    required this.donorId,
    required this.category,
    required this.isForPickup,
    required this.weightInKg,
    required this.dateTime,
    this.photos,
    required this.addresses,
    required this.contactNo,
    this.status = STATUS_PENDING,
  });
}
