import 'package:als_frontend/old_code/const/palette.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class PagePhotowidget extends StatelessWidget {
  const PagePhotowidget(
      {Key? key,
      required this.profilePhotoChange,
      required this.profileImage})
      : super(key: key);
  final VoidCallback profilePhotoChange;
  final String profileImage;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Positioned(
        top: height * 0.14,
        left: width * 0.1,
        child: CircleAvatar(
          radius: height * 0.06,
          backgroundColor: Colors.white,
          child: CircleAvatar(
            backgroundColor: Palette.scaffold,
            radius: height * 0.057,
            backgroundImage: NetworkImage(profileImage),
            child: Padding(
              padding:
                  EdgeInsets.only(right: width * 0.007, top: height * 0.00),
              child: Column(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.only(top: height * 0.06, left: width * 0.09),
                    child: InkWell(
                      onTap: profilePhotoChange,
                      child: Container(
                          height: height * 0.032,
                          width: width * 0.074,
                          decoration: BoxDecoration(
                              color: const Color(0xffC4C4C4),
                              image: DecorationImage(
                                  image: NetworkImage(profileImage),
                                  fit: BoxFit.cover),
                              border: Border.all(width: 2, color: Colors.white),
                              borderRadius: BorderRadius.circular(5)),
                          child: Icon(
                            FontAwesomeIcons.camera,
                            color: Colors.black,
                            size: height * 0.024,
                          )),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
