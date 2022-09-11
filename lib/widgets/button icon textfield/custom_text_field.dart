import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {


  Text label;
  TextEditingController controller;
  double height;
  bool obsecureText;
  IconButton? suffixIconButton;
  CustomTextField({
    Key? key,
    this.height = 50,
    required this.label,
    required this.controller,
    this.obsecureText = false,
    this.suffixIconButton
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: TextField(
        controller: controller,
        obscureText: obsecureText,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
            ),
          fillColor: const Color(0xFF656B87),
          label: label,
          labelStyle: const TextStyle(
            color:  Colors.white
          ),
          suffixIcon: suffixIconButton,
          filled: true,
        ),
      ),
    );
  }
}