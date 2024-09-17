import 'package:flutter/material.dart';

void showErrorSnackbar(BuildContext context, String msg) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      duration: const Duration(seconds: 1),
      content: Row(
        children: [
          const Icon(
            Icons.error,
            color: Colors.red,
          ),
          Flexible(
            child: Text(msg),
          )
        ],
      )));
}
