import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomIcon extends StatelessWidget {
  IconData iconName;
  Color iconColor;
  double iconSize;

  CustomIcon({
    Key? key,
    required this.iconName,
    this.iconColor = Colors.black,
    this.iconSize = 26
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Icon(
      iconName,
      color: iconColor,
      size: iconSize,
      );
  }
}