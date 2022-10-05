import 'package:flutter/material.dart';

void showCustomSnackBar(String message, BuildContext context, {bool isError = true}) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: isError ? Colors.red : Colors.green,
    duration: const Duration(seconds: 2),
    content: Text(message, style: const TextStyle(color:  Colors.white)),
  ));
}
