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
  String email;
  String password;
  List<String> address;
  String contactNo;
  String role; // donor, organization, admin, guest
  String? profilePhoto; // avatar/ profile picture (optional)

  static const String donor = "donor";
  static const String admin = "admin";
  static const String organization = "organization";
  static const String guest = "guest";

  // for organization only
  String? about;
  List<String>? proofsOfLegitimacy; // image urls
  bool? isApproved; // for admin to approve organization's registration
  bool? isOpenForDonation; // for organization to open/close donation

  User({
    this.id,
    required this.name,
    required this.username,
    required this.email,
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

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'username': username,
      'email': email,
      'password': password,
      'address': address,
      'contactNo': contactNo,
      'role': role,
      'profilePhoto': profilePhoto,
      'about': about,
      'proofsOfLegitimacy': proofsOfLegitimacy,
      'isApproved': isApproved,
      'isOpenForDonation': isOpenForDonation,
    };
  }
}
