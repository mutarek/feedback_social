import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class CustomTextField1 extends StatelessWidget {
  Text? label;
  String? hintText;
  TextEditingController controller;
  double? height;
  bool obsecureText;
  IconButton? suffixIconButton;
  TextInputType keybordType;
  Color fontColor;
  Color hintTextColor;
  Color labelColor;
  CustomTextField1(
      {Key? key,
      this.height = 50,
      this.hintText,
      this.label,
      required this.controller,
      this.obsecureText = false,
      this.suffixIconButton,
      this.fontColor = Colors.white,
      this.hintTextColor = Colors.white,
      this.labelColor= Colors.white,
      this.keybordType = TextInputType.emailAddress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: TextField(
        style: TextStyle(color: fontColor),
        controller: controller,
        obscureText: obsecureText,
        keyboardType: keybordType,
        decoration: InputDecoration(
          hintStyle: GoogleFonts.lato(color: hintTextColor),
          hintText: hintText,
          fillColor: Colors.white,
          label: label,
          labelStyle: GoogleFonts.lato(color: labelColor),
          suffixIcon: suffixIconButton,
          filled: true,
        ),
      ),
    );
  }
}
