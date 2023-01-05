import 'package:als_frontend/util/palette.dart';
import 'package:als_frontend/screens/profile/widget/update_cover_photo.dart';
import 'package:als_frontend/widgets/network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfilePhotoWidget extends StatelessWidget {
  const ProfilePhotoWidget(
      {Key? key,  required this.profileImage, required this.viewProfilePhoto, this.isTrue = true})
      : super(key: key);
  final String profileImage;
  final bool isTrue;
  final VoidCallback viewProfilePhoto;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(

      radius: 43,
      backgroundColor: Palette.scaffold,
      child: InkWell(
        onTap: viewProfilePhoto,
        child: Stack(
          children: [
            circularImage(profileImage,80,80),

            // CircleAvatar(backgroundColor: Palette.scaffold, radius: 41, backgroundImage: NetworkImage(profileImage)),
            isTrue
                ? Positioned(
                    bottom: 0,
                    right: 0,
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(MaterialPageRoute(builder: (_) => const UpdateCoverPhoto(isCoverPhotoUpload: false)));
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              color: Colors.white, border: Border.all(width: 2, color: Colors.white), borderRadius: BorderRadius.circular(5)),
                          child: const Icon(FontAwesomeIcons.camera, color: Colors.black, size: 17)),
                    ),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
