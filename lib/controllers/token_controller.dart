import 'package:get/get.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

class FCMController extends GetxController {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  String? fcmToken;

  Future<void> retrieveToken() async {
    fcmToken = await _firebaseMessaging.getToken();
  }
}