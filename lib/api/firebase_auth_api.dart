import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_model.dart' as user_model;

class FirebaseAuthAPI {
  static final firebase_auth.FirebaseAuth auth =
      firebase_auth.FirebaseAuth.instance;
  static final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<firebase_auth.User?> getUser() {
    return auth.authStateChanges();
  }

  Future<String?> signIn(String email, String password) async {
    try {
      firebase_auth.UserCredential credential = await auth
          .signInWithEmailAndPassword(email: email, password: password);

      // fetch additional user details
      DocumentSnapshot userDoc =
          await firestore.collection('users').doc(credential.user?.uid).get();
      if (!userDoc.exists) {
        return 'User details not found.';
      }

      return null; // return null if there's no error
    } on firebase_auth.FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        return 'Invalid email provided.';
      } else if (e.code == 'user-not-found') {
        return 'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return 'Wrong password provided for that user.';
      }
      return e.message;
    } catch (e) {
      print(e);
      return 'An unknown error occurred.';
    }
  }

  Future<String?> signUp(user_model.User user) async {
    try {
      // check if username is already taken
      QuerySnapshot userQuery = await firestore
          .collection('users')
          .where('username', isEqualTo: user.username)
          .get();

      if (userQuery.docs.isNotEmpty) {
        return 'Username is already taken.';
      }

      firebase_auth.UserCredential credential =
          await auth.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password,
      );

      // save additional user details in Firestore
      await firestore.collection('users').doc(credential.user?.uid).set({
        'name': user.name,
        'username': user.username,
        'email': user.email,
        'address': user.address,
        'contactNo': user.contactNo,
        'role': user.role,
        'profilePhoto': user.profilePhoto,
        'about': user.about,
        'proofsOfLegitimacy': user.proofsOfLegitimacy,
        'isApproved': user.isApproved,
        'isOpenForDonation': user.isOpenForDonation,
      });

      return null; // return null if there's no error
    } on firebase_auth.FirebaseAuthException catch (e) {
      if (e.code == 'invalid-email') {
        return 'Invalid email provided.';
      } else if (e.code == 'weak-password') {
        return 'Too weak! Password should be at least 6 characters';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
      return e.message;
    } catch (e) {
      print(e);
      return 'An unknown error occurred.';
    }
  }

  Future<void> signOut() async {
    await auth.signOut();
  }
}
