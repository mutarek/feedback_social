import 'package:als_frontend/data/model/response/news_feed_model.dart';
import 'package:als_frontend/dialog_bottom_sheet/share_modal_bottom_sheet.dart';
import 'package:als_frontend/provider/auth_provider.dart';
import 'package:als_frontend/provider/newsfeed_provider.dart';
import 'package:als_frontend/screens/notification/single_post_screen.dart';
import 'package:als_frontend/util/app_constant.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

class PostStats extends StatelessWidget {
  final NewsFeedData post;
  final int index;
  final int groupPageID;
  final int postID;
  bool isGroup = false;
  final feedProvider;
  final double paddingHorizontal;
  final double paddingVertical;
  final bool isHomeScreen;
  final bool isFromProfile;
  bool isPage = false;

  PostStats(
      {Key? key,
      required this.post,
      required this.index,
      this.feedProvider,
      this.groupPageID = 0,
      this.paddingHorizontal = 12,
      this.isFromProfile = false,
      this.isHomeScreen = false,
      this.postID = 0,
      this.paddingVertical = 0})
      : super(key: key) {
    isGroup = post.postType == AppConstant.postTypeGroup ? true : false;
    isPage = post.postType == AppConstant.postTypePage ? true : false;
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NewsFeedProvider>(
      builder: (context, state, child) {
        return Container(
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
              color: AppColors.scaffold,
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
              boxShadow: [
                BoxShadow(color: Colors.grey.withOpacity(.2), blurRadius: 10.0, spreadRadius: 3.0, offset: const Offset(0.0, 0.0))
              ]),
          child: Padding(
            padding: const EdgeInsets.only(left: 15, right: 15),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                InkWell(
                  onTap: () {
                    if (isHomeScreen) {
                      if (isGroup || isPage) {
                        feedProvider.addLike(post.id!.toInt(), index, isGroup: isGroup, isFromPage: isPage, groupPageID: groupPageID);
                      } else {
                        feedProvider.addLike(post.id!.toInt(), index);
                      }
                    } else {
                      if (isGroup || isPage) {
                        feedProvider.addLike(groupPageID, post.id!.toInt(), index);
                      } else {
                        feedProvider.addLike(post.id!.toInt(), index);
                      }
                    }
                  },
                  child: SizedBox(
                    width: 40,
                    height: 40,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Icon((feedProvider.likesStatusAllData[index] == 1) ? Icons.favorite : Icons.favorite_border,
                            size: 30, color: (feedProvider.likesStatusAllData[index] == 1) ? Colors.red : Colors.black),
                        Positioned(
                            top: -13,
                            left: 20,
                            child: post.totalLike == 0
                                ? const SizedBox.shrink()
                                : Container(
                                    padding: const EdgeInsets.all(7),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.feedback,
                                        border: Border.all(color: Colors.white),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey.withOpacity(.2),
                                              blurRadius: 10.0,
                                              spreadRadius: 3.0,
                                              offset: const Offset(0.0, 0.0))
                                        ]),
                                    child: CustomText(title: post.totalLike.toString(), fontSize: 10, color: Colors.white),
                                  ))
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 30.0),
                InkWell(
                  onTap: () {
                    Provider.of<AuthProvider>(context, listen: false).getUserInfo();
                    Get.to(SinglePostScreen(post.commentUrl!,
                        isHomeScreen: isHomeScreen,
                        isProfileScreen: isFromProfile,
                        index: index,
                        postID: postID,
                        groupID: groupPageID,
                        isFromPage: isPage,
                        isFromGroup: isGroup));
                  },
                  child: SizedBox(
                    width: 40,
                    height: 40,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        const Icon(CupertinoIcons.chat_bubble, size: 30, color: Colors.black),
                        Positioned(
                            top: -13,
                            left: 20,
                            child: post.totalComment == 0
                                ? const SizedBox.shrink()
                                : Container(
                                    padding: const EdgeInsets.all(7),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: AppColors.feedback,
                                        border: Border.all(color: Colors.white),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.grey.withOpacity(.2),
                                              blurRadius: 10.0,
                                              spreadRadius: 3.0,
                                              offset: const Offset(0.0, 0.0))
                                        ]),
                                    child: CustomText(title: post.totalComment.toString(), fontSize: 10, color: Colors.white),
                                  ))
                      ],
                    ),
                  ),
                ),
                const SizedBox(width: 1.0),
                InkWell(
                  onTap: () {
                    shareBottomSheet(context, post.isShare! ? post.sharePost!.postUrl! : post.commentUrl!, post);
                  },
                  child: SizedBox(
                    width: 35,
                    height: 35,
                    child: SvgPicture.asset("assets/svg/share.svg", height: 30, color: Colors.black),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}