import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import 'vendor_controller.dart';

class LogoPickerController extends GetxController {
  final VendorController vendorController = Get.put(VendorController());
  RxString imagePath = "".obs;
  RxString logoDownloadURL = ''.obs;

  Future<void> pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      imagePath.value = pickedFile.path;
      vendorController.getFormData(logoUrl: imagePath.value);
    }
  }

  Future<void> uploadImageToFirebase() async {
    // Get a reference to the Firebase storage bucket
    final storageReference = FirebaseStorage.instance
        .ref()
        .child('logoUrl')
        .child(DateTime.now().toString());

    // Upload the file
    final uploadTask = storageReference.putFile(File(imagePath.value));

    // Wait for the upload to complete
    await uploadTask.whenComplete(() {});

    // Get the download URL
    logoDownloadURL.value = await storageReference.getDownloadURL();
  }
}
