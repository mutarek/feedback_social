import 'package:als_frontend/old_code/const/palette.dart';
import 'package:flutter/material.dart';

void showMessage({String? message, BuildContext? context}){
  ScaffoldMessenger.of(context!).showSnackBar(SnackBar(
    content: Text(
      message!,
      style: const TextStyle(
        color: Colors.white,
      ),
    ),
    backgroundColor: Palette.primary
  ),);
}