import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/donation_model.dart';

class FirebaseDonationAPI {
  static final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<String> addDonation(Donation donation) async {
    try {
      final docRef = await db.collection("donations").add(donation.toJson());
      await db.collection("donations").doc(docRef.id).update({"id": docRef.id});

      return "Successfully added donation!";
    } on FirebaseException catch (e) {
      return "Failed to add donation: ${e.message}";
    }
  }

  Stream<QuerySnapshot> getAllDonations() {
    return db.collection("donations").snapshots();
  }

  Stream<QuerySnapshot> getDonationsByDonorId(String donorId) {
    return db
        .collection("donations")
        .where("donorId", isEqualTo: donorId)
        .snapshots();
  }

  Stream<QuerySnapshot> getDonationsByDonationDriveId(String donationDriveId) {
    return db
        .collection("donations")
        .where("donationDriveId", isEqualTo: donationDriveId)
        .snapshots();
  }

  Future<String> updateDonation(
      String id, Map<String, dynamic> updatedData) async {
    try {
      await db.collection("donations").doc(id).update(updatedData);
      return "Successfully updated donation!";
    } on FirebaseException catch (e) {
      return "Failed to update donation: ${e.message}";
    }
  }

  Future<String> deleteDonation(String id) async {
    try {
      await db.collection("donations").doc(id).delete();
      return "Successfully deleted donation!";
    } on FirebaseException catch (e) {
      return "Failed to delete donation: ${e.message}";
    }
  }
}
