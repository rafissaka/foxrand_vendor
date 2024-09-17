import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ColorPickerController extends GetxController {
  var selectedColors = <Color>[].obs;

  void addColor(Color? color) {
    if (color != null && selectedColors.length < 10) {
      selectedColors.add(color);
    }
  }

  // void removeColor(int index) {
  //   if (index >= 0 && index < selectedColors.length) {
  //     selectedColors.removeAt(index);
  //   }
  // }
}
