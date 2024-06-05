import 'package:flutter/material.dart';
import '../models/route_model.dart';

class QrCodeGenerator extends StatefulWidget {
  const QrCodeGenerator({super.key});

  // class route model
  static final RouteModel _qrCodeGenerator = RouteModel(
    "QR Code Generator",
    "/qr-code-generator",
  );
  static RouteModel get route => _qrCodeGenerator;

  @override
  State<QrCodeGenerator> createState() => _QrCodeGeneratorState();
}

class _QrCodeGeneratorState extends State<QrCodeGenerator> {
  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
