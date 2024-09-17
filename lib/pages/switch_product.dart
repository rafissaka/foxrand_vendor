import 'package:flutter/material.dart';

import 'add_food_screen.dart';
import 'add_product_screen.dart';

class SwitchPage extends StatelessWidget {
  final String shopType;
  const SwitchPage({super.key, required this.shopType});

  @override
  Widget build(BuildContext context) => shopType == "Restaurant"
      ? const AddFoodScreen()
      : const AddProductScreen();
}
