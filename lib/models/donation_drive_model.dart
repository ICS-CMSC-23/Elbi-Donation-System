class DonationDrive {
  final String? id;
  final String organizationId; // what organization is this donation drive for?
  final DateTime startDate;
  final DateTime endDate;

  String name;
  String description;
  List<String>? photos;
  bool isCompleted; // for notification

  DonationDrive({
    this.id,
    required this.startDate,
    required this.endDate,
    required this.organizationId,
    required this.name,
    required this.description,
    this.photos,
    this.isCompleted = false,
  });

  // convert DonationDrive object to json for Firestore
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'organizationId': organizationId,
      'startDate': startDate,
      'endDate': endDate,
      'name': name,
      'description': description,
      'photos': photos,
      'isCompleted': isCompleted,
    };
  }
}
