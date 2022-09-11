import 'package:als_frontend/const/palette.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomElevatedButton extends StatelessWidget {

  final String text;
  final Color buttonColor;
  final Color textColor;
  VoidCallback onPressed;
  CustomElevatedButton({
    Key? key,
    required this.text,
    this.buttonColor = Palette.primary,
    this.textColor = Colors.white,
    required this.onPressed
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed, 
      child: Text(
        text,
        style: TextStyle(
          color: textColor
        ),
      ),
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        primary: buttonColor,
      ),
    );
  }
}