import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class CustomTextField extends StatelessWidget {
  Text? label;
  String? hintText;
  TextEditingController controller;
  double? height;
  bool obsecureText;
  IconButton? suffixIconButton;
  CustomTextField(
      {Key? key,
      this.height = 50,
      this.hintText,
      this.label,
      required this.controller,
      this.obsecureText = false,
      this.suffixIconButton})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: TextField(
        controller: controller,
        obscureText: obsecureText,
        decoration: InputDecoration(
          hintStyle: GoogleFonts.lato(color: Colors.white),
          hintText: hintText,
          label: label,
          labelStyle: GoogleFonts.lato(color: Colors.white),
          suffixIcon: suffixIconButton,
          filled: true,
        ),
      ),
    );
  }
}
