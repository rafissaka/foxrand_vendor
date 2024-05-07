import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FCMController extends GetxController {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? fcmToken;

  var token = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize token with the current token value
    _firebaseMessaging.getToken().then((value) {
      token.value = value ?? '';
    });

    // Listen for token refresh events and update the token value
    _firebaseMessaging.onTokenRefresh.listen((newToken) {
      // Only update if the token has changed
      if (newToken != token.value) {
        token.value = newToken;
        // Update token in Firestore only if "vendors" collection exists
        checkVendorCollectionExistence().then((exists) {
          if (exists) {
            updateTokenInFirestore(newToken);
          } else {
            if (kDebugMode) {
              print('Error: "vendors" collection does not exist.');
            }
          }
        });
      }
    });
  }

  Future<void> retrieveToken() async {
    fcmToken = await _firebaseMessaging.getToken();
  }

  Future<bool> checkVendorCollectionExistence() async {
    try {
      // Get the current user's UID
      String uid = FirebaseAuth.instance.currentUser!.uid;
      // Update token field in Firestore
      // Check if the "vendors" collection exists
      final result = await _firestore.collection('vendors').doc(uid).get();
      return result.exists;
    } catch (error) {
      if (kDebugMode) {
        print('Error checking collection existence: $error');
      }
      return false;
    }
  }

  Future<void> updateTokenInFirestore(String newToken) async {
    try {
      // Get the current user's UID
      String uid = FirebaseAuth.instance.currentUser!.uid;
      // Update token field in Firestore
      await _firestore.collection('vendors').doc(uid).update({
        "token": newToken,
      });
      if (kDebugMode) {
        print('Token updated successfully in Firestore');
      }
    } catch (error) {
      if (kDebugMode) {
        print('Error updating token in Firestore: $error');
      }
    }
  }
}
