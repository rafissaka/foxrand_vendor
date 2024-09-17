import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../models/vendor_models.dart';

class UserController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  var isLoading = true.obs;
  final Rx<Vendor?> user = Rx<Vendor?>(null);

  void updateUser(Vendor newUser) {
    user.value = newUser;
  }

  @override
  void onInit() {
    super.onInit();
    getUseruserData();
  }

  getUseruserData() async {
    try {
      isLoading.value = true;
      String uid = _auth.currentUser!.uid;

      final docSnapshot =
          await FirebaseFirestore.instance.collection('vendors').doc(uid).get();

      if (docSnapshot.exists) {
        final userData = docSnapshot.data() as Map<String, dynamic>;

        final newUser = Vendor(
            email: userData['email'] ?? '',
            token: userData['token'] ?? '',
            accountName: userData['accountName'] ?? '',
            accountNumber: userData['accountNumber'] ?? '',
            approved: userData['approved'] ?? '',
            businessName: userData['businessName'] ?? '',
            contact: userData['personalContact'] ?? '',
            downloadURL: userData['shopUrl'] ?? '',
            secEmail: userData['secondEmail'],
            geoLocation: userData['geoLocation'] ?? '',
            landmark: userData['landmark'] ?? '',
            logoDownloadURL: userData['logoUrl'] ?? '',
            mobileMoneyName: userData['mobileMoneyName'] ?? '',
            mobileMoneyNumber: userData['mobileMoneyNumber'] ?? '',
            secContact: userData['secondContactNumber'] ?? '',
            secSecContact: userData['secondContactTwo'] ?? '',
            secondContact: userData['secondContact'] ?? '',
            secondContactName: userData['secondContactName'] ?? '',
            selectedShopType: userData['selectedShopType'] ?? '',
            selectedcourierServices: userData['selectedcourierServices'] ?? '',
            shopAddress: userData['shopAddress'] ?? '',
            specialRequirements: userData['specialRequirements'] ?? '',
            uid: userData['uid'] ?? '',
            active: userData['active'] ?? '');
        updateUser(newUser);
      } else {
        user.value = null;
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error retrieving user userData: $e');
      }
      user.value = null;
    } finally {
      isLoading.value = false; // Set loading to false after fetching data
    }
  }

  void subscribeToUserChanges() {
    String uid = _auth.currentUser!.uid;

    FirebaseFirestore.instance
        .collection('vendors')
        .doc(uid)
        .snapshots()
        .listen((docSnapshot) {
      if (docSnapshot.exists) {
        final userData = docSnapshot.data() as Map<String, dynamic>;
        final newUser = Vendor(
            email: userData['email'] ?? '',
            token: userData['token'] ?? '',
            accountName: userData['accountName'] ?? '',
            accountNumber: userData['accountNumber'] ?? '',
            approved: userData['approved'] ?? '',
            businessName: userData['businessName'] ?? '',
            contact: userData['personalContact'],
            downloadURL: userData['shopUrl'] ?? '',
            secEmail: userData['secondEmail'] ?? '',
            geoLocation: userData['geoLocation'] ?? '',
            landmark: userData['landmark'] ?? '',
            logoDownloadURL: userData['logoUrl'] ?? '',
            mobileMoneyName: userData['mobileMoneyName'] ?? '',
            mobileMoneyNumber: userData['mobileMoneyNumber'] ?? '',
            secContact: userData['secondContactNumber'] ?? '',
            secSecContact: userData['secondContactTwo'] ?? '',
            secondContact: userData['secondContact'] ?? '',
            secondContactName: userData['secondContactName'] ?? '',
            selectedShopType: userData['shopType'] ?? '',
            selectedcourierServices: userData['selectedcourierServices'] ?? '',
            shopAddress: userData['shopAddress'] ?? '',
            specialRequirements: userData['specialRequirements'] ?? '',
            uid: userData['uid'] ?? '',
            active: userData['active'] ?? '');
        updateUser(newUser);
      }
    });
  }
}
