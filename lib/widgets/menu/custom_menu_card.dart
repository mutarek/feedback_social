import 'package:flutter/material.dart';

class CustomMenuCard extends StatelessWidget {
  const CustomMenuCard({
    Key? key,
    required this.icon,
    required this.iconColor,
    required this.iconName,
    required this.navigetion,
  }) : super(key: key);
  final VoidCallback navigetion;
  final IconData icon;
  final String iconName;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    final double w = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: navigetion,
      child: Card(
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Row(
            children: [
              Icon(
                icon,
                color: iconColor,
              ),
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
