import '../models/donation_model.dart';

List<Donation> dummyDonations = [
  Donation(
    id: "donation_0",
    donationDriveId: "1",
    description:
        "This is the desciption of the donation. Thank you for accepting this donation.",
    donorId: "1",
    category: "Clothes",
    isForPickup: false,
    weightInKg: 48.0,
    dateTime: DateTime.fromMicrosecondsSinceEpoch(1640979000000000),
    photos: [
      "https://ae01.alicdn.com/kf/HTB1ykfvk1OSBuNjy0Fdq6zDnVXa1/Toddler-Baby-Boy-Summer-Clothes-Newborn-Plaid-Gentlemen-Clothing-Set-2pcs-Formal-Clothing-Infant-Clothes-Wear.jpg",
      "https://ae01.alicdn.com/kf/HTB1ykfvk1OSBuNjy0Fdq6zDnVXa1/Toddler-Baby-Boy-Summer-Clothes-Newborn-Plaid-Gentlemen-Clothing-Set-2pcs-Formal-Clothing-Infant-Clothes-Wear.jpg",
      "https://ae01.alicdn.com/kf/HTB1ykfvk1OSBuNjy0Fdq6zDnVXa1/Toddler-Baby-Boy-Summer-Clothes-Newborn-Plaid-Gentlemen-Clothing-Set-2pcs-Formal-Clothing-Infant-Clothes-Wear.jpg",
      "https://th.bing.com/th/id/OSK.HERO9KBTQQq7dpg13RCOgMUBYPDA45PGLO7YM0qqXgz_UzI?rs=1&pid=ImgDetMain",
    ],
    addresses: ["address_52"],
    contactNo: "123-456-0024",
    status: "Confirmed",
  ),
  Donation(
    id: "donation_1",
    donationDriveId: "10",
    description:
        "This is the desciption of the donation. Thank you for accepting this donation.",
    donorId: "1",
    category: "Food",
    isForPickup: false,
    weightInKg: 47.0,
    dateTime: DateTime.fromMicrosecondsSinceEpoch(1640979000050000),
    photos: [
      "https://th.bing.com/th/id/OSK.HERO9KBTQQq7dpg13RCOgMUBYPDA45PGLO7YM0qqXgz_UzI?rs=1&pid=ImgDetMain",
      "https://th.bing.com/th/id/OSK.HERO9KBTQQq7dpg13RCOgMUBYPDA45PGLO7YM0qqXgz_UzI?rs=1&pid=ImgDetMain",
    ],
    addresses: ["address_20"],
    contactNo: "123-456-0166",
    status: "Canceled",
  ),
  Donation(
    id: "donation_2",
    donationDriveId: "1",
    description:
        "This is the desciption of the donation. Thank you for accepting this donation.",
    donorId: "2",
    category: "Necessities",
    isForPickup: false,
    weightInKg: 38.0,
    dateTime: DateTime.fromMicrosecondsSinceEpoch(1640979007000000),
    photos: [
      "https://th.bing.com/th/id/OSK.HERO9KBTQQq7dpg13RCOgMUBYPDA45PGLO7YM0qqXgz_UzI?rs=1&pid=ImgDetMain",
      "https://th.bing.com/th/id/OSK.HERO9KBTQQq7dpg13RCOgMUBYPDA45PGLO7YM0qqXgz_UzI?rs=1&pid=ImgDetMain",
      "https://ae01.alicdn.com/kf/HTB1ykfvk1OSBuNjy0Fdq6zDnVXa1/Toddler-Baby-Boy-Summer-Clothes-Newborn-Plaid-Gentlemen-Clothing-Set-2pcs-Formal-Clothing-Infant-Clothes-Wear.jpg",
      "https://ae01.alicdn.com/kf/HTB1ykfvk1OSBuNjy0Fdq6zDnVXa1/Toddler-Baby-Boy-Summer-Clothes-Newborn-Plaid-Gentlemen-Clothing-Set-2pcs-Formal-Clothing-Infant-Clothes-Wear.jpg",
      "https://ae01.alicdn.com/kf/HTB1ykfvk1OSBuNjy0Fdq6zDnVXa1/Toddler-Baby-Boy-Summer-Clothes-Newborn-Plaid-Gentlemen-Clothing-Set-2pcs-Formal-Clothing-Infant-Clothes-Wear.jpg",
    ],
    addresses: ["address_23", "address_99"],
    contactNo: "123-456-0264",
    status: "Completed",
  ),
  Donation(
    id: "donation_3",
    donationDriveId: "2",
    description:
        "This is the desciption of the donation. Thank you for accepting this donation.",
    donorId: "2",
    category: "Cash",
    isForPickup: false,
    weightInKg: 18.0,
    dateTime: DateTime.fromMicrosecondsSinceEpoch(1640979490000000),
    photos: [
      "https://th.bing.com/th/id/OSK.HERO9KBTQQq7dpg13RCOgMUBYPDA45PGLO7YM0qqXgz_UzI?rs=1&pid=ImgDetMain",
    ],
    addresses: ["address_58", "address_17"],
    contactNo: "123-456-0856",
    status: "Pending",
  ),
  Donation(
    id: "donation_4",
    donationDriveId: "3",
    description:
        "This is the desciption of the donation. Thank you for accepting this donation.",
    donorId: "3",
    category: "Clothes",
    isForPickup: true,
    weightInKg: 3.0,
    dateTime: DateTime.fromMicrosecondsSinceEpoch(1640979000340000),
    photos: [
      "https://ae01.alicdn.com/kf/HTB1ykfvk1OSBuNjy0Fdq6zDnVXa1/Toddler-Baby-Boy-Summer-Clothes-Newborn-Plaid-Gentlemen-Clothing-Set-2pcs-Formal-Clothing-Infant-Clothes-Wear.jpg",
      "https://ae01.alicdn.com/kf/HTB1ykfvk1OSBuNjy0Fdq6zDnVXa1/Toddler-Baby-Boy-Summer-Clothes-Newborn-Plaid-Gentlemen-Clothing-Set-2pcs-Formal-Clothing-Infant-Clothes-Wear.jpg",
    ],
    addresses: ["address_36"],
    contactNo: "123-456-0084",
    status: "Canceled",
  ),
  Donation(
    id: "donation_5",
    donationDriveId: "2",
    description:
        "This is the desciption of the donation. Thank you for accepting this donation.",
    donorId: "3",
    category: "Cash",
    isForPickup: true,
    weightInKg: 36.0,
    dateTime: DateTime.fromMicrosecondsSinceEpoch(1640979000056000),
    photos: [
      "https://th.bing.com/th/id/OSK.HERO9KBTQQq7dpg13RCOgMUBYPDA45PGLO7YM0qqXgz_UzI?rs=1&pid=ImgDetMain",
      "https://ae01.alicdn.com/kf/HTB1ykfvk1OSBuNjy0Fdq6zDnVXa1/Toddler-Baby-Boy-Summer-Clothes-Newborn-Plaid-Gentlemen-Clothing-Set-2pcs-Formal-Clothing-Infant-Clothes-Wear.jpg",
    ],
    addresses: ["address_33"],
    contactNo: "123-456-0283",
    status: "Confirmed",
  ),
  Donation(
    id: "donation_6",
    donationDriveId: "3",
    description:
        "This is the desciption of the donation. Thank you for accepting this donation.",
    donorId: "3",
    category: "Necessities",
    isForPickup: true,
    weightInKg: 31.0,
    dateTime: DateTime.fromMicrosecondsSinceEpoch(1640979000123000),
    photos: [
      "https://ae01.alicdn.com/kf/HTB1ykfvk1OSBuNjy0Fdq6zDnVXa1/Toddler-Baby-Boy-Summer-Clothes-Newborn-Plaid-Gentlemen-Clothing-Set-2pcs-Formal-Clothing-Infant-Clothes-Wear.jpg",
      "https://ae01.alicdn.com/kf/HTB1ykfvk1OSBuNjy0Fdq6zDnVXa1/Toddler-Baby-Boy-Summer-Clothes-Newborn-Plaid-Gentlemen-Clothing-Set-2pcs-Formal-Clothing-Infant-Clothes-Wear.jpg",
    ],
    addresses: ["address_25", "address_12"],
    contactNo: "123-456-0246",
    status: "Canceled",
  ),
  Donation(
    id: "donation_7",
    donationDriveId: "3",
    description:
        "This is the desciption of the donation. Thank you for accepting this donation.",
    donorId: "1",
    category: "Cash",
    isForPickup: true,
    weightInKg: 36.0,
    dateTime: DateTime.fromMicrosecondsSinceEpoch(1640979000567000),
    photos: [
      "https://ae01.alicdn.com/kf/HTB1ykfvk1OSBuNjy0Fdq6zDnVXa1/Toddler-Baby-Boy-Summer-Clothes-Newborn-Plaid-Gentlemen-Clothing-Set-2pcs-Formal-Clothing-Infant-Clothes-Wear.jpg",
      "https://th.bing.com/th/id/OSK.HERO9KBTQQq7dpg13RCOgMUBYPDA45PGLO7YM0qqXgz_UzI?rs=1&pid=ImgDetMain",
    ],
    addresses: ["address_13", "address_36"],
    contactNo: "123-456-0718",
    status: "Confirmed",
  ),
  Donation(
    id: "donation_8",
    donationDriveId: "3",
    description:
        "This is the desciption of the donation. Thank you for accepting this donation.",
    donorId: "donor_44",
    category: "Necessities",
    isForPickup: false,
    weightInKg: 13.0,
    dateTime: DateTime.fromMicrosecondsSinceEpoch(1640979000634000),
    photos: [
      "https://ae01.alicdn.com/kf/HTB1ykfvk1OSBuNjy0Fdq6zDnVXa1/Toddler-Baby-Boy-Summer-Clothes-Newborn-Plaid-Gentlemen-Clothing-Set-2pcs-Formal-Clothing-Infant-Clothes-Wear.jpg",
      "https://th.bing.com/th/id/OSK.HERO9KBTQQq7dpg13RCOgMUBYPDA45PGLO7YM0qqXgz_UzI?rs=1&pid=ImgDetMain",
      "https://th.bing.com/th/id/OSK.HERO9KBTQQq7dpg13RCOgMUBYPDA45PGLO7YM0qqXgz_UzI?rs=1&pid=ImgDetMain",
    ],
    addresses: ["address_89"],
    contactNo: "123-456-0608",
    status: "Confirmed",
  ),
  Donation(
    id: "donation_9",
    donationDriveId: "4",
    description:
        "This is the desciption of the donation. Thank you for accepting this donation.",
    donorId: "3",
    category: "Food",
    isForPickup: false,
    weightInKg: 24.0,
    dateTime: DateTime.fromMicrosecondsSinceEpoch(1640979009900000),
    photos: [
      "https://ae01.alicdn.com/kf/HTB1ykfvk1OSBuNjy0Fdq6zDnVXa1/Toddler-Baby-Boy-Summer-Clothes-Newborn-Plaid-Gentlemen-Clothing-Set-2pcs-Formal-Clothing-Infant-Clothes-Wear.jpg",
      "https://th.bing.com/th/id/OSK.HERO9KBTQQq7dpg13RCOgMUBYPDA45PGLO7YM0qqXgz_UzI?rs=1&pid=ImgDetMain",
      "https://th.bing.com/th/id/OSK.HERO9KBTQQq7dpg13RCOgMUBYPDA45PGLO7YM0qqXgz_UzI?rs=1&pid=ImgDetMain",
    ],
    addresses: ["address_55", "address_23"],
    contactNo: "123-456-0422",
    status: "Scheduled for Pickup",
  ),
];
