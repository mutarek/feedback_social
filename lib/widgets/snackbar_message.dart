import 'package:als_frontend/util/palette.dart';
import 'package:flutter/material.dart';

void showMessage({String? message, BuildContext? context, bool isError = true}) {
  ScaffoldMessenger.of(context!).showSnackBar(
    SnackBar(content: Text(message!, style: const TextStyle(color: Colors.white)), backgroundColor: isError ? Colors.red : Palette.primary),
  );
}
