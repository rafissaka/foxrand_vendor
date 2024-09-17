import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../pages/shop_registration_screen.dart';

class SignUpController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  var isLoading = false.obs; // Observable for tracking loading state

  Future<void> signUpWithEmailAndPassword(
      String name, String email, String password, BuildContext context) async {
    try {
      // Set loading state to true
      context.loaderOverlay.show(
        progress: 'Doing progress #0',
      );
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Add user's name to their profile
      userCredential.user!.updateDisplayName(name);

      // Update the user object
      User? currentUser = _auth.currentUser;
      if (currentUser != null) {
        currentUser = _auth.currentUser;
      }

      // Perform any additional actions after sign-up (e.g., navigate to the home screen)
      // Replace with your own logic

      Get.offAll(() => const RegistrationScreen());
      if (!context.mounted) return;
      Get.back();
    } on FirebaseAuthException catch (e) {
      context.loaderOverlay.hide();
      if (e.code == 'email-already-in-use') {
        Get.snackbar(
          "Error",
          'The account already exists for that email.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          borderRadius: 10,
          isDismissible: true,
          dismissDirection: DismissDirection.horizontal,
          duration: const Duration(seconds: 3),
        );
      } else if (e.code == 'weak-password') {
        Get.snackbar(
          "Error",
          'The password provided is too weak.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          borderRadius: 10,
          isDismissible: true,
          dismissDirection: DismissDirection.horizontal,
          duration: const Duration(seconds: 3),
        );
      } else if (e.code == 'operation-not-allowed') {
        Get.snackbar(
          "Error",
          'Enable email/password accounts in the Firebase Console.',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          borderRadius: 10,
          isDismissible: true,
          dismissDirection: DismissDirection.horizontal,
          duration: const Duration(seconds: 3),
        );
      } else if (e.code == 'invalid-email') {
        Get.snackbar(
          "Error",
          'Email address is not valid..',
          backgroundColor: Colors.red,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
          borderRadius: 10,
          isDismissible: true,
          dismissDirection: DismissDirection.horizontal,
          duration: const Duration(seconds: 3),
        );
      }
    } finally {
      context.loaderOverlay.hide(); // Set loading state to false
    }
  }
}
