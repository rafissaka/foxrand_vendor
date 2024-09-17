import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../pages/shop_registration_screen.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;
  Future<void> signIn(
      String email, String password, BuildContext context) async {
    try {
      context.loaderOverlay.show(
        progress: 'Doing progress #0',
      );
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      if (!context.mounted) return;
      Get.back();

      Get.offAll(() => const RegistrationScreen());

      if (kDebugMode) {
        print('Signed in: ${userCredential.user!.displayName}');
      }
    } on FirebaseAuthException catch (e) {
      context.loaderOverlay.hide();
      if (e.code == 'auth/user-not-found') {
        Get.snackbar(
          "User not found", "Please register an account",
          backgroundColor: Colors.red, // Customize the background color
          colorText: Colors.white, // Customize the text color
          snackPosition: SnackPosition.TOP, // Position the snackbar at the top
          borderRadius: 10, // Customize the border radius
          isDismissible: true, // Allow dismissing the snackbar on tap
          dismissDirection:
              DismissDirection.horizontal, // Dismiss in horizontal direction
          duration: const Duration(seconds: 3),
        );
      } else if (e.code == 'INVALID_LOGIN_CREDENTIALS') {
        Get.snackbar(
          "INVALID_LOGIN_CREDENTIALS", "Please enter correct logins.",
          backgroundColor: Colors.red, // Customize the background color
          colorText: Colors.white, // Customize the text color
          snackPosition: SnackPosition.TOP, // Position the snackbar at the top
          borderRadius: 10, // Customize the border radius
          isDismissible: true, // Allow dismissing the snackbar on tap
          dismissDirection:
              DismissDirection.horizontal, // Dismiss in horizontal direction
          duration: const Duration(seconds: 3),
        );
      } else {
        Get.snackbar(
          "Error", "An error occurred. Please try again later.",
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
      context.loaderOverlay.hide();
    }
  }
}
