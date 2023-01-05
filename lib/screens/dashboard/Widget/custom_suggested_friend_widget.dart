import 'package:als_frontend/translations/locale_keys.g.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/widgets/network_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CustomSuggestedFriendsWidget extends StatelessWidget {
  final String userName;
  final VoidCallback addFriendButtonTap;
  final VoidCallback gotoProfileScreen;
  final String imgUrl;

  const CustomSuggestedFriendsWidget({
    Key? key,
    required this.userName,
    required this.addFriendButtonTap,
    required this.gotoProfileScreen,
    required this.imgUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Container(
        width: width,
        decoration: BoxDecoration(
            boxShadow: [BoxShadow(color: Colors.grey.withOpacity(.2), blurRadius: 10.0, spreadRadius: 3.0, offset: const Offset(0.0, 0.0))],
            borderRadius: BorderRadius.circular(8),
            color: AppColors.whiteColorLight),
        child: Row(
          children: [
            InkWell(
              onTap: gotoProfileScreen,
              child: Padding(
                padding: const EdgeInsets.all(3),
                child: circularImage(imgUrl, 40, 40),
                // CircleAvatar(
                //     radius: width * 0.07,
                //     backgroundColor: AppColors.scaffold,
                //     backgroundImage: CachedNetworkImageProvider(imgUrl)),
              ),
            ),
            SizedBox(width: 5),
            Expanded(
              flex: 2,
              child: Text(userName, style: const TextStyle(fontSize: 12)),
            ),
            Expanded(
                flex: 2,
                child: InkWell(
                  onTap: addFriendButtonTap,
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(border: Border.all(width: 1, color: Colors.blueGrey), borderRadius: BorderRadius.circular(5)),
                    child: Center(
                      child: Text(
                        LocaleKeys.add_friend.tr(),
                        style: const TextStyle(color: Colors.blue, fontSize: 15, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                )),
            SizedBox(width: width * 0.02),
          ],
        ),
      ),
    );
  }
}
