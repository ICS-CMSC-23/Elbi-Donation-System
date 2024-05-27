import 'package:cloud_firestore/cloud_firestore.dart';

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

  static const List<String> statuses = [
    STATUS_PENDING,
    STATUS_CONFIRMED,
    STATUS_SCHEDULED_FOR_PICKUP,
    STATUS_COMPLETE,
    STATUS_CANCELED,
  ];

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

  // convert Donation object to json for Firestore
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'donorId': donorId,
      'donationDriveId': donationDriveId,
      'category': category,
      'isForPickup': isForPickup,
      'weightInKg': weightInKg,
      'dateTime': Timestamp.fromDate(dateTime),
      'photos': photos,
      'addresses': addresses,
      'contactNo': contactNo,
      'status': status,
    };
  }

  static Donation fromJson(Map<String, dynamic> json) {
    return Donation(
      id: json['id'],
      donationDriveId: json['donationDriveId'],
      description: json['description'],
      donorId: json['donorId'],
      category: json['category'],
      isForPickup: json['isForPickup'],
      weightInKg: json['weightInKg'] is int
          ? (json['weightInKg'] as int).toDouble()
          : json['weightInKg'],
      dateTime: (json['dateTime'] as Timestamp).toDate(),
      photos: List<String>.from(json['photos'] ?? []),
      addresses: List<String>.from(json['addresses']),
      contactNo: json['contactNo'],
      status: json['status'] ?? STATUS_PENDING,
    );
  }
}
