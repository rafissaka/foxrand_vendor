import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class FirebaseController extends GetxController {
  User? user = FirebaseAuth.instance.currentUser;
  final CollectionReference vendor =
      FirebaseFirestore.instance.collection("vendors");

  Future<void> updateVendorField(String fieldName, dynamic newValue) async {
    try {
      // Reference to the document in the 'vendor' collection
      DocumentReference vendorRef = vendor.doc(user!.uid);

      // Update the specified field with the new value
      await vendorRef.update({fieldName: newValue});
    } catch (e) {
      if (kDebugMode) {
        print('Error updating field: $e');
      }
    }
  }
}
