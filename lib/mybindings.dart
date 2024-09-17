import 'package:get/get.dart';
import 'package:vendor/controllers/image_controller.dart';
import 'package:vendor/controllers/internet_controller.dart';

import 'controllers/addon_controller.dart';
import 'controllers/check_data.dart';
import 'controllers/firebase_controller.dart';
import 'controllers/home_controller.dart';
import 'controllers/locaton_controller.dart';
import 'controllers/login_controller.dart';
import 'controllers/logo_imagepick.dart';
import 'controllers/onboarding_controller.dart';
import 'controllers/product_controller.dart';
import 'controllers/user_controller.dart';

class MyBinding implements Bindings {
  @override
  void dependencies() {
    // Initialize dependencies here
    Get.lazyPut(() => ConnectivityController());
    Get.lazyPut(() => AddonController());
    Get.lazyPut(() => CollectionController());
    Get.lazyPut(() => FirebaseController());
    Get.lazyPut(() => HomeController());
    Get.lazyPut(() => ImagePickerController());
    Get.lazyPut(() => LocationController());
    Get.lazyPut(() => LoginController());
    Get.lazyPut(() => LogoPickerController());
    Get.lazyPut(() => OnboardingController());
    Get.lazyPut(() => ProductController());
    Get.lazyPut(() => UserController());
  }
}
