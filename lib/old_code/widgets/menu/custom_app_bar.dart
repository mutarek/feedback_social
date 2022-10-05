import 'package:als_frontend/old_code/const/palette.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Container(
      height: height * 0.07,
      width: width,
      decoration: const BoxDecoration(
        color: Palette.scaffold,
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.only(left: width * 0.04),
            child: Text("ALS",
                style: GoogleFonts.lato(
                    color: Palette.primary,
                    fontSize: height * 0.04,
                    fontWeight: FontWeight.bold)),
          ),
          SizedBox(
            width: width * 0.5,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
                radius: height * 0.024,
                backgroundColor: const Color(0xffD9D9D9),
                child: const Icon(FontAwesomeIcons.magnifyingGlass)),
          ),
          CircleAvatar(
              radius: height * 0.024,
              backgroundColor: const Color(0xffD9D9D9),
              child: const Icon(FontAwesomeIcons.facebookMessenger))
        ],
      ),
    );
  }
}
