import 'package:als_frontend/util/palette.dart';
import 'package:als_frontend/widgets/network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FriendListCard extends StatelessWidget {
  const FriendListCard({
    Key? key,
    required this.width,
    required this.height,
    required this.name,
    required this.image,
    required this.onPressed,
    required this.verb,
  }) : super(key: key);

  final double width;
  final double height;
  final String name;
  final String image;
  final VoidCallback onPressed;
  final String verb;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height * 0.1,
      width: width * 0.9,
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(13)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(left: width * 0.015),
                child: CircleAvatar(
                  backgroundColor: Palette.scaffold,
                  radius: 28,
                  child:  circularImage(image,40,40),
                  // CircleAvatar(radius: 26, backgroundImage: NetworkImage(image)),
                ),
              ),
              Padding(
                  padding: EdgeInsets.only(left: width * 0.05),
                  child: Text(name, style: GoogleFonts.lato(fontSize: 17, fontWeight: FontWeight.bold)))
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ElevatedButton(onPressed: onPressed, child: Text(verb, style: GoogleFonts.lato())),
          )
        ],
      ),
    );
  }
}
