import 'package:als_frontend/util/palette.dart';
import 'package:als_frontend/widgets/network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfileCoverPhotoWidget extends StatelessWidget {
  const ProfileCoverPhotoWidget(
      {Key? key, required this.back, required this.viewCoverPhoto, required this.coverphoto, required this.coverphotochange})
      : super(key: key);
  final VoidCallback back;
  final VoidCallback viewCoverPhoto;
  final VoidCallback coverphotochange;
  final String coverphoto;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: viewCoverPhoto,
      child: Container(
        height: 200,
        width: width,
        decoration: BoxDecoration(color: Colors.white, image: DecorationImage(image: NetworkImage(coverphoto))),
        child: Stack(
          children: [
            customNetworkImage2(context,coverphoto,boxFit: BoxFit.fill),
            Container(
              margin: const EdgeInsets.only(left: 15),
              padding: EdgeInsets.only(top: height * 0.03, right: width * 0.8),
              child: InkWell(
                onTap: back,
                child: Container(
                  height: height * 0.04,
                  width: width * 0.09,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      boxShadow: [
                        BoxShadow(color: Colors.grey.withOpacity(.1), blurRadius: 10.0, spreadRadius: 3.0, offset: const Offset(0.0, 0.0))
                      ],
                      borderRadius: const BorderRadius.all(Radius.circular(20)),
                      border: Border.all(color: Colors.white, width: 2)),
                  child: Padding(
                    padding: EdgeInsets.only(top: height * 0.001, left: width * 0.001),
                    child: Icon(
                      FontAwesomeIcons.angleLeft,
                      color: Palette.scaffold,
                      size: height * 0.026,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 165, left: width * 0.88),
              child: InkWell(
                onTap: coverphotochange,
                child: Container(
                  height: 30,
                  width: width * 0.10,
                  decoration: BoxDecoration(
                      color: const Color(0xffC4C4C4),
                      borderRadius: const BorderRadius.all(Radius.circular(10)),
                      boxShadow: [
                        BoxShadow(color: Colors.grey.withOpacity(.1), blurRadius: 10.0, spreadRadius: 3.0, offset: const Offset(0.0, 0.0))
                      ],
                      border: Border.all(color: Colors.white, width: 2)),
                  child: Padding(
                    padding: EdgeInsets.only(top: height * 0.001, left: width * 0.007),
                    child: Icon(FontAwesomeIcons.camera, color: Colors.black, size: height * 0.024),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
