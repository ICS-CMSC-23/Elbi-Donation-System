import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
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
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController contactNumberController = TextEditingController();
  final TextEditingController orgNameController = TextEditingController();
  bool isDonor = true;
  String? _imagePath;
  List<File> _orgImages = [];
  String? errorMessage;

  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _imagePath = pickedFile.path;
      });
    }
  }

  Future<void> _pickMultipleImages() async {
    final List<XFile>? pickedFiles = await ImagePicker().pickMultiImage();
    if (pickedFiles != null && pickedFiles.isNotEmpty) {
      setState(() {
        _orgImages.addAll(pickedFiles.map((file) => File(file.path)));
      });
    }
  }

  void _remove() {
    setState(() {
      _imagePath = null;
    });
  }

  void _removeImage(int index) {
    setState(() {
      _orgImages.removeAt(index);
    });
  }

  void _resetForm() {
    _formKey.currentState?.reset();
    nameController.clear();
    userNameController.clear();
    emailController.clear();
    passwordController.clear();
    addressController.clear();
    contactNumberController.clear();
    orgNameController.clear();
    setState(() {
      _imagePath = null;
      _orgImages.clear();
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
                  onTap: _pickImage,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: _imagePath != null
                            ? FileImage(File(_imagePath!))
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
                            onTap: () => _remove(),
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
                TextFormField(
                  controller: addressController,
                  decoration: const InputDecoration(
                    labelText: 'Address',
                    prefixIcon: Icon(Icons.home),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter your address';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
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
                if (!isDonor) ...[
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: _pickMultipleImages,
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
                              width: double
                                  .infinity, // Ensures the image covers the entire grid cell
                              height: double.infinity,
                            ),
                          ),
                          Positioned(
                            top: 0,
                            right: 0,
                            child: GestureDetector(
                              onTap: () => _removeImage(index),
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
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      List<String> proofsOfLegitimacy =
                          _orgImages.map((file) => file.path).toList();
                      user_model.User newUser = user_model.User(
                        name: isDonor
                            ? nameController.text
                            : orgNameController.text,
                        username: userNameController.text,
                        email: emailController.text,
                        password: passwordController.text,
                        address: [addressController.text],
                        contactNo: contactNumberController.text,
                        role: isDonor ? "donor" : "organization",
                        profilePhoto: _imagePath != null
                            ? _imagePath!
                            : 'assets/images/portrait-placeholder.jpg',
                        about: "A donor na igop",
                        proofsOfLegitimacy: proofsOfLegitimacy,
                        // [
                        //   "https://i.pinimg.com/originals/f5/24/e1/f524e1e728b829b039c84f5ee4f1478a.webp"
                        // ],
                        isApproved: false,
                        isOpenForDonation: false,
                      );
                      String? error =
                          await context.read<AuthProvider>().signUp(newUser);

                      if (error == null) {
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
                if (errorMessage != null) ...[
                  const SizedBox(height: 16),
                  Center(
                    child: Text(
                      errorMessage!,
                      style: const TextStyle(color: Colors.red),
                    ),
                  )
                ],
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
