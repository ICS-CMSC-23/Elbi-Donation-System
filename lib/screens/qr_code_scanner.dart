import '../providers/donation_provider.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import '../models/route_model.dart';
import '../models/donation_model.dart';
import '../api/firebase_donation_api.dart';
import '../screens/donation_details_page.dart';

class QrCodeScanner extends StatefulWidget {
  const QrCodeScanner({Key? key}) : super(key: key);

  // class route model
  static final RouteModel _qrCodeScanner = RouteModel(
    "QR Code Scanner",
    "/qr-code-scanner",
  );
  static RouteModel get route => _qrCodeScanner;

  @override
  State<QrCodeScanner> createState() => _QrCodeScannerState();
}

class _QrCodeScannerState extends State<QrCodeScanner> {
  String qrCodeResult = "";

  @override
  void initState() {
    super.initState();
    // call scanQrCode as soon as the widget is initialized
    WidgetsBinding.instance!.addPostFrameCallback((_) => scanQrCode());
  }

  Future<void> scanQrCode() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666",
        "Cancel",
        true,
        ScanMode.QR,
      );

      if (!mounted) return;

      setState(() {
        qrCodeResult = qrCode.toString();
      });

      // get the selected donation
      Donation selectedDonation = context.read<DonationProvider>().selected;

      // define SnackBar content
      String snackBarMessage;
      Color snackBarColor;

      // check if the scanned QR code matches the donation ID
      if (qrCodeResult == selectedDonation.id) {
        // UD Matched
        // update the status of the donation to "Completed" and isForPickup to false
        selectedDonation.status = Donation.STATUS_COMPLETE;
        selectedDonation.isForPickup = false;
        // update the donation in Firebase
        await FirebaseDonationAPI().updateDonation(
          selectedDonation.id!,
          selectedDonation.toJson(),
        );
        snackBarMessage = 'Updated Donation Status Successfully';
        snackBarColor = Colors.green[900]!;
      } else {
        // ID does not match
        snackBarMessage = 'QR code does not match Donation ID';
        snackBarColor = Colors.red[900]!;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: snackBarColor,
          content: Center(
            child: Text(
              snackBarMessage,
              style: const TextStyle(color: Colors.white),
            ),
          ),
          duration: const Duration(milliseconds: 1000),
          behavior: SnackBarBehavior.fixed,
        ),
      );

      // navigate back after scanning
      Navigator.pop(context, qrCodeResult);
    } on PlatformException {
      qrCodeResult = "Failed to get the QR Code";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
