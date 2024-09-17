import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

class ConnectivityController extends GetxController {
  final Connectivity _connectivity = Connectivity();

  final RxBool _isConnected = RxBool(false);

  bool get isConnected => _isConnected.value;

  @override
  void onInit() {
    super.onInit();
    initConnectivity();
    _connectivity.onConnectivityChanged.listen((ConnectivityResult result) {
      _isConnected.value = result != ConnectivityResult.none;
    });
  }

  Future<void> initConnectivity() async {
    ConnectivityResult result = ConnectivityResult.none;
    try {
      result = await _connectivity.checkConnectivity();
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    _isConnected.value = result != ConnectivityResult.none;
  }
}
