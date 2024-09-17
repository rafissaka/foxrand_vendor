import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class ProductUploadController extends GetxController {
  final CollectionReference _productsCollection =
      FirebaseFirestore.instance.collection('products');
  final FirebaseAuth auth = FirebaseAuth.instance;

  RxBool isloading = false.obs;
  List<String> downloadUrls = [];

  Future<void> uploadData(
      {required String businessName,
      required String productName,
      required double productPrice,
      required List<String> colorAvailable,
      required String productDesc,
      required bool isSelectedFr,
      required bool isSelected,
      required String? selectedCategory,
      required double currentSliderValue,
      required double currentHazardValue,
      required List<XFile> images,
      required BuildContext context}) async {
    try {
      isloading.value = true;
      await uploadImages(
              imageFiles: images,
              businessName: businessName,
              productName: productName)
          .then((value) async {
        await _productsCollection
            .doc(auth.currentUser!.uid)
            .collection("vendor_products")
            .add({
          'productName': productName,
          'productPrice': productPrice,
          'colorAvailable': colorAvailable,
          'productDesc': productDesc,
          'Fragible': isSelectedFr,
          'Hazardousness': isSelected,
          'selectedCategory': selectedCategory,
          'currentSliderValue': currentSliderValue,
          'currentHazardValue': currentHazardValue,
          'productUrls': downloadUrls,
          "seller": businessName,
          "approved": false
        }).then((value) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Product Saved'),
            ),
          );
        });
      });
    } catch (e) {
      throw Exception('Error uploading images: $e');
    } finally {
      isloading.value = false;
    }
  }

  Future<void> uploadImages({
    required List<XFile> imageFiles,
    required String businessName,
    required String productName,
  }) async {
    try {
      for (int i = 0; i < imageFiles.length; i++) {
        XFile imageFile = imageFiles[i];
        String imageName = path.basename(imageFile.path);

        // Get the file path from the XFile object
        File file = File(imageFile.path);

        firebase_storage.Reference ref = firebase_storage
            .FirebaseStorage.instance
            .ref()
            .child('productImages/$businessName/$productName/$imageName');
        firebase_storage.UploadTask uploadTask = ref.putFile(file);

        await uploadTask.whenComplete(() async {
          String downloadUrl = await ref.getDownloadURL();
          downloadUrls.add(downloadUrl);
        });
      }
    } catch (e) {
      throw Exception('Error uploading images: $e');
    }
  }
}
