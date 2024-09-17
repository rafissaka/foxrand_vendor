import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


import 'package:get/get.dart';
import 'package:overlay_loading_progress/overlay_loading_progress.dart';

import '../pages/shop_registration_screen.dart';

class SignUpController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> signUpWithEmailAndPassword(
      String name, String email, String password, BuildContext context) async {
    try {
      OverlayLoadingProgress.start(
        context,
        gifOrImagePath: 'images/log.gif',
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
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        Get.snackbar(
          "Error", 'The account already exists for that email.',
          backgroundColor: Colors.red, // Customize the background color
          colorText: Colors.white, // Customize the text color
          snackPosition: SnackPosition.TOP, // Position the snackbar at the top
          borderRadius: 10, // Customize the border radius
          isDismissible: true, // Allow dismissing the snackbar on tap
          dismissDirection:
              DismissDirection.horizontal, // Dismiss in horizontal direction
          duration: const Duration(seconds: 3),
        );
      } else if (e.code == 'weak-password') {
        Get.snackbar(
          "Error", 'The password provided is too weak.',
          backgroundColor: Colors.red, // Customize the background color
          colorText: Colors.white, // Customize the text color
          snackPosition: SnackPosition.TOP, // Position the snackbar at the top
          borderRadius: 10, // Customize the border radius
          isDismissible: true, // Allow dismissing the snackbar on tap
          dismissDirection:
              DismissDirection.horizontal, // Dismiss in horizontal direction
          duration: const Duration(seconds: 3),
        );
      } else if (e.code == 'operation-not-allowed') {
        Get.snackbar(
          "Error", 'Enable email/password accounts in the Firebase Console.',
          backgroundColor: Colors.red, // Customize the background color
          colorText: Colors.white, // Customize the text color
          snackPosition: SnackPosition.TOP, // Position the snackbar at the top
          borderRadius: 10, // Customize the border radius
          isDismissible: true, // Allow dismissing the snackbar on tap
          dismissDirection:
              DismissDirection.horizontal, // Dismiss in horizontal direction
          duration: const Duration(seconds: 3),
        );
      } else if (e.code == 'invalid-email') {
        Get.snackbar(
          "Error", 'Email address is not valid..',
          backgroundColor: Colors.red, // Customize the background color
          colorText: Colors.white, // Customize the text color
          snackPosition: SnackPosition.TOP, // Position the snackbar at the top
          borderRadius: 10, // Customize the border radius
          isDismissible: true, // Allow dismissing the snackbar on tap
          dismissDirection:
              DismissDirection.horizontal, // Dismiss in horizontal direction
          duration: const Duration(seconds: 3),
        );
      }
    } finally {
      OverlayLoadingProgress.stop();
    }
  }
}
