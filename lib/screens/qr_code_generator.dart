import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart'; // Import the qr_flutter package
import '../models/route_model.dart';
import '../providers/donation_provider.dart';

class QrCodeGenerator extends StatefulWidget {
  const QrCodeGenerator({super.key});

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
    String selectedDonationId = context.watch<DonationProvider>().selected.id!;

    return Scaffold(
      appBar: AppBar(
        title: const Text("QR Code Generator"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("GENERATOR"),
            ],
          ),
        ),
      ),
    );
  }
}
