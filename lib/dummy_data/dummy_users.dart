import 'package:elbi_donation_system/models/user_model.dart';

List<User> dummyUsers = [
  User(
    id: '1',
    name: 'John Doe',
    username: 'johndoe',
    password: '12345678',
    address: ['123 Elm Street', 'Springfield', 'IL', '62704'],
    contactNo: '123-456-7890',
    role: 'donor',
    email: 'donor@example.com',
    profilePhoto: 'avatar1.jpg',
    about: 'A kind-hearted donor',
    proofsOfLegitimacy: ['legitimacy1.jpg'],
    isApproved: true,
    isOpenForDonation: true,
  ),
  User(
    id: '2',
    name: 'Jane Smith',
    username: 'janesmith',
    password: '12345678',
    address: ['456 Oak Avenue', 'Springfield', 'IL', '62704'],
    contactNo: '987-654-3210',
    role: 'organization',
    email: 'organization@example.com',
    profilePhoto: 'avatar2.jpg',
    about: 'Helping hands organization',
    proofsOfLegitimacy: ['proof1.jpg', 'proof2.jpg'],
    isApproved: true,
    isOpenForDonation: true,
  ),
  User(
    id: '3',
    name: 'Alice Johnson',
    username: 'alicej',
    password: '12345678',
    address: ['789 Pine Road', 'Springfield', 'IL', '62704'],
    contactNo: '555-123-4567',
    role: 'admin',
    email: 'admin@example.com',
    profilePhoto: 'avatar3.jpg',
    about: 'Admin of the platform',
    proofsOfLegitimacy: ['adminproof1.jpg'],
    isApproved: true,
    isOpenForDonation: false,
  ),
  User(
    id: '4',
    name: 'Bob Brown',
    username: 'bobbrown',
    password: 'password123',
    address: ['321 Maple Lane', 'Springfield', 'IL', '62704'],
    contactNo: '555-765-4321',
    role: 'donor',
    email: 'bobbrown@example.com',
    profilePhoto: 'avatar4.jpg',
    about: 'Enthusiastic donor',
    proofsOfLegitimacy: ['legitimacy2.jpg'],
    isApproved: true,
    isOpenForDonation: true,
  ),
  User(
    id: '5',
    name: 'Carol White',
    username: 'carolw',
    password: 'password123',
    address: ['654 Cedar Boulevard', 'Springfield', 'IL', '62704'],
    contactNo: '555-234-5678',
    role: 'organization',
    email: 'carolw@example.com',
    profilePhoto: 'avatar5.jpg',
    about: 'Food for All initiative',
    proofsOfLegitimacy: ['proof3.jpg', 'proof4.jpg'],
    isApproved: true,
    isOpenForDonation: false,
  ),
  User(
    id: '6',
    name: 'David Green',
    username: 'davidg',
    password: 'password123',
    address: ['987 Birch Way', 'Springfield', 'IL', '62704'],
    contactNo: '555-345-6789',
    role: 'admin',
    email: 'davidg@example.com',
    profilePhoto: 'avatar6.jpg',
    about: 'Senior admin',
    proofsOfLegitimacy: ['adminproof2.jpg'],
    isApproved: true,
    isOpenForDonation: true,
  ),
  User(
    id: '7',
    name: 'Eva Black',
    username: 'evab',
    password: 'password123',
    address: ['213 Willow Street', 'Springfield', 'IL', '62704'],
    contactNo: '555-456-7890',
    role: 'donor',
    email: 'evab@example.com',
    profilePhoto: 'avatar7.jpg',
    about: 'Charity supporter',
    proofsOfLegitimacy: ['legitimacy3.jpg'],
    isApproved: true,
    isOpenForDonation: true,
  ),
  User(
    id: '8',
    name: 'Frank Blue',
    username: 'frankb',
    password: 'password123',
    address: ['432 Ash Avenue', 'Springfield', 'IL', '62704'],
    contactNo: '555-567-8901',
    role: 'organization',
    email: 'frankb@example.com',
    profilePhoto: 'avatar8.jpg',
    about: 'Clothes for Everyone',
    proofsOfLegitimacy: ['proof5.jpg', 'proof6.jpg'],
    isApproved: true,
    isOpenForDonation: true,
  ),
  User(
    id: '9',
    name: 'Grace Red',
    username: 'gracer',
    password: 'password123',
    address: ['876 Elm Street', 'Springfield', 'IL', '62704'],
    contactNo: '555-678-9012',
    role: 'donor',
    email: 'gracer@example.com',
    profilePhoto: 'avatar9.jpg',
    about: 'Regular donor',
    proofsOfLegitimacy: ['legitimacy4.jpg'],
    isApproved: true,
    isOpenForDonation: true,
  ),
  User(
    id: '10',
    name: 'Henry Purple',
    username: 'henryp',
    password: 'password123',
    address: ['654 Pine Road', 'Springfield', 'IL', '62704'],
    contactNo: '555-789-0123',
    role: 'admin',
    email: 'henryp@example.com',
    profilePhoto: 'avatar10.jpg',
    about: 'Platform admin',
    proofsOfLegitimacy: ['adminproof3.jpg'],
    isApproved: true,
    isOpenForDonation: true,
  ),
];