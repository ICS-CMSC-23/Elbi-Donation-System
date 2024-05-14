// constants for user roles
enum UserRole {
  donor,
  organization,
  admin,
}

class User {
  final String? id;
  String name;
  String username;
  String password;
  List<String> address;
  String contactNo;
  String role; // donor, organization, admin
  String? profilePhoto; // avatar/ profile picture (optional)

  // for organization only
  String? about;
  List<String>? proofsOfLegitimacy; // image urls
  bool? isApproved; // for admin to approve organization's registration
  bool? isOpenForDonation; // for organization to open/close donation

  User({
    this.id,
    required this.name,
    required this.username,
    required this.password,
    required this.address,
    required this.contactNo,
    required this.role,
    this.profilePhoto,

    // for organization only
    this.about,
    this.proofsOfLegitimacy,
    this.isApproved = false,
    this.isOpenForDonation = false,
  });
}
