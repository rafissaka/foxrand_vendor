import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProductImagePickerController extends GetxController {
  final _pickedImages = <XFile>[].obs;

  List<XFile> get pickedImages => _pickedImages.toList();
  int get currentIndex => _currentIndex.value;
  final RxInt _currentIndex = 0.obs; // This stays the same

  // Public method to set currentIndex
  set currentIndex(int index) => _currentIndex.value = index;
  Future<void> pickImage(ImageSource source) async {
    try {
      final pickedImage = await ImagePicker().pickMultiImage();
      if (_pickedImages.length + pickedImage.length <= 4) {
        _pickedImages.addAll(pickedImage);
        _currentIndex.value =
            _pickedImages.length - 1; // Update to latest image
      } else {
        Get.snackbar('Error', 'You can only pick up to 4 images');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to pick image');
    }
  }

  void nextImage() {
    if (_currentIndex.value < _pickedImages.length - 1) {
      _currentIndex.value++;
    }
  }

  void previousImage() {
    if (_currentIndex.value > 0) {
      _currentIndex.value--;
    }
  }

  void clearPickedImages() {
    _pickedImages.clear();
  }
}
