import '../models/donation_drive_model.dart';

List<DonationDrive> dummyDonationDrives = [
  DonationDrive(
    id: '1',
    organizationId: '1',
    name: 'Winter Clothes Drive',
    description: 'Collecting warm clothes for the homeless.',
    photos: [
      'https://th.bing.com/th/id/OIP.TFTRdGI9wbF8sryCviymzAHaJO?rs=1&pid=ImgDetMain',
      'https://community.pega.com/sites/default/files/styles/1024/public/media/images/2018-04/Charitable_Donations_1.jpg?itok=8aJUpZ3e'
    ],
    isCompleted: false,
    startDate: DateTime(2024, 3, 1),
    endDate: DateTime(2024, 3, 31),
  ),
  DonationDrive(
    id: '2',
    organizationId: '1',
    name: 'Food for Families',
    description: 'Providing food packages to families in need.',
    photos: [
      'https://th.bing.com/th/id/OIP.TFTRdGI9wbF8sryCviymzAHaJO?rs=1&pid=ImgDetMain',
      'https://community.pega.com/sites/default/files/styles/1024/public/media/images/2018-04/Charitable_Donations_1.jpg?itok=8aJUpZ3e'
    ],
    isCompleted: true,
    startDate: DateTime(2024, 3, 1),
    endDate: DateTime(2024, 3, 31),
  ),
  DonationDrive(
    id: '3',
    organizationId: '1',
    name: 'Book Collection',
    description: 'Collecting books for underprivileged children.',
    photos: [
      'https://th.bing.com/th/id/OIP.TFTRdGI9wbF8sryCviymzAHaJO?rs=1&pid=ImgDetMain',
      'https://community.pega.com/sites/default/files/styles/1024/public/media/images/2018-04/Charitable_Donations_1.jpg?itok=8aJUpZ3e'
    ],
    isCompleted: false,
    startDate: DateTime(2024, 3, 1),
    endDate: DateTime(2024, 3, 31),
  ),
  DonationDrive(
    id: '4',
    organizationId: '3',
    name: 'Toy Drive',
    description: 'Gathering toys for children in hospitals.',
    photos: [
      'https://th.bing.com/th/id/OIP.TFTRdGI9wbF8sryCviymzAHaJO?rs=1&pid=ImgDetMain',
      'https://community.pega.com/sites/default/files/styles/1024/public/media/images/2018-04/Charitable_Donations_1.jpg?itok=8aJUpZ3e'
    ],
    isCompleted: true,
    startDate: DateTime(2024, 3, 1),
    endDate: DateTime(2024, 3, 31),
  ),
  DonationDrive(
    id: '5',
    organizationId: '2',
    name: 'Medical Supplies Drive',
    description: 'Collecting medical supplies for clinics in need.',
    photos: [
      'https://th.bing.com/th/id/OIP.TFTRdGI9wbF8sryCviymzAHaJO?rs=1&pid=ImgDetMain',
      'https://community.pega.com/sites/default/files/styles/1024/public/media/images/2018-04/Charitable_Donations_1.jpg?itok=8aJUpZ3e',
      'https://th.bing.com/th/id/OIP.TFTRdGI9wbF8sryCviymzAHaJO?rs=1&pid=ImgDetMain',
      'https://th.bing.com/th/id/OIP.TFTRdGI9wbF8sryCviymzAHaJO?rs=1&pid=ImgDetMain',
    ],
    isCompleted: false,
    startDate: DateTime(2024, 3, 1),
    endDate: DateTime(2024, 3, 31),
  ),
  DonationDrive(
    id: '6',
    organizationId: '4',
    name: 'Back to School Drive',
    description: 'Providing school supplies to children.',
    photos: [
      'https://th.bing.com/th/id/OIP.TFTRdGI9wbF8sryCviymzAHaJO?rs=1&pid=ImgDetMain',
      'https://community.pega.com/sites/default/files/styles/1024/public/media/images/2018-04/Charitable_Donations_1.jpg?itok=8aJUpZ3e'
    ],
    isCompleted: true,
    startDate: DateTime(2024, 3, 1),
    endDate: DateTime(2024, 3, 31),
  ),
  DonationDrive(
    id: '7',
    organizationId: '3',
    name: 'Blanket Drive',
    description: 'Collecting blankets for homeless shelters.',
    photos: [
      'https://community.pega.com/sites/default/files/styles/1024/public/media/images/2018-04/Charitable_Donations_1.jpg?itok=8aJUpZ3e'
    ],
    isCompleted: false,
    startDate: DateTime(2024, 3, 1),
    endDate: DateTime(2024, 3, 31),
  ),
  DonationDrive(
    id: '8',
    organizationId: '4',
    name: 'Hygiene Kits Drive',
    description: 'Providing hygiene kits to people in need.',
    photos: [
      'https://th.bing.com/th/id/OIP.TFTRdGI9wbF8sryCviymzAHaJO?rs=1&pid=ImgDetMain',
      'https://th.bing.com/th/id/OIP.TFTRdGI9wbF8sryCviymzAHaJO?rs=1&pid=ImgDetMain',
      'https://community.pega.com/sites/default/files/styles/1024/public/media/images/2018-04/Charitable_Donations_1.jpg?itok=8aJUpZ3e'
    ],
    isCompleted: true,
    startDate: DateTime(2024, 3, 1),
    endDate: DateTime(2024, 3, 31),
  ),
  DonationDrive(
    id: '9',
    organizationId: '1',
    name: 'Holiday Meal Drive',
    description: 'Providing holiday meals to families in need.',
    photos: [
      'https://th.bing.com/th/id/OIP.TFTRdGI9wbF8sryCviymzAHaJO?rs=1&pid=ImgDetMain',
      'https://community.pega.com/sites/default/files/styles/1024/public/media/images/2018-04/Charitable_Donations_1.jpg?itok=8aJUpZ3e',
      'https://community.pega.com/sites/default/files/styles/1024/public/media/images/2018-04/Charitable_Donations_1.jpg?itok=8aJUpZ3e'
    ],
    isCompleted: false,
    startDate: DateTime(2024, 3, 1),
    endDate: DateTime(2024, 3, 31),
  ),
  DonationDrive(
    id: '10',
    organizationId: '2',
    name: 'Pet Supplies Drive',
    description: 'Collecting supplies for animal shelters.',
    photos: [
      'https://th.bing.com/th/id/OIP.TFTRdGI9wbF8sryCviymzAHaJO?rs=1&pid=ImgDetMain',
    ],
    isCompleted: true,
    startDate: DateTime(2024, 3, 1),
    endDate: DateTime(2024, 3, 31),
  ),
];
