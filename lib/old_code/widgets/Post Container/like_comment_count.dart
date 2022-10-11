import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../provider/provider.dart';

class LikeCommentCount extends StatelessWidget {
  final int? likeCount;
  final int? commentCount;
  final Color likeCountColor;
  final String likeText;
  final VoidCallback editOnPressed;
  final Icon editText;

  const LikeCommentCount(
      {required this.likeCount,
      required this.commentCount,
      required this.likeCountColor,
      required this.likeText,
      required this.editOnPressed,
      required this.editText,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Container(
      height: height * 0.045,
      width: double.maxFinite,
      decoration: const BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(13))),
      child: Consumer<LikeCommentShareProvider>(builder: (context, provider, child) {
        return Padding(
          padding: EdgeInsets.only(left: width * 0.05, right: width * 0.05),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Icon(FontAwesomeIcons.solidHeart, color: likeCountColor, size: 15),
                  SizedBox(width: width * 0.01),
                  Text(likeCount.toString(), style: GoogleFonts.lato(fontSize: 10)),
                  SizedBox(width: width * 0.02),
                  Text(likeText, style: GoogleFonts.lato(fontSize: 10, fontWeight: FontWeight.bold))
                ],
              ),
              TextButton(onPressed: editOnPressed, child: editText),
              Row(
                children: [
                  Text(commentCount.toString(), style: GoogleFonts.lato(fontSize: 10)),
                  SizedBox(width: width * 0.0008),
                  Text(" comments", style: GoogleFonts.lato(fontSize: 10, fontWeight: FontWeight.bold)),
                ],
              ),
            ],
          ),
        );
      }),
    );
  }
}
