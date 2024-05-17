// import '../components/main_drawer.dart';
// import '../models/route_model.dart';
// import 'donor_home_page.dart';
// import 'log_in_page.dart';
// import 'org_home_page.dart';
// import 'package:flutter/material.dart';

// class SignUpPage extends StatefulWidget {
//   const SignUpPage({super.key});

//   @override
//   State<SignUpPage> createState() => _SignUpPageState();
// }

// class _SignUpPageState extends State<SignUpPage> {
//   final _formKey = GlobalKey<FormState>();
//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController userNameController = TextEditingController();
//   final TextEditingController passwordController = TextEditingController();
//   final TextEditingController addressController = TextEditingController();
//   final TextEditingController contactNumberController = TextEditingController();
//   String? errorMessage;

//   RouteModel orgHomepage =
//       RouteModel("Home", "/org-home-page", const OrgHomePage());
//   RouteModel donorHomePage =
//       RouteModel("Home", "/donor-home-page", const DonorHomePage());

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       drawer: MainDrawer(routes: [
//         orgHomepage,
//         RouteModel("Logout", "/", const LoginPage()),
//       ]),
//       appBar: AppBar(
//         title: const Text("Sign Up"),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.stretch,
//             children: [
//               TextFormField(
//                 decoration: const InputDecoration(
//                   labelText: 'Username',
//                   prefixIcon: Icon(Icons.person),
//                 ),
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Please enter your username';
//                   }
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 16),
//               TextFormField(
//                 decoration: const InputDecoration(
//                   labelText: 'Email',
//                   prefixIcon: Icon(Icons.email),
//                 ),
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Please enter your email';
//                   }
//                   // Add email validation if necessary
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 16),
//               TextFormField(
//                 decoration: const InputDecoration(
//                   labelText: 'Password',
//                   prefixIcon: Icon(Icons.lock),
//                 ),
//                 obscureText: true,
//                 validator: (value) {
//                   if (value!.isEmpty) {
//                     return 'Please enter your password';
//                   }
//                   // Add password strength validation if necessary
//                   return null;
//                 },
//               ),
//               const SizedBox(height: 16),
//               ElevatedButton(
//                 onPressed: () {
//                   // Implement sign up logic here
//                   if (_formKey.currentState!.validate()) {
//                     // if the form is valid, proceed with sign up
//                     // access form field values using _formKey.currentState
//                   }
//                 },
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.blue,
//                 ),
//                 child: const Text(
//                   'Sign Up',
//                   style: TextStyle(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import '../components/main_drawer.dart';
import '../models/route_model.dart';
import 'donor_home_page.dart';
import 'log_in_page.dart';
import 'org_home_page.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController contactNumberController = TextEditingController();
  final TextEditingController orgNameController = TextEditingController();
  // final TextEditingController proofController = TextEditingController();
  bool isDonor = true;

  RouteModel orgHomepage =
      RouteModel("Home", "/org-home-page", const OrgHomePage());
  RouteModel donorHomePage =
      RouteModel("Home", "/donor-home-page", const DonorHomePage());

  void _resetForm() {
    _formKey.currentState?.reset();
    nameController.clear();
    userNameController.clear();
    passwordController.clear();
    addressController.clear();
    contactNumberController.clear();
    orgNameController.clear();
    proofController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: MainDrawer(routes: [
        orgHomepage,
        RouteModel("Logout", "/", const LoginPage()),
      ]),
      appBar: AppBar(
        title: const Text("Sign Up"),
      ),
      body: Padding(
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
                // const SizedBox(height: 16),
                // TextFormField(
                //   controller: proofController,
                //   decoration: const InputDecoration(
                //     labelText: 'Proof of Legitimacy',
                //     prefixIcon: Icon(Icons.verified),
                //   ),
                //   validator: (value) {
                //     if (value!.isEmpty) {
                //       return 'Please provide proof of legitimacy';
                //     }
                //     return null;
                //   },
                // ),
              ],
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
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // String? error =
                    //           await context.read<UserAuthProvider>().signUp(
                    //                 userNameController.text.trim(),
                    //                 passwordController.text.trim(),
                    //               );
                    //       if (error == null) {
                    //         // Save additional user info to Firestore
                    //         final user = context.read<UserAuthProvider>().user;
                    //         await FirebaseFirestore.instance
                    //             .collection('users')
                    //             .doc(user?.uid)
                    //             .set({
                    //           'Name': nameController.text.trim(),
                    //           'Username': userNameController.text.trim(),
                    //           'Address': addresController.text.trim(),
                    //           'Contact Number' : contactNumberController.text.trim(),
                    //         });
                    //         Navigator.pop(context);
                    //       } else {
                    //         setState(() {
                    //           errorMessage = error;
                    //         });
                    //       }
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                ),
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
            ],
          ),
        ),
      ),
    );
  }
}
