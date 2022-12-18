import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  const CustomText(
      {this.title,
      this.color = Colors.black,
      this.fontSize = 14,
      this.fontWeight,
      this.fontStyle,
      this.textAlign,
      this.decoration,
      this.maxLines = 1,
      this.height,
      this.overflow,
      this.textStyle,
      Key? key})
      : super(key: key);
  final String? title;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final FontStyle? fontStyle;
  final TextAlign? textAlign;
  final TextDecoration? decoration;
  final int? maxLines;
  final double? height;
  final TextOverflow? overflow;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Text(
      title ?? "",
      textAlign: textAlign ?? TextAlign.left,
      maxLines: maxLines,
      overflow: overflow,
      style: textStyle ??
          latoStyle400Regular.copyWith(
              fontSize: fontSize, color: color, fontWeight: fontWeight, decoration: decoration, fontStyle: fontStyle, height: height),
    );
  }
}
