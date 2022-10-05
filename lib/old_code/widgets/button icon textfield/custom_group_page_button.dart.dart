import 'package:als_frontend/old_code/const/palette.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomPageGroupButton extends StatelessWidget {
  const CustomPageGroupButton({
    Key? key,
    required this.goToGroupOrPage,
    required this.groupOrPageImage,
    required this.groupOrPageName,
    required this.groupOrPageLikes,
    required this.onTap,
  }) : super(key: key);
  final VoidCallback goToGroupOrPage;
  final String groupOrPageImage;
  final String groupOrPageName;
  final String groupOrPageLikes;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: goToGroupOrPage,
      child: Padding(
        padding: const EdgeInsets.all(1.0),
        child: Container(
          height: height * 0.09,
          width: width * 0.96,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          child: InkWell(
            onTap: onTap,
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: width * 0.03),
                  child: CircleAvatar(
                    radius: height * 0.04,
                    backgroundImage: NetworkImage(groupOrPageImage),
                    backgroundColor: Palette.scaffold,
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.only(top: height * 0.01, left: width * 0.015),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(groupOrPageName,
                          style: GoogleFonts.lato(
                              fontSize: height * 0.023,
                              fontWeight: FontWeight.w600)),
                      Text(
                        groupOrPageLikes.toString(),
                        style: GoogleFonts.lato(
                            fontSize: height * 0.02, color: Palette.timeColor),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
