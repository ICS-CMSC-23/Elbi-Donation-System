import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import '../api/firebase_auth_api.dart';
import '../api/firebase_donation_api.dart';
import '../api/firebase_donation_drive_api.dart';
import '../components/upload_helper.dart';
import '../models/donation_model.dart';

class AddDonation extends StatefulWidget {
  @override
  _AddDonationState createState() => _AddDonationState();
}

class _AddDonationState extends State<AddDonation> {
  final _formKey = GlobalKey<FormState>();
  final _categoryController = TextEditingController();
  final _descriptionController = TextEditingController();
  // final _remarksController = TextEditingController();
  List<File> _donationImages = [];
  List<String> _donationImages64 = [];
  String? errorMessage;

  void _clearForm() {
    _formKey.currentState?.reset();
    _categoryController.clear();
    _descriptionController.clear();
    // _remarksController.clear();
    setState(() {
      _donationImages.clear();
      _donationImages64.clear();
    });
  }

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      if (_formKey.currentState!.validate()) {
        if (_donationImages.isEmpty) {
          setState(() {
            errorMessage = 'Please upload at least one image';
          });
          return;
        }
        final currentUser = FirebaseAuthAPI.auth.currentUser;
        // final currentDrive = FirebaseDonationDriveAPI;
        Donation newDonation = Donation(
          donorId: currentUser!.uid,
          donationDriveId: currentUser.uid,
          category: _categoryController.text,
          description: _descriptionController.text,
          photos: _donationImages64,
          isForPickup: false,
          weightInKg: 10,
          dateTime: DateTime.now(),
          addresses: [],
          contactNo: '',
        );

        String result = await FirebaseDonationAPI().addDonation(newDonation);

        if (result == "Successfully added donation drive!") {
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
      //   ScaffoldMessenger.of(context)
      //       .showSnackBar(const SnackBar(content: Text('Donation Submitted')));
      //   _clearForm();
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Donation'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                TextFormField(
                  controller: _categoryController,
                  decoration: const InputDecoration(labelText: 'Category'),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter a donation name';
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
                // const SizedBox(height: 16.0),
                // TextFormField(
                //   controller: _remarksController,
                //   decoration:
                //       const InputDecoration(labelText: 'Remarks/Message'),
                // ),
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
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.file(
                            _donationImages[index],
                            fit: BoxFit.cover,
                            width: double.infinity,
                            height: double.infinity,
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
                      child: const Text('Submit'),
                    ),
                    ElevatedButton(
                      onPressed: _clearForm,
                      style:
                          ElevatedButton.styleFrom(backgroundColor: Colors.red),
                      child: const Text('Clear'),
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
