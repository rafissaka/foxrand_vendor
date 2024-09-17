import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:vendor/controllers/product_controller.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FoodImagePickerController extends GetxController {
  final ProductController productController = Get.put(ProductController());

  CollectionReference product = FirebaseFirestore.instance.collection("foods");
  RxString foodDownloadURL = ''.obs;

  RxString imagePath = "".obs;

  Future<void> pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);

    if (pickedFile != null) {
      imagePath.value = pickedFile.path;
      productController.getFormData(foodUrl: imagePath.value);
    }
  }

  Future<void> uploadFoodImageToFirebase(
      {String? businessName, String? foodName}) async {
    final storageReference = FirebaseStorage.instance
        .ref()
        .child('foodImages/$businessName/$foodName')
        .child(DateTime.now().toString());
    final uploadTask = storageReference.putFile(File(imagePath.value));
    await uploadTask.whenComplete(() {});
    foodDownloadURL.value = await storageReference.getDownloadURL();
  }

  Future<void> uploadFoodDetails(
      {required String vendorId,
      required Map<String, dynamic> data,
      required BuildContext context}) async {
    return product
        .doc(vendorId)
        .collection('vendor_foods')
        .add(data)
        .then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Food Saved'),
        ),
      );
    });
  }
}
