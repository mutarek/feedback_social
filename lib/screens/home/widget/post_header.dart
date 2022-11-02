import 'package:als_frontend/data/model/response/news_feed_model.dart';
import 'package:als_frontend/dialog_bottom_sheet/more_menu_bottom_sheet.dart';
import 'package:als_frontend/helper/number_helper.dart';
import 'package:als_frontend/provider/auth_provider.dart';
import 'package:als_frontend/screens/home/widget/profile_avatar.dart';
import 'package:als_frontend/screens/profile/profile_screen.dart';
import 'package:als_frontend/screens/profile/public_profile_screen.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostHeaderWidget extends StatelessWidget {
  final NewsFeedData post;
  final int index;
  final bool isHomeScreen;
  final bool isProfileScreen;
  final int groupPageID;
  final bool isGroup;
  final bool isPage;

  const PostHeaderWidget(
      {Key? key,
      required this.post,
      required this.index,
      this.isHomeScreen = false,
      this.isProfileScreen = false,
      this.isGroup = false,
      this.isPage = false,
      this.groupPageID = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        InkWell(
            onTap: () {
              if (Provider.of<AuthProvider>(context, listen: false).userID == post.author!.id.toString()) {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ProfileScreen()));
              } else {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => PublicProfileScreen(post.author!.id.toString())));
              }
            },
            child: ProfileAvatar(profileImageUrl: post.author!.profileImage!)),
        const SizedBox(width: 8.0),
        Expanded(
          child: InkWell(
            onTap: () {
              if (Provider.of<AuthProvider>(context, listen: false).userID == post.author!.id.toString()) {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ProfileScreen()));
              } else {
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => PublicProfileScreen(post.author!.id.toString())));
              }
            },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(post.author!.fullName!, style: latoStyle500Medium.copyWith(fontWeight: FontWeight.w600)),
                Row(
                  children: [
                    Text(getDate(post.timestamp!, context), style: latoStyle400Regular.copyWith(color: Colors.grey[600], fontSize: 12.0)),
                    Icon(Icons.public, color: Colors.grey[600], size: 12.0)
                  ],
                )
              ],
            ),
          ),
        ),
        Visibility(
          visible: post.author!.id.toString() != Provider.of<AuthProvider>(context, listen: false).userID || !isHomeScreen,
          child: IconButton(
              icon: const Icon(Icons.more_horiz),
              onPressed: () => {
                    moreMenuBottomSheet(context, post, index,
                        isFromProfile: isProfileScreen, isForPage: isPage, isFromGroupScreen: isGroup, groupPageID: groupPageID)
                  }),
        ),
      ],
    );
  }
}
