import 'package:flutter/material.dart';
import '../models/route_model.dart';

class QrCodeScanner extends StatefulWidget {
  const QrCodeScanner({super.key});

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

  // Future<void> scanQrCode() async {
  //   try {
  //     final qrCode = await FlutterBarcodeScanner.scanBarcode(
  //       "#ff6666",
  //       "Cancel",
  //       true,
  //       ScanMode.QR,
  //     );

  //     if (!mounted) return;

  //     setState(() {
  //       qrCodeResult = qrCode.toString();
  //     });

  //   } on PlatformException {
  //     qrCodeResult = "Failed to get the QR Code";
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("QR Code Scanner"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            Text("Result: $qrCodeResult"),
            const SizedBox(height: 30),
            // ElevatedButton(
            //   // onPressed: () => scanQrCode(),
            //   child: const Text("Scan QR Code"),
            // ),
          ],
        ),
      ),
    );
  }
}
