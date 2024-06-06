import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../components/upload_helper.dart';
import '../models/user_model.dart' as user_model;
import '../providers/auth_provider.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController aboutController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  // final TextEditingController addressController = TextEditingController();
  List<TextEditingController> addressControllers = [TextEditingController()];
  final TextEditingController contactNumberController = TextEditingController();
  final TextEditingController orgNameController = TextEditingController();
  bool isDonor = true;
  String? _imagePath;
  List<File> _orgImages = [];
  List<String> _orgImages64 = [];
  String? errorMessage;

  void _resetForm() {
    _formKey.currentState?.reset();
    nameController.clear();
    userNameController.clear();
    aboutController.clear();
    emailController.clear();
    passwordController.clear();
    contactNumberController.clear();
    orgNameController.clear();
    for (var controller in addressControllers) {
      controller.clear();
    }
    setState(() {
      _imagePath = null;
      _orgImages.clear();
      errorMessage = null;
    });
  }

  void _addAddressField() {
    setState(() {
      addressControllers.add(TextEditingController());
    });
  }

  void _removeAddressField(int index) {
    setState(() {
      addressControllers.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Sign Up"),
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
                      label: const Text('Donor'),
                      selected: isDonor,
                      onSelected: (selected) {
                        setState(() {
                          isDonor = true;
                        });
                      },
                    ),
                    const SizedBox(width: 8),
                    ChoiceChip(
                      label: const Text('Organization'),
                      selected: !isDonor,
                      onSelected: (selected) {
                        setState(() {
                          isDonor = false;
                        });
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                GestureDetector(
                  onTap: () async {
                    String? imagePath = await pickImage();
                    List<int> bytes = utf8.encode(imagePath!);
                    int sizeInBytes = bytes.length;
                    print('Size of base64 string in bytes: $sizeInBytes');

                    if (sizeInBytes < 1000000) {
                      setState(() {
                        _imagePath = imagePath;
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
                  },
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: _imagePath != null
                            ? MemoryImage(decodeBase64Image(_imagePath!))
                            : const AssetImage(
                                'assets/images/portrait-placeholder.jpg',
                              ) as ImageProvider,
                      ),
                      if (_imagePath == null)
                        Container(
                          width: 100,
                          height: 100,
                          decoration: const BoxDecoration(
                            color: Colors.black45,
                            shape: BoxShape.circle,
                          ),
                          child: const Center(
                            child: Text(
                              'Click to Upload',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      if (_imagePath != null)
                        Positioned(
                          top: 10,
                          right: 130,
                          child: GestureDetector(
                            onTap: () async {
                              String? imagePath = await pickImage();
                              setState(() {
                                _imagePath = imagePath;
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
                                size: 20,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                if (isDonor) ...[
                  TextFormField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: 'Name',
                      prefixIcon: Icon(Icons.person),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: userNameController,
                    decoration: const InputDecoration(
                      labelText: 'Username',
                      prefixIcon: Icon(Icons.person_outline),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter your username';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: aboutController,
                    decoration: const InputDecoration(
                      labelText: 'Biography',
                      prefixIcon: Icon(Icons.info),
                    ),
                  ),
                ] else ...[
                  TextFormField(
                    controller: orgNameController,
                    decoration: const InputDecoration(
                      labelText: 'Name of Organization',
                      prefixIcon: Icon(Icons.business),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the name of your organization';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: aboutController,
                    decoration: const InputDecoration(
                      labelText: 'Tagline',
                      prefixIcon: Icon(Icons.info),
                    ),
                  ),
                ],
                const SizedBox(height: 16),
                TextFormField(
                  controller: emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    prefixIcon: Icon(Icons.email),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock),
                  ),
                  obscureText: true,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your password';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                // TextFormField(
                //   controller: addressController,
                //   decoration: const InputDecoration(
                //     labelText: 'Address',
                //     prefixIcon: Icon(Icons.home),
                //   ),
                //   validator: (value) {
                //     if (value!.isEmpty) {
                //       return 'Please enter your address';
                //     }
                //     return null;
                //   },
                // ),
                TextFormField(
                  controller: contactNumberController,
                  decoration: const InputDecoration(
                    labelText: 'Contact Number',
                    prefixIcon: Icon(Icons.phone),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your contact number';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                for (int i = 0; i < addressControllers.length; i++)
                Column(
                  children: [
                    TextFormField(
                      controller: addressControllers[i],
                      decoration: InputDecoration(
                        labelText: 'Address ${i + 1}',
                        prefixIcon: Icon(Icons.home),
                        suffixIcon: i == addressControllers.length - 1
                            ? IconButton(
                                icon: Icon(Icons.add),
                                onPressed: () {
                                  setState(() {
                                    addressControllers
                                        .add(TextEditingController());
                                  });
                                },
                              )
                            : IconButton(
                                icon: Icon(Icons.remove),
                                onPressed: () {
                                  setState(() {
                                    addressControllers.removeAt(i);
                                  });
                                },
                              ),
                      ),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your address';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
                if (!isDonor) ...[
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () async {
                      List<File> images = await pickMultipleImages();
                      List<String> base64Images =
                          await convertImagesToBase64(images);

                      for (var i = 0; i < images.length; i++) {
                        List<int> bytes = utf8.encode(base64Images[i]!);
                        int sizeInBytes = bytes.length;
                        print('Size of base64 string in bytes: $sizeInBytes');
                        if (sizeInBytes < 1000000) {
                          setState(() {
                            _orgImages.add(images[i]);
                            _orgImages64.add(base64Images[i]);
                          });
                        } else {
                          print("Please upload image less than 1MB.");
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text('Please upload image less than 1MB.'),
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
                    child: const Text('Upload Proof of Legitimacy'),
                  ),
                  if (_orgImages.isNotEmpty) const SizedBox(height: 16),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                    ),
                    itemCount: _orgImages.length,
                    itemBuilder: (context, index) {
                      return Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.file(
                              _orgImages[index],
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
                                  removeImage(_orgImages, index);
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
                ],
                if (errorMessage != null) ...[
                  const SizedBox(height: 16),
                  Center(
                    child: Text(
                      errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  )
                ],
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      if (!isDonor && _orgImages.isEmpty) {
                        setState(() {
                          errorMessage =
                              'Please upload at least one proof of legitimacy';
                        });
                        return;
                      }
                      List<String> addresses = addressControllers.map((controller) => controller.text.trim()).toList();
                      List<String> proofsOfLegitimacy = _orgImages64;
                      user_model.User newUser = user_model.User(
                        name: isDonor
                            ? nameController.text
                            : orgNameController.text,
                        username: isDonor
                            ? userNameController.text
                            : orgNameController.text,
                        email: emailController.text,
                        password: passwordController.text,
                        // address: addressControllers.map((controller) => controller.text).toList(),
                        address: addresses,
                        contactNo: contactNumberController.text,
                        role: isDonor ? "donor" : "organization",
                        profilePhoto: _imagePath != null
                            ? _imagePath!
                            : 'assets/images/portrait-placeholder.jpg',
                        about: aboutController.text,
                        proofsOfLegitimacy: proofsOfLegitimacy,
                        isApproved: false,
                        isOpenForDonation: false,
                      );
                      String? error =
                          await context.read<AuthProvider>().signUp(newUser);

                      if (error == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Sign up successful!'),
                            backgroundColor: Colors.green,
                          ),
                        );
                        Navigator.pushReplacementNamed(context, "/login");
                      } else {
                        setState(() {
                          errorMessage = error;
                        });
                      }
                    }
                  },
                  child: const Text(
                    'Sign Up',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                ElevatedButton(
                  onPressed: _resetForm,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                  ),
                  child: const Text(
                    'Reset',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Text('Already a User?'),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, "/login");
                      },
                      child: Text(
                        'Login',
                        style: TextStyle(
                            color: Theme.of(context).primaryColor,
                            fontSize: 15),
                      ),
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
