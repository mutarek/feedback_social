import 'package:flutter/material.dart';

import 'package:google_fonts/google_fonts.dart';

class SettingsWidget extends StatelessWidget {
  SettingsWidget({
    Key? key,
    required this.width,
    required this.height,
    required this.iconName,
    required this.boxName,
    required this.boxDetails,
  }) : super(key: key);

  final double width;
  final double height;
  IconData iconName;
  String boxName;
  String boxDetails;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          iconName,
          size: 15,
          color: Colors.black,
        ),
        SizedBox(
          width: width * 0.03,
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(boxName,
                style: GoogleFonts.lato(
                    fontSize: 16, fontWeight: FontWeight.bold)),
            SizedBox(
              width: width * 0.6,
              height: height,
              child: Text(
                boxDetails,
                style: GoogleFonts.lato(
                    fontSize: 13, color: const Color(0xff454E52)),
              ),
            )
          ],
        ),
      ],
    );
  }
}
