import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/widgets/network_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ProfileAvatar extends StatelessWidget {
  final String profileImageUrl;
  final bool isActive;
  final bool hasBorder;
  final double scale;
  final double isActivescale;

  const ProfileAvatar({
    Key? key,
    required this.profileImageUrl,
    this.isActive = false,
    this.hasBorder = false,
    this.scale = 1.0,
    this.isActivescale = 1.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomRight,
      children: [
        circularImage(profileImageUrl, 33, 33),
        // CircleAvatar(
        //   backgroundColor: colorPrimaryDark,
        //   radius: 20.0 * scale,
        //   child: CircleAvatar(
        //     radius: hasBorder ? 17.0 * scale : 20.0 * scale,
        //     backgroundColor: Colors.grey[200],
        //     backgroundImage: CachedNetworkImageProvider(profileImageUrl),
        //   ),
        // ),
        if (isActive)
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 6.0 * isActivescale,
            child: CircleAvatar(
              backgroundColor: online,
              radius: 5.0 * isActivescale,
            ),
          )
      ],
    );
  }
}
