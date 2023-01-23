import 'package:als_frontend/util/helper.dart';
import 'package:als_frontend/util/palette.dart';
import 'package:flutter/material.dart';

void showMessage({required String message, bool isError = true}) {
  ScaffoldMessenger.of(Helper.navigatorKey.currentState!.context).showSnackBar(
    SnackBar(content: Text(message, style: const TextStyle(color: Colors.white)), backgroundColor: isError ? Colors.red : Palette.primary),
  );
}
