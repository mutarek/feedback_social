import 'package:als_frontend/util/palette.dart';
import 'package:als_frontend/widgets/network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class CoverPhotoWidget extends StatelessWidget {
  const CoverPhotoWidget(
      {Key? key,
      required this.back,
      required this.viewCoverPhoto,
      required this.coverPhoto,
      this.isTrue = true,
      required this.coverPhotoChange})
      : super(key: key);
  final VoidCallback back;
  final VoidCallback viewCoverPhoto;
  final VoidCallback coverPhotoChange;
  final String coverPhoto;
  final bool isTrue;

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: viewCoverPhoto,
      child: SizedBox(
        height: 200,
        width: width,
        child: Stack(
          children: [
            customNetworkImage2(context,coverPhoto,boxFit: BoxFit.fill),
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
              padding: EdgeInsets.only(top: height * 0.08, left: width * 0.8),
              child: Visibility(
                visible: isTrue,
                child: InkWell(
                  onTap: coverPhotoChange,
                  child: Container(
                    height: height * 0.041,
                    width: width * 0.10,
                    decoration: BoxDecoration(
                        color: const Color(0xffC4C4C4),
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        border: Border.all(color: Colors.white, width: 2)),
                    child: Padding(
                      padding: EdgeInsets.only(top: height * 0.001, left: width * 0.007),
                      child: Icon(
                        FontAwesomeIcons.camera,
                        color: Colors.black,
                        size: height * 0.024,
                      ),
                    ),
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
