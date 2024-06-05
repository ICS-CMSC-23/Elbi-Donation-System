import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:screenshot/screenshot.dart';

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
  final ScreenshotController screenshotController = ScreenshotController();

  Future<void> saveQrCode(Uint8List imageBytes) async {
    final directory = await getApplicationDocumentsDirectory();
    final imagePath = '${directory.path}/qr_code.png';
    final imageFile = File(imagePath);
    await imageFile.writeAsBytes(imageBytes);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('QR code saved to $imagePath'),
        duration: const Duration(milliseconds: 1000),
        backgroundColor: Colors.green[900]!,
      ),
    );
  }

  Future<void> shareQrCode(Uint8List imageBytes) async {
    final directory = await getApplicationDocumentsDirectory();
    final imagePath = '${directory.path}/qr_code.png';
    final imageFile = File(imagePath);
    await imageFile.writeAsBytes(imageBytes);

    final xFile = XFile(imagePath);
    final result =
        await Share.shareXFiles([xFile], text: 'Here is your QR code');
    if (result.status == ShareResultStatus.success) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Center(child: Text('QR code shared successfully')),
          duration: Duration(milliseconds: 500),
          backgroundColor: Colors.green[900]!,
        ),
      );
    } else if (result.status == ShareResultStatus.dismissed) {
      // Sharing operation was cancelled by the user
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Center(child: Text('QR code sharing cancelled')),
          duration: Duration(milliseconds: 500),
          backgroundColor: Colors.red[900]!,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    String selectedDonationId = context.watch<DonationProvider>().selected.id!;

    return GestureDetector(
      onTap: () {
        // Hide the keyboard when tapping outside of text fields
        FocusScope.of(context).requestFocus(FocusNode());
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("QR Code Generator"),
        ),
        body: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                Screenshot(
                  controller: screenshotController,
                  child: QrImageView(
                    data: selectedDonationId,
                    version: QrVersions.auto,
                    size: 300.0,
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextButton.icon(
                      onPressed: () async {
                        final imageBytes = await screenshotController.capture();
                        if (imageBytes != null) {
                          await saveQrCode(imageBytes);
                        }
                      },
                      icon: const Icon(Icons.save),
                      label: const Text('Save'),
                    ),
                    const SizedBox(width: 20),
                    TextButton.icon(
                      onPressed: () async {
                        final imageBytes = await screenshotController.capture();
                        if (imageBytes != null) {
                          await shareQrCode(imageBytes);
                        }
                      },
                      icon: const Icon(Icons.share),
                      label: const Text('Share'),
                    ),
                  ],
                ),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
