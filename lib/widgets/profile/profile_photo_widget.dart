import 'package:als_frontend/const/palette.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfilePhotowidget extends StatelessWidget {
  const ProfilePhotowidget({
    Key? key,
    required this.profilePhotoChange,
    required this.profileImage,
    required this.viewProfilePhoto,
    this.isTrue = true,
  }) : super(key: key);
  final VoidCallback profilePhotoChange;
  final String profileImage;
  final bool isTrue;
  final VoidCallback viewProfilePhoto;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Positioned(
        top: height * 0.14,
        left: width * 0.08,
        child: CircleAvatar(
          radius: height * 0.06,
          backgroundColor: Colors.white,
          child: InkWell(
            onTap: viewProfilePhoto,
            child: CircleAvatar(
              backgroundColor: Palette.scaffold,
              radius: height * 0.057,
              backgroundImage: NetworkImage(profileImage),
              child: Stack(
                children: [
                  Padding(
                    padding:
                        EdgeInsets.only(top: height * 0.06, left: width * 0.2),
                    child: Visibility(
                      visible: isTrue,
                      child: InkWell(
                        onTap: profilePhotoChange,
                        child: Container(
                            height: height * 0.032,
                            width: width,
                            decoration: BoxDecoration(
                                color: Palette.scaffold,
                                border:
                                    Border.all(width: 2, color: Colors.white),
                                borderRadius: BorderRadius.circular(5)),
                            child: Icon(
                              FontAwesomeIcons.camera,
                              color: Colors.black,
                              size: height * 0.024,
                            )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
