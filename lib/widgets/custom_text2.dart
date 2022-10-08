import 'package:als_frontend/localization/language_constrants.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:flutter/material.dart';

class CustomText2 extends StatelessWidget {
  CustomText2(
      {this.title,
      this.color = Colors.white,
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
  String? title;
  Color? color;
  double? fontSize;
  FontWeight? fontWeight;
  FontStyle? fontStyle;
  TextAlign? textAlign;
  TextDecoration? decoration;
  int? maxLines;
  double? height;
  TextOverflow? overflow;
  TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return Text(
      getTranslated(title!, context) ?? "",
      textAlign: textAlign ?? TextAlign.left,
      maxLines: maxLines,
      overflow: overflow,
      style: textStyle ??
          latoStyle400Regular.copyWith(
            fontSize: fontSize,
            color: color,
            fontWeight: fontWeight,
            decoration: decoration,
            fontStyle: fontStyle,
            height: height,
          ),
    );
  }
}
