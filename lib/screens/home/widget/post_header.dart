import 'package:als_frontend/data/model/response/news_feed_model.dart';
import 'package:als_frontend/dialog_bottom_sheet/more_menu_bottom_sheet.dart';
import 'package:als_frontend/helper/number_helper.dart';
import 'package:als_frontend/provider/auth_provider.dart';
import 'package:als_frontend/screens/group/public_group_screen.dart';
import 'package:als_frontend/screens/home/widget/profile_avatar.dart';
import 'package:als_frontend/screens/page/public_page_screen.dart';
import 'package:als_frontend/screens/profile/profile_screen.dart';
import 'package:als_frontend/screens/profile/public_profile_screen.dart';
import 'package:als_frontend/translations/locale_keys.g.dart';
import 'package:als_frontend/util/app_constant.dart';
import 'package:als_frontend/util/helper.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PostHeaderWidget extends StatelessWidget {
  final NewsFeedModel post;
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

  void route(BuildContext context, int code) {
    if (post.postType == AppConstant.postTypeGroup && code == 0) {
      Helper.toScreen(PublicGroupScreen(post.groupModel!.id.toString(), index: index));
    } else if (post.postType == AppConstant.postTypePage && code == 1) {
      Helper.toScreen(  PublicPageScreen(post.pageModel!.id.toString(), index: index));
    } else {
      if (Provider.of<AuthProvider>(context, listen: false).userID == post.author!.id.toString()) {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ProfileScreen()));
      } else {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) => PublicProfileScreen(post.author!.id.toString())));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        (post.postType == AppConstant.postTypePage || post.postType == AppConstant.postTypeGroup) && !isPage && !isGroup
            ? Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      if (post.postType == AppConstant.postTypePage) {
                        route(context, 1);
                      } else {
                        route(context, 0);
                      }
                    },
                    child: ProfileAvatar(
                        profileImageUrl: post.postType == AppConstant.postTypePage ? post.pageModel!.avatar! : post.groupModel!.coverPhoto!),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            if (post.postType == AppConstant.postTypePage) {
                              route(context, 1);
                            } else {
                              route(context, 0);
                            }
                          },
                          child: Row(
                            children: [
                              Text(post.postType == AppConstant.postTypePage ? post.pageModel!.name! : post.groupModel!.name!,
                                  style: latoStyle500Medium.copyWith(fontWeight: FontWeight.w600)),
                              const SizedBox(width: 5),
                              CircleAvatar(
                                  backgroundColor: AppColors.feedback,
                                  radius: 10,
                                  child: CustomText(
                                      title: post.postType == AppConstant.postTypePage ? "P" : "G", color: Colors.white, fontSize: 12))
                            ],
                          ),
                        ),
                        SizedBox(height: post.postType == AppConstant.postTypePage ? 4 : 0),
                        InkWell(
                          onTap: () {
                            route(context, 2);
                          },
                          child: CustomText(
                              title: Provider.of<AuthProvider>(context, listen: false).userID.toString() == post.author!.id.toString()
                                  ? LocaleKeys.you_Posted_Here.tr()
                                  : post.author!.fullName.toString() + LocaleKeys.posted_Here.tr(),
                              fontSize: 12),
                        ),
                        Row(children: [
                          Text(getDate(post.timestamp!, context),
                              style: latoStyle400Regular.copyWith(color: Colors.grey[600], fontSize: 12.0)),
                          Icon(Icons.public, color: Colors.grey[600], size: 12.0)
                        ])
                      ],
                    ),
                  ),
                ],
              )
            : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
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
                          post.postType == AppConstant.postTypePage?Text(post.pageModel!.name!, style: latoStyle500Medium.copyWith(fontWeight: FontWeight.w600)):
                          Text(post.author!.fullName!, style: latoStyle500Medium.copyWith(fontWeight: FontWeight.w600)),
                          Row(
                            children: [
                              Text(getDate(post.timestamp!, context),
                                  style: latoStyle400Regular.copyWith(color: Colors.grey[600], fontSize: 12.0)),
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
              ),
      ],
    );
  }
}
