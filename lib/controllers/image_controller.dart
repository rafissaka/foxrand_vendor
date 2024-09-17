import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

class ImagePickerController extends GetxController {
  RxString selectedImagePath = ''.obs;
  RxString downloadURL = ''.obs;
  RxString imagePath = "".obs;

  Future<void> uploadImageToFirebase() async {
    // Get a reference to the Firebase storage bucket
    final storageReference = FirebaseStorage.instance
        .ref()
        .child('vendorBanners')
        .child(DateTime.now().toString());

    // Upload the file
    final uploadTask = storageReference.putFile(File(imagePath.value));

    // Wait for the upload to complete
    await uploadTask.whenComplete(() {});

    // Get the download URL
    downloadURL.value = await storageReference.getDownloadURL();
  }
}
