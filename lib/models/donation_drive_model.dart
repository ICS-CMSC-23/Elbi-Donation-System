import 'package:cloud_firestore/cloud_firestore.dart';

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
      'startDate': Timestamp.fromDate(startDate),
      'endDate': Timestamp.fromDate(endDate),
      'name': name,
      'description': description,
      'photos': photos,
      'isCompleted': isCompleted,
    };
  }

  static fromJson(Map<String, dynamic> json) {
    return DonationDrive(
      id: json['id'] as String?,
      organizationId: json['organizationId'] as String,
      startDate: (json['startDate'] as Timestamp).toDate(),
      endDate: (json['endDate'] as Timestamp).toDate(),
      name: json['name'] as String,
      description: json['description'] as String,
      photos: (json['photos'] as List<dynamic>?)
          ?.map((photo) => photo as String)
          .toList(),
      isCompleted: json['isCompleted'] as bool? ?? false,
    );
  }
}
