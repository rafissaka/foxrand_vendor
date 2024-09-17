import 'package:flutter/material.dart';

import 'package:flutter_hooks/flutter_hooks.dart';

class CustomSnackBar extends HookWidget {
  final String message;

  const CustomSnackBar({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.red, // Success color
        borderRadius: BorderRadius.circular(8.0), // Border radius
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          message,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
