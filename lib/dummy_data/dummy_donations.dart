import '../models/donation_model.dart';

List<Donation> dummyDonations = [
  Donation(
    id: "donation_0",
    description:
        "This is the desciption of the donation. Thank you for accepting this donation.",
    donorId: "donor_64",
    category: "Clothes",
    isForPickup: false,
    weightInKg: 48.0,
    dateTime: DateTime.fromMicrosecondsSinceEpoch(1640979000000000),
    photos: [
      "https://ae01.alicdn.com/kf/HTB1ykfvk1OSBuNjy0Fdq6zDnVXa1/Toddler-Baby-Boy-Summer-Clothes-Newborn-Plaid-Gentlemen-Clothing-Set-2pcs-Formal-Clothing-Infant-Clothes-Wear.jpg",
      "photo_116.jpg"
    ],
    addresses: ["address_52"],
    contactNo: "123-456-0024",
    status: "Confirmed",
  ),
  Donation(
    id: "donation_1",
    description:
        "This is the desciption of the donation. Thank you for accepting this donation.",
    donorId: "donor_6",
    category: "Food",
    isForPickup: false,
    weightInKg: 47.0,
    dateTime: DateTime.fromMicrosecondsSinceEpoch(1640979000050000),
    photos: [
      "https://media.gettyimages.com/id/51101394/photo/potatoes-photo-taken-august-1999.jpg?b=1&s=594x594&w=0&k=20&c=pCSenjlQvEe3-qbpWXtxo03A6y1R6D37gbSx5wAp6c4=",
      "photo_441.jpg"
    ],
    addresses: ["address_20"],
    contactNo: "123-456-0166",
    status: "Canceled",
  ),
  Donation(
    id: "donation_2",
    description:
        "This is the desciption of the donation. Thank you for accepting this donation.",
    donorId: "donor_45",
    category: "Necessities",
    isForPickup: false,
    weightInKg: 38.0,
    dateTime: DateTime.fromMicrosecondsSinceEpoch(1640979007000000),
    photos: [
      "https://media.gettyimages.com/id/51101394/photo/potatoes-photo-taken-august-1999.jpg?b=1&s=594x594&w=0&k=20&c=pCSenjlQvEe3-qbpWXtxo03A6y1R6D37gbSx5wAp6c4=",
      "photo_441.jpg"
    ],
    addresses: ["address_23", "address_99"],
    contactNo: "123-456-0264",
    status: "Completed",
  ),
  Donation(
    id: "donation_3",
    description:
        "This is the desciption of the donation. Thank you for accepting this donation.",
    donorId: "donor_25",
    category: "Cash",
    isForPickup: false,
    weightInKg: 18.0,
    dateTime: DateTime.fromMicrosecondsSinceEpoch(1640979490000000),
    photos: [
      "https://media.gettyimages.com/id/51101394/photo/potatoes-photo-taken-august-1999.jpg?b=1&s=594x594&w=0&k=20&c=pCSenjlQvEe3-qbpWXtxo03A6y1R6D37gbSx5wAp6c4=",
      " photo_459.jpg"
    ],
    addresses: ["address_58", "address_17"],
    contactNo: "123-456-0856",
    status: "Pending",
  ),
  Donation(
    id: "donation_4",
    description:
        "This is the desciption of the donation. Thank you for accepting this donation.",
    donorId: "donor_93",
    category: "Clothes",
    isForPickup: true,
    weightInKg: 3.0,
    dateTime: DateTime.fromMicrosecondsSinceEpoch(1640979000340000),
    photos: [
      "https://ae01.alicdn.com/kf/HTB1ykfvk1OSBuNjy0Fdq6zDnVXa1/Toddler-Baby-Boy-Summer-Clothes-Newborn-Plaid-Gentlemen-Clothing-Set-2pcs-Formal-Clothing-Infant-Clothes-Wear.jpg",
      "photo_116.jpg"
    ],
    addresses: ["address_36"],
    contactNo: "123-456-0084",
    status: "Canceled",
  ),
  Donation(
    id: "donation_5",
    description:
        "This is the desciption of the donation. Thank you for accepting this donation.",
    donorId: "donor_24",
    category: "Cash",
    isForPickup: true,
    weightInKg: 36.0,
    dateTime: DateTime.fromMicrosecondsSinceEpoch(1640979000056000),
    photos: [
      "https://ae01.alicdn.com/kf/HTB1ykfvk1OSBuNjy0Fdq6zDnVXa1/Toddler-Baby-Boy-Summer-Clothes-Newborn-Plaid-Gentlemen-Clothing-Set-2pcs-Formal-Clothing-Infant-Clothes-Wear.jpg",
      "photo_116.jpg"
    ],
    addresses: ["address_33"],
    contactNo: "123-456-0283",
    status: "Confirmed",
  ),
  Donation(
    id: "donation_6",
    description:
        "This is the desciption of the donation. Thank you for accepting this donation.",
    donorId: "donor_12",
    category: "Necessities",
    isForPickup: true,
    weightInKg: 31.0,
    dateTime: DateTime.fromMicrosecondsSinceEpoch(1640979000123000),
    photos: [
      "https://ae01.alicdn.com/kf/HTB1ykfvk1OSBuNjy0Fdq6zDnVXa1/Toddler-Baby-Boy-Summer-Clothes-Newborn-Plaid-Gentlemen-Clothing-Set-2pcs-Formal-Clothing-Infant-Clothes-Wear.jpg",
      "photo_116.jpg"
    ],
    addresses: ["address_25", "address_12"],
    contactNo: "123-456-0246",
    status: "Canceled",
  ),
  Donation(
    id: "donation_7",
    description:
        "This is the desciption of the donation. Thank you for accepting this donation.",
    donorId: "donor_14",
    category: "Cash",
    isForPickup: true,
    weightInKg: 36.0,
    dateTime: DateTime.fromMicrosecondsSinceEpoch(1640979000567000),
    photos: [
      "https://ae01.alicdn.com/kf/HTB1ykfvk1OSBuNjy0Fdq6zDnVXa1/Toddler-Baby-Boy-Summer-Clothes-Newborn-Plaid-Gentlemen-Clothing-Set-2pcs-Formal-Clothing-Infant-Clothes-Wear.jpg",
      "photo_116.jpg"
    ],
    addresses: ["address_13", "address_36"],
    contactNo: "123-456-0718",
    status: "Confirmed",
  ),
  Donation(
    id: "donation_8",
    description:
        "This is the desciption of the donation. Thank you for accepting this donation.",
    donorId: "donor_44",
    category: "Necessities",
    isForPickup: false,
    weightInKg: 13.0,
    dateTime: DateTime.fromMicrosecondsSinceEpoch(1640979000634000),
    photos: [
      "https://ae01.alicdn.com/kf/HTB1ykfvk1OSBuNjy0Fdq6zDnVXa1/Toddler-Baby-Boy-Summer-Clothes-Newborn-Plaid-Gentlemen-Clothing-Set-2pcs-Formal-Clothing-Infant-Clothes-Wear.jpg",
      "photo_116.jpg"
    ],
    addresses: ["address_89"],
    contactNo: "123-456-0608",
    status: "Confirmed",
  ),
  Donation(
    id: "donation_9",
    description:
        "This is the desciption of the donation. Thank you for accepting this donation.",
    donorId: "donor_76",
    category: "Food",
    isForPickup: false,
    weightInKg: 24.0,
    dateTime: DateTime.fromMicrosecondsSinceEpoch(1640979009900000),
    photos: [
      "https://ae01.alicdn.com/kf/HTB1ykfvk1OSBuNjy0Fdq6zDnVXa1/Toddler-Baby-Boy-Summer-Clothes-Newborn-Plaid-Gentlemen-Clothing-Set-2pcs-Formal-Clothing-Infant-Clothes-Wear.jpg",
      "photo_116.jpg"
    ],
    addresses: ["address_55", "address_23"],
    contactNo: "123-456-0422",
    status: "Scheduled for Pickup",
  ),
];
