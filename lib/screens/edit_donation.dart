import 'dart:async';
import 'dart:convert';

import 'package:elbi_donation_system/components/square_image.dart';
import 'package:elbi_donation_system/providers/auth_provider.dart';
import 'package:elbi_donation_system/providers/donation_drive_provider.dart';
import 'package:elbi_donation_system/providers/donation_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'dart:io';

import '../api/firebase_auth_api.dart';
import '../api/firebase_donation_api.dart';
import '../api/firebase_donation_drive_api.dart';
import '../components/upload_helper.dart';
import '../models/donation_model.dart';

class EditDonation extends StatefulWidget {
  @override
  _EditDonationState createState() => _EditDonationState();
}

class _EditDonationState extends State<EditDonation> {
  final _formKey = GlobalKey<FormState>();
  final _categoryController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _weightController = TextEditingController();
  final _contactController = TextEditingController();
  bool isLoading = false;
  bool isForPickup = true;
  List<File> _donationImages = [];
  List<String> _donationImages64 = [];
  String? errorMessage;
  String? _categoryValue;
  String? _weightUnit = 'kg';
  List<String> _selectedAddresses = [];
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    Donation currentDonation = context.read<DonationProvider>().selected;
    _categoryValue = currentDonation.category;
    // category: _categoryController.text,
    _descriptionController.text = currentDonation.description;
    _contactController.text = currentDonation.contactNo;
    _weightController.text = currentDonation.weightInKg.toString();
    _selectedDate = currentDonation.dateTime;
    _selectedAddresses = currentDonation.addresses;
    _donationImages64 = currentDonation.photos ?? [];
    _convertBase64ToFile(_donationImages64).then((files) {
      setState(() {
        _donationImages = files;
      });
    });
  }

  void _cancelEdit() {
    Navigator.pop(context);
  }

  void categoryCallback(String? selectedValue) {
    if (selectedValue is String) {
      setState(() {
        _categoryValue = selectedValue;
      });
    }
  }

  void _submitForm() async {
    if (isLoading) {
      return;
    }

    if (_formKey.currentState!.validate()) {
      if (_formKey.currentState!.validate()) {
        if (_donationImages.isEmpty) {
          setState(() {
            errorMessage = 'Please upload at least one image';
          });
          return;
        }
        final currentUser = context.read<AuthProvider>().currentUser;
        // final currentDrive = FirebaseDonationDriveAPI;
        Donation newDonation = Donation(
          id: context.read<DonationProvider>().selected.id,
          donorId: currentUser.id!,
          donationDriveId:
              context.read<DonationProvider>().selected.donationDriveId,
          category: _categoryValue!,
          description: _descriptionController.text,
          photos: _donationImages64,
          isForPickup: isForPickup,
          weightInKg: _weightUnit == 'kg'
              ? double.parse(_weightController.text)
              : double.parse(_weightController.text) * 0.453592,
          dateTime: _selectedDate,
          addresses: isForPickup ? _selectedAddresses : [],
          contactNo: isForPickup ? _contactController.text : '',
        );

        setState(() {
          isLoading = true;
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Updating donation... please wait...")),
        );

        try {
          print(context.read<DonationProvider>().selected.id!);
          String result = await FirebaseDonationAPI()
              .updateDonation(context.read<DonationProvider>().selected.id!,
                  newDonation.toJson())
              .timeout(
            Duration(seconds: 20), // specify the duration you want to wait
            onTimeout: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content: Text("Request timed out. Please try again.")),
              );
              return 'timeout'; // Return a default value or handle the timeout case appropriately
            },
          );

          if (result == 'timeout') {
            // Handle the timeout case, possibly return or break out
            setState(() {
              isLoading = false;
            });
            return;
          }

          // Handle the result as usual
        } on TimeoutException catch (_) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text("Request timed out. Please try again.")),
          );
        } finally {
          setState(() {
            isLoading = false;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Successfully updated donation!")),
          );
          Navigator.pop(context);
          Navigator.pop(context);
        }
      }
      //   ScaffoldMessenger.of(context)
      //       .showSnackBar(const SnackBar(content: Text('Donation Submitted')));
      //   _clearForm();
      // }
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

  Future<void> _updateDateTime(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (pickedDate != null && pickedDate != _selectedDate) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_selectedDate),
      );

      if (pickedTime != null) {
        setState(() {
          _selectedDate = DateTime(pickedDate.year, pickedDate.month,
              pickedDate.day, pickedTime.hour, pickedTime.minute);
        });
      }
    }
  }

  @override
  void dispose() {
    _categoryController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _validateCategoryValue() {
    const validValues = ["Food", "Clothes", "Cash", "Necessities", "Others"];
    if (!validValues.contains(_categoryValue)) {
      _categoryValue = "Others";
    }
  }

  @override
  Widget build(BuildContext context) {
    final addresses = context.read<AuthProvider>().currentUser.address;

    _validateCategoryValue();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Edit Donation'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ChoiceChip(
                      label: const Text('For Pickup'),
                      selected: isForPickup,
                      onSelected: (selected) {
                        setState(() {
                          isForPickup = true;
                        });
                      },
                    ),
                    const SizedBox(width: 8),
                    ChoiceChip(
                      label: const Text('For Drop-off'),
                      selected: !isForPickup,
                      onSelected: (selected) {
                        setState(() {
                          isForPickup = false;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                DropdownButtonFormField(
                  items: const [
                    DropdownMenuItem(value: "Food", child: Text("Food")),
                    DropdownMenuItem(value: "Clothes", child: Text("Clothes")),
                    DropdownMenuItem(value: "Cash", child: Text("Cash")),
                    DropdownMenuItem(
                        value: "Necessities", child: Text("Necessities")),
                    DropdownMenuItem(value: "Others", child: Text("Others")),
                  ],
                  value: _categoryValue,
                  onChanged: categoryCallback,
                  decoration: const InputDecoration(labelText: 'Category'),
                  validator: (value) {
                    if (value == null) {
                      return 'Please choose a category';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                TextFormField(
                  controller: _descriptionController,
                  decoration:
                      const InputDecoration(labelText: 'Donation Description'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a donation description';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: TextFormField(
                        controller: _weightController,
                        decoration: const InputDecoration(labelText: 'Weight'),
                        keyboardType: TextInputType.number,
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please enter the weight';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 16.0),
                    Expanded(
                      flex: 1,
                      child: DropdownButtonFormField(
                        value: _weightUnit,
                        items: const [
                          DropdownMenuItem(value: "kg", child: Text("kg")),
                          DropdownMenuItem(value: "lbs", child: Text("lbs")),
                        ],
                        onChanged: (value) {
                          setState(() {
                            _weightUnit = value;
                          });
                        },
                        decoration: const InputDecoration(labelText: 'Unit'),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16.0),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: () => _updateDateTime(context),
                      child: const Text('Select Date and Time'),
                    ),
                    const SizedBox(width: 16.0),
                    Text(DateFormat('yyyy-MM-dd HH:mm').format(_selectedDate)),
                  ],
                ),
                if (isForPickup) ...[
                  const SizedBox(height: 16.0),
                  const Text(
                    'Select Address/es',
                    style: TextStyle(fontSize: 16.0),
                  ),
                  const SizedBox(height: 8.0),
                  ...addresses.map((address) {
                    return CheckboxListTile(
                      title: Text(address),
                      value: _selectedAddresses.contains(address),
                      onChanged: (bool? selected) {
                        setState(() {
                          if (selected == true) {
                            _selectedAddresses.add(address);
                          } else {
                            _selectedAddresses.remove(address);
                          }
                        });
                      },
                    );
                  }),
                  const SizedBox(height: 16.0),
                  TextFormField(
                    controller: _contactController,
                    decoration:
                        const InputDecoration(labelText: 'Contact Number'),
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter a contact number';
                      }
                      return null;
                    },
                  ),
                ],
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
                          _donationImages.add(images[i]);
                          _donationImages64.add(base64Images[i]);
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
                if (_donationImages.isNotEmpty) const SizedBox(height: 16),
                GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                  ),
                  itemCount: _donationImages.length,
                  itemBuilder: (context, index) {
                    return Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: SquareImage(
                            source: _donationImages64[index],
                            size: 200,
                          ),
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                removeImage(_donationImages, index);
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(2.0),
                              decoration: const BoxDecoration(
                                color: Colors.red,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.close,
                                size: 16,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    ElevatedButton(
                      onPressed: _submitForm,
                      child: const Text('Save changes'),
                    ),
                    ElevatedButton(
                      onPressed: _cancelEdit,
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      child: const Text('Cancel'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
