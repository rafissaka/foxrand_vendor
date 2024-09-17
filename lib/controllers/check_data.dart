import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class CollectionController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  RxBool hasVendorCollection = false.obs;

  @override
  void onInit() {
    checkVendorCollection();
    super.onInit();
  }

  Future<void> checkVendorCollection() async {
    final user = _auth.currentUser;
    if (user != null) {
      FirebaseFirestore.instance
          .collection('vendors')
          .doc(user.uid)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          hasVendorCollection.value = true;
        } else {
          hasVendorCollection.value = false;
        }
      });
      // print("Vendor date is: ${hasVendorCollection.value}");
    }
  }
}
