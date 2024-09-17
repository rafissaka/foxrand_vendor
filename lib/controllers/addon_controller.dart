import 'package:get/get.dart';
import 'package:vendor/controllers/product_controller.dart';

import '../models/addon_models.dart';

class AddonController extends GetxController {
  final ProductController productController = Get.put(ProductController());
  RxString addonName = ''.obs;

  RxDouble price = 0.0.obs;
  RxList<Addon> addons = <Addon>[].obs;

  void addAddon(
    String name,
    double price,
  ) {
    addons.add(Addon(
      name: name,
      price: price,
    ));
    productController.getFormData(addOns: addons);
  }

  void clearFields() {
    addonName.value = '';
    price.value = 0.0;
  }

  void saveAddon() {
    final addon = Addon(name: addonName.value, price: price.value);
    Get.back(result: addon);
    clearFields();
  }
}
