import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomMenuCard extends StatelessWidget {
  const CustomMenuCard({
    Key? key,
    required this.h,
    required this.w,
    required this.svgName,
    required this.iconColor,
    required this.iconName,
    required this.navigetion,
  }) : super(key: key);
  final double h;
  final double w;
  final VoidCallback navigetion;
  final String svgName;
  final String iconName;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: navigetion,
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            children: [
              SizedBox(
                  width: w * 0.06,
                  height: h * 0.03,
                  child: SvgPicture.asset(
                    svgName,
                    fit: BoxFit.cover,
                  )),
              SizedBox(
                width: w * 0.023,
              ),
              Text(iconName),
              SizedBox(
                width: w * 0.023,
              )
            ],
          ),
        ),
      ),
    );
  }
}
