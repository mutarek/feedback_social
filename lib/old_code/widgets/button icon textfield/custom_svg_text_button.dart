import 'package:als_frontend/old_code/const/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

// ignore: must_be_immutable
class CustomSvgTextButton extends StatelessWidget {

  String imageLink;
  Color color;
  double height;
  double width;
  final VoidCallback onPressed;

   CustomSvgTextButton({
     
    Key? key,
    required this.imageLink,
    this.color = Palette.primary,
    this.height = 30,
    this.width = 30,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed, 
      child: SvgPicture.asset(
        imageLink,
        color: Palette.primary,
        height: height,
        width: width,
      )
    );
  }
}