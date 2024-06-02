import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/donation_drive_model.dart';

class FirebaseDonationDriveAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<String> addDonationDrive(DonationDrive donationDrive) async {
    try {
      final docRef =
          await db.collection("donationDrives").add(donationDrive.toJson());
      await db
          .collection("donationDrives")
          .doc(docRef.id)
          .update({"id": docRef.id});

      return "Successfully added donation drive!";
    } on FirebaseException catch (e) {
      return "Failed to add donation drive: ${e.message}";
    }
  }

  Stream<QuerySnapshot> getAllDonationDrives() {
    return db.collection("donationDrives").snapshots();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getDonationDriveById(
      String id) {
    return db.collection("donationDrives").doc(id).get();
  }

  Stream<QuerySnapshot> getDonationDrivesByOrganizationId(
      String organizationId) {
    return db
        .collection("donationDrives")
        .where("organizationId", isEqualTo: organizationId)
        .snapshots();
  }

  Future<String> updateDonationDrive(
      String id, Map<String, dynamic> updatedData) async {
    try {
      await db.collection("donationDrives").doc(id).update(updatedData);
      return "Successfully updated donation drive!";
    } on FirebaseException catch (e) {
      return "Failed to update donation drive: ${e.message}";
    }
  }

  Future<String> deleteDonationDrive(String id) async {
    try {
      await db.collection("donationDrives").doc(id).delete();
      return "Successfully deleted donation drive!";
    } on FirebaseException catch (e) {
      return "Failed to delete donation drive: ${e.message}";
    }
  }
}
