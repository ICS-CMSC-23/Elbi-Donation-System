# Elbi Donation System

Elbi Donation System is a mobile application developed using Flutter, designed to manage donations coming into the university.

## Project Description
This project is a Flutter-based application aimed at streamlining the process of managing donations. It utilizes various packages and dependencies to offer a comprehensive and user-friendly experience.

## Versioning
The current version of the application is `1.0.0+1`.

## Environment
The project is built using Dart SDK version `>=3.3.0 <4.0.0`.

## Dependencies
The application leverages several dependencies to provide its features:

- **flutter:** The core framework.
- **cupertino_icons:** iOS style icons.
- **intl:** Internationalization and localization support.
- **provider:** State management.
- **image_picker:** Picking images from the device.
- **firebase_core:** Core Firebase SDK.
- **cloud_firestore:** Cloud Firestore for data storage.
- **firebase_auth:** Firebase authentication.
- **google_fonts:** Google Fonts.
- **auto_size_text:** Automatically resizes text.
- **path_provider:** Finding commonly used locations on the filesystem.
- **rxdart:** Reactive extensions for Dart.
- **flutter_sms:** Sending SMS (from GitHub).
- **qr_flutter:** Generating QR codes (from GitHub).
- **flutter_barcode_scanner:** Scanning barcodes.
- **share_plus:** Sharing content.
- **screenshot:** Taking screenshots.
- **flutter_launcher_icons:** Custom app launcher icons.

## Dev Dependencies
- **flutter_test:** For running tests.
- **flutter_lints:** Recommended lints for good coding practices.

## Usage
To use this application, ensure you have the appropriate environment setup. You can then install the dependencies and run the application.

### Running the Application
1. Ensure you have Flutter installed.
2. Navigate to the project directory.
3. Run `flutter pub get` to install the dependencies.
4. Use `flutter run` to start the application.

## Main Features

### User's View
- **Sign In (Authentication)**
- **Sign Up (Name, Username, Password, Address/es, Contact No.)**
  - Can sign up as an organization that accepts donations
    - Must enter the following information:
      - Name of organization
      - Proof/s of legitimacy
    - Subject to approval
  - Signed up as donors by default

### Donors' View
- **Homepage:** List of organizations where donors can send their donations
- **Donate:**
  - Will open upon selecting an organization
  - Enter the following information:
    - Donation item category checkbox:
      - Food
      - Clothes
      - Cash
      - Necessities
      - Others (can add more categories as necessary)
    - Select if the items are for pickup or drop-off
    - Weight of items to donate in kg/lbs
    - Photo of the items to donate (optional input)
      - Should be able to use the phone camera
    - Date and time for pickup/drop-off
    - Address (for pickup) - can save multiple addresses
    - Contact no (for pickup)
  - If the item is for drop-off, the donor should be able to generate a QR code that must be scanned by the organization to update the donation status
  - A Donation can be canceled
- **Profile**

### Organization's View
- **Homepage:** List of donations
- **Donation:**
  - Can check the information entered by donors
  - Can update the status of each donation:
    - Pending
    - Confirmed
    - Scheduled for Pick-up
    - Complete
    - Canceled
- **Donation Drives:** Showcase of all charity/donation drives
  - Can CRUD (Create, Read, Update, Delete)
  - Can link donations to donation drives
- **Profile:**
  - Organization Name
  - About the organization
  - Status for donations (open or close)

### Admin's View
- Sign In (Authentication)
- View All Organizations and Donations
- Can approve an organization sign up
- View All Donors

## What's New?
**- QR Code System for Drop-off Donations**

**- Switching to Dark Mode**