import 'package:get_storage/get_storage.dart';
import 'package:get/get.dart';


class OnboardingController extends GetxController {
  final storage = GetStorage();
  RxBool isOnboardingCompleted = false.obs;

  @override
  void onInit() {
    super.onInit();
    checkOnboardingStatus();
  }

  void checkOnboardingStatus() {
    isOnboardingCompleted.value = storage.read('isOnboardingCompleted') ?? false;
  }

  void setOnboardingCompleted() {
    isOnboardingCompleted.value = true;
    storage.write('isOnboardingCompleted', true);
  }
}