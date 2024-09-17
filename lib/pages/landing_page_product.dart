import 'package:flutter/material.dart';
import 'package:vendor/pages/all_food_screen.dart';
import 'package:vendor/pages/all_product_screen.dart';

class ProductFoodLandingPage extends StatelessWidget {
  final String shopType;
  const ProductFoodLandingPage({super.key, required this.shopType});

  @override
  Widget build(BuildContext context) => shopType == "Restaurant"
      ? const AllFoodScreen()
      : const AllProductScreen();
}
