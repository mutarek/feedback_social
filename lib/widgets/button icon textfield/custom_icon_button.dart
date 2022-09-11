import 'package:als_frontend/const/palette.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomIconButton extends StatelessWidget {
  IconData iconName;
  Color iconColor;
  double iconSize;
  VoidCallback onPressed;

  CustomIconButton({
    Key? key,
    required this.iconName,
    this.iconColor = Palette.primary,
    this.iconSize = 30,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        shape: BoxShape.circle  
      ),
      child: IconButton(
        onPressed: onPressed, 
        icon: Icon(
          iconName,
          color: iconColor,
          size: iconSize,
        ),
      ),
    );
  }
}