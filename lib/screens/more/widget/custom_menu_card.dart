import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomMenuCard extends StatelessWidget {
  const CustomMenuCard({
    Key? key,
    required this.h,
    required this.svgName,
    required this.iconColor,
    required this.iconName,
    required this.navigetion,
  }) : super(key: key);
  final double h;
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 20, width: 20, child: SvgPicture.asset(svgName, fit: BoxFit.cover)),
              Expanded(child: Center(child: Text(iconName,style: latoStyle500Medium))),
            ],
          ),
        ),
      ),
    );
  }
}
