import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommentWidget extends StatelessWidget {
  const CommentWidget(
      {Key? key,
      required this.width,
      required this.height,
      required this.image,
      required this.name,
      required this.comment,
      required this.onTap})
      : super(key: key);

  final double width;
  final double height;
  final String image;
  final String name;
  final String comment;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width * 0.02, vertical: height * 0.01),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.symmetric(vertical: height * 0.01),
            child: InkWell(
              onTap: onTap,
              child: CircleAvatar(
                backgroundImage: NetworkImage(image),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: width * 0.01, vertical: height * 0.01),
            child: FittedBox(
              child: Container(
                width: width * 0.8,
                decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(8)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.02, vertical: height * 0.01),
                      child: Text(
                        name,
                        style: GoogleFonts.lato(fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: width * 0.02, bottom: height * 0.01),
                      child: Text(
                        comment,
                        style: GoogleFonts.lato(),
                      ),
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
