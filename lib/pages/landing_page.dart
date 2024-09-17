import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vendor/controllers/firebase_controller.dart';
import 'package:vendor/pages/dasbboard_page.dart';

import 'package:vendor/pages/waiting_scree.dart';

import '../models/vendor_models.dart';
import 'shop_registration_screen.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final firebaseController = Get.put(FirebaseController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder<DocumentSnapshot>(
      stream: firebaseController.vendor
          .doc(firebaseController.user!.uid)
          .snapshots(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text('Something went wrong'));
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator.adaptive());
        }

        if (!snapshot.data!.exists) {
          return const RegistrationScreen();
        }
     
        Vendor vendor =
            Vendor.fromJson(snapshot.data!.data() as Map<String, dynamic>);
        if (vendor.approved == true) {
          return const DashBoardScreen();
        }
        return const WaitToCompleteVerificationScreen();
      },
    ));
  }
}
