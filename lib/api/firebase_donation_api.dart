import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/donation_model.dart';
import 'package:rxdart/rxdart.dart';

class CombinedQuerySnapshot implements QuerySnapshot {
  final List<QueryDocumentSnapshot> docs;

  CombinedQuerySnapshot(this.docs);

  @override
  SnapshotMetadata get metadata => throw UnimplementedError();

  @override
  Query get query => throw UnimplementedError();

  @override
  List<DocumentChange> get docChanges => throw UnimplementedError();

  @override
  bool get isEmpty => docs.isEmpty;

  @override
  int get size => docs.length;
}

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

  Stream<QuerySnapshot> getDonationsByOrgId(String orgId) {
    // Fetch donation drives by organization ID
    Stream<QuerySnapshot> driveStream = db
        .collection("donationDrives")
        .where("organizationId", isEqualTo: orgId)
        .snapshots();

    return driveStream.switchMap((driveSnapshot) {
      if (driveSnapshot.docs.isEmpty) {
        // If there are no donation drives, return an empty stream
        return Stream.value(CombinedQuerySnapshot([]));
      }

      // Create a list of donation streams for each donation drive
      List<Stream<QuerySnapshot>> donationStreams =
          driveSnapshot.docs.map((driveDoc) {
        String driveId = driveDoc.id;
        return db
            .collection("donations")
            .where("donationDriveId", isEqualTo: driveId)
            .snapshots();
      }).toList();

      // Combine all donation streams into a single stream of CombinedQuerySnapshot
      return CombineLatestStream.list(donationStreams).map((snapshots) {
        // Merge all documents from the list of QuerySnapshots
        List<QueryDocumentSnapshot> allDocs =
            snapshots.expand((snapshot) => snapshot.docs).toList();
        return CombinedQuerySnapshot(allDocs);
      });
    });
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
