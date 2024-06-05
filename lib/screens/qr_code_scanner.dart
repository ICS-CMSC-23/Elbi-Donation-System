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
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
