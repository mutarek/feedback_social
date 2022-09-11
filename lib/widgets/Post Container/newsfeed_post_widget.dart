import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../const/palette.dart';

class NewsfeedPostWidget extends StatelessWidget {
  const NewsfeedPostWidget(
      {Key? key,
      required this.height,
      required this.width,
      required this.progilePhoto,
      required this.goToProfile,
      required this.goToPostScreen})
      : super(key: key);

  final double height;
  final double width;
  final VoidCallback goToProfile;
  final VoidCallback goToPostScreen;
  final String progilePhoto;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Stack(
          children: [
            InkWell(
              onTap: goToProfile,
              child: Container(
                height: height * 0.05,
                width: width * 0.8,
                decoration: BoxDecoration(
                    color: Palette.scaffold,
                    border: Border.all(width: 1, color: Colors.white),
                    borderRadius: BorderRadius.circular(50)),
                child: Center(
                    child: Text(
                  "What's on your mind",
                  style: GoogleFonts.lato(color: const Color(0xff454E52)),
                )),
              ),
            ),
            InkWell(
              onTap: goToPostScreen,
              child: CircleAvatar(
                backgroundColor: Palette.scaffold,
                radius: 20,
                child: CircleAvatar(
                    backgroundImage: NetworkImage(progilePhoto),
                    radius: 18,
                    backgroundColor: Colors.white38),
              ),
            ),
          ],
        )
      ],
    );
  }
}
