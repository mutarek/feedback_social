import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LikeInviteFindWidget extends StatelessWidget {
  const LikeInviteFindWidget({Key? key, this.icon, this.name, this.extraArguments, this.onTap}) : super(key: key);
  final String? icon;
  final String? name;
  final String? extraArguments;
  final Function? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (onTap != null) {
          onTap!();
        }
      },
      child: Row(
        children: [
          CircleAvatar(backgroundColor: const Color(0xffE4E6EB), radius: 23, child: SvgPicture.asset(icon!, color: colorText)),
          const SizedBox(width: 15),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(name!, style: robotoStyle500Medium.copyWith(fontSize: 18)),
              extraArguments == null ? const SizedBox.shrink() : Text(extraArguments!, style: robotoStyle500Medium.copyWith(fontSize: 13))
            ],
          )
        ],
      ),
    );
  }
}
