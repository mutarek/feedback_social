import 'package:als_frontend/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomMenuCard extends StatelessWidget {
  const CustomMenuCard(
      {Key? key, required this.h, required this.svgName, required this.iconColor, required this.iconName, required this.navigation})
      : super(key: key);
  final double h;
  final VoidCallback navigation;
  final String svgName;
  final String iconName;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: navigation,
      child: Card(
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 25, width: 25, child: SvgPicture.asset(svgName, fit: BoxFit.cover)),
              Expanded(child: Center(child: FittedBox(child: CustomText(title: iconName, color: Colors.black, fontSize: 12)))),
            ],
          ),
        ),
      ),
    );
  }
}
