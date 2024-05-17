// inital mode, to be updated
class Organization {
  final String id;
  final String name;
  final String about;
  final List<String> proofOfLegitimacy;
  bool isApproved;
  bool isOpenForDonation;

  Organization({
    required this.id,
    required this.name,
    required this.about,
    required this.proofOfLegitimacy,
    this.isApproved = false,
    this.isOpenForDonation = true,
  });

  // for future use
  // factory Organization.fromFirestore(DocumentSnapshot doc) {
  //   Map data = doc.data() as Map;
  //   return Organization(
  //     id: doc.id,
  //     name: data['name'] ?? '',
  //     about: data['about'] ?? '',
  //     proofOfLegitimacy: List.from(data['proofOfLegitimacy'] ?? []),
  //     isApproved: data['isApproved'] ?? false,
  //     isOpenForDonation: data['isOpenForDonation'] ?? true,
  //   );
  // }
}
