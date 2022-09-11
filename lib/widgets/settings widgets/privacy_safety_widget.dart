import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class PrivacysafetyWidget extends StatelessWidget {
  const PrivacysafetyWidget(
      {Key? key, required this.width, required this.icon, required this.name})
      : super(key: key);

  final double width;
  final IconData icon;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 14,
        ),
        SizedBox(
          width: width * 0.02,
        ),
        Text(
          name,
          style: GoogleFonts.lato(fontSize: 12, fontWeight: FontWeight.w400),
        )
      ],
    );
  }
}
