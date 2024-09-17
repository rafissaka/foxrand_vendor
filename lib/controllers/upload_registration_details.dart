import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:vendor/pages/waiting_scree.dart';

class UploadDetailsController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> saveDetails({
    String? downloadURL,
    String? logoDownloadURL,
    String? businessName,
    String? contact,
    String? secondContact,
    String? email,
    String? selectedShopType,
    String? secondContactName,
    String? secContact,
    String? secSecContact,
    String? secEmail,
    String? shopAddress,
    String? landmark,
    String? accountName,
    int? accountNumber,
    String? mobileMoneyName,
    String? mobileMoneyNumber,
    String? selectedcourierServices,
    String? specialRequirements,
    GeoPoint? geoLocation,
    String? token,
    required BuildContext context,
  }) async {
    context.loaderOverlay.show();

    try {
      await _firestore.collection('vendors').doc(_auth.currentUser!.uid).set({
        "shopUrl": downloadURL,
        "logoUrl": logoDownloadURL,
        "businessName": businessName,
        "personalContact": contact,
        "secondContact": secondContact,
        "email": email,
        "shopType": selectedShopType,
        "secondContactName": secondContactName,
        "secondContactNumber": secContact,
        "secondContactTwo": secSecContact,
        "secondEmail": secEmail,
        "shopAddress": shopAddress,
        "landmark": landmark,
        "geoLocation": geoLocation,
        "accountName": accountName,
        "accountNumber": accountNumber,
        "mobileMoneyName": mobileMoneyName,
        "mobileMoneyNumber": mobileMoneyNumber,
        "selectedcourierServices": selectedcourierServices,
        "specialRequirements": specialRequirements,
        "uid": _auth.currentUser!.uid,
        "token": token,
        "approved": false,
        "active": false,
      });

      // Registration success
      Get.snackbar('Success', 'Registration successful');

      // ignore: use_build_context_synchronously
      context.loaderOverlay.hide();

      Get.offAll(() => const WaitToCompleteVerificationScreen());
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      if (context.mounted) {
        context.loaderOverlay.hide();
      }
    }
  }
}
