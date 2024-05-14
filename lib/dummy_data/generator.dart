// ignore_for_file: avoid_print

import 'dart:math';

import '../models/donation_model.dart';

List<Donation> generateRandomDonations() {
  final random = Random();
  final categories = [
    Donation.CATEGORY_FOOD,
    Donation.CATEGORY_CLOTHES,
    Donation.CATEGORY_CASH,
    Donation.CATEGORY_NECESSITIES,
    Donation.CATEGORY_OTHERS,
  ];
  final statuses = [
    Donation.STATUS_PENDING,
    Donation.STATUS_CONFIRMED,
    Donation.STATUS_SCHEDULED_FOR_PICKUP,
    Donation.STATUS_COMPLETE,
    Donation.STATUS_CANCELED,
  ];

  List<Donation> donations = [];
  for (int i = 0; i < 10; i++) {
    donations.add(Donation(
      id: 'donation_$i',
      description:
          "This is the donation decsription. Thank you for accepting donations.",
      donorId: 'donor_${random.nextInt(100)}',
      category: categories[random.nextInt(categories.length)],
      isForPickup: random.nextBool(),
      weightInKg: (random.nextDouble() * 50).roundToDouble(),
      dateTime: DateTime.now().subtract(Duration(days: random.nextInt(30))),
      photos: List.generate(
          random.nextInt(3), (index) => 'photo_${random.nextInt(1000)}.jpg'),
      addresses: List.generate(
          random.nextInt(2) + 1, (index) => 'address_${random.nextInt(100)}'),
      contactNo: '123-456-${random.nextInt(1000).toString().padLeft(4, '0')}',
      status: statuses[random.nextInt(statuses.length)],
    ));
  }
  return donations;
}

void main() {
  List<Donation> donations = generateRandomDonations();
  print('[');
  for (var donation in donations) {
    print('Donation(');
    print('id: "${donation.id}",');
    print('donorId: "${donation.donorId}",');
    print('donationDriveId: "${donation.category}",');
    print('isForPickup: ${donation.isForPickup},');
    print('weightInKg: ${donation.weightInKg},');
    print('dateTime: "${donation.dateTime}",');
    print('photos: ${donation.photos},');
    print('addresses: ${donation.addresses},');
    print('contactNo: "${donation.contactNo}",');
    print('status: "${donation.status}",');
    print('),');
  }
  print(']');
}
