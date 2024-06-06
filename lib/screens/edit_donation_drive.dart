import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

import '../api/firebase_auth_api.dart';
import '../api/firebase_donation_drive_api.dart';
import '../components/square_image.dart';
import '../components/upload_helper.dart';
import '../models/donation_drive_model.dart';
import '../providers/donation_drive_provider.dart';

class EditDonationDrive extends StatefulWidget {
  final DonationDrive donationDrive;

  EditDonationDrive({required this.donationDrive});

  @override
  _EditDonationDriveState createState() => _EditDonationDriveState();
}

class _EditDonationDriveState extends State<EditDonationDrive> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now();
  List<File> _ddriveImages = [];
  List<String> _ddriveImages64 = [];
  String? errorMessage;

  @override
  void initState() {
    super.initState();
    _titleController.text = widget.donationDrive.name;
    _descriptionController.text = widget.donationDrive.description;
    _startDate = widget.donationDrive.startDate;
    _endDate = widget.donationDrive.endDate;
    _ddriveImages64 = widget.donationDrive.photos ?? [];
    _convertBase64ToFile(_ddriveImages64).then((files) {
      setState(() {
        _ddriveImages = files;
      });
    });
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      if (_ddriveImages64.isEmpty) {
        setState(() {
          errorMessage = 'Please upload at least one image';
        });
        return;
      }
      final currentUser = FirebaseAuthAPI.auth.currentUser;
      DonationDrive updatedDrive = DonationDrive(
        id: widget.donationDrive.id,
        organizationId: currentUser!.uid,
        startDate: _startDate,
        endDate: _endDate,
        name: _titleController.text,
        description: _descriptionController.text,
        photos: _ddriveImages64,
      );

      String result = await FirebaseDonationDriveAPI()
          .updateDonationDrive(updatedDrive.id!, updatedDrive.toJson());
      if (result == "Successfully updated donation drive!") {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result)),
        );
        Navigator.pop(context); // Close the form page
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result)),
        );
      }
    }
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStartDate ? _startDate : _endDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
        } else {
          _endDate = picked;
        }
      });
    }
  }

  void _removeImage(int index) async {
    if (_ddriveImages.length > 1) {
      setState(() {
        _ddriveImages.removeAt(index);
        _ddriveImages64.removeAt(index);
      });

      // Update the donation drive in the database
      final currentUser = FirebaseAuthAPI.auth.currentUser;
      DonationDrive updatedDrive = DonationDrive(
        id: widget.donationDrive.id,
        organizationId: currentUser!.uid,
        startDate: _startDate,
        endDate: _endDate,
        name: _titleController.text,
        description: _descriptionController.text,
        photos: _ddriveImages64,
      );

      String result = await FirebaseDonationDriveAPI()
          .updateDonationDrive(updatedDrive.id!, updatedDrive.toJson());
      if (result != "Successfully updated donation drive!") {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(result)),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('At least one image is required.'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  Future<List<File>> _convertBase64ToFile(List<String> base64Images) async {
    List<File> files = [];
    for (String base64 in base64Images) {
      try {
        List<int> imageBytes = base64Decode(base64);
        File file = await _writeToFile(imageBytes);
        files.add(file);
      } catch (e) {
        print('Error decoding base64 image: $e');
      }
    }
    return files;
  }

  Future<File> _writeToFile(List<int> bytes) async {
    final directory = await getApplicationDocumentsDirectory();
    final filePath =
        '${directory.path}/${DateTime.now().millisecondsSinceEpoch}.png';
    final file = File(filePath);
    await file.writeAsBytes(bytes);
    return file;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Donation Drive'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Row(
                children: [
                  Expanded(
                    child: ListTile(
                      title: Text(
                          'Start Date: ${DateFormat('yyyy-MM-dd').format(_startDate)}'),
                      trailing: const Icon(Icons.calendar_today),
                      onTap: () => _selectDate(context, true),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: Text(
                          'End Date: ${DateFormat('yyyy-MM-dd').format(_endDate)}'),
                      trailing: const Icon(Icons.calendar_today),
                      onTap: () => _selectDate(context, false),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _descriptionController,
                decoration: const InputDecoration(labelText: 'Description'),
                maxLines: 3,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () async {
                  List<File> images = await pickMultipleImages();
                  List<String> base64Images =
                      await convertImagesToBase64(images);

                  for (var i = 0; i < images.length; i++) {
                    List<int> bytes = utf8.encode(base64Images[i]);
                    int sizeInBytes = bytes.length;
                    print('Size of base64 string in bytes: $sizeInBytes');
                    if (sizeInBytes < 1000000) {
                      setState(() {
                        _ddriveImages.add(images[i]);
                        _ddriveImages64.add(base64Images[i]);
                      });
                    } else {
                      print("Please upload image less than 1MB.");
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Please upload image less than 1MB.'),
                          backgroundColor: Colors.red,
                        ),
                      );
                    }
                  }
                },
                style: ElevatedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 24.0, vertical: 12.0),
                ),
                child: const Text('Upload Images'),
              ),
              if (_ddriveImages.isNotEmpty) const SizedBox(height: 16),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: _ddriveImages.length,
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: SquareImage(
                          source: _ddriveImages64[index],
                          size: 200,
                        ),
                      ),
                      Positioned(
                        top: 4,
                        right: 4,
                        child: GestureDetector(
                          onTap: () => _removeImage(index),
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.5),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 20),
              if (errorMessage != null) ...[
                Text(
                  errorMessage!,
                  style: TextStyle(color: Colors.red),
                ),
                const SizedBox(height: 20),
              ],
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _submitForm,
                      child: const Text('Update'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
