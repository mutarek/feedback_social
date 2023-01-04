import 'package:als_frontend/data/model/response/news_feed_model.dart';
import 'package:als_frontend/dialog_bottom_sheet/share_modal_bottom_sheet.dart';
import 'package:als_frontend/provider/auth_provider.dart';
import 'package:als_frontend/provider/newsfeed_provider.dart';
import 'package:als_frontend/screens/home/view/like_view.dart';
import 'package:als_frontend/screens/post/single_post_screen.dart';
import 'package:als_frontend/util/app_constant.dart';
import 'package:als_frontend/util/helper.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:like_button/like_button.dart';
import 'package:provider/provider.dart';

class PostStats extends StatelessWidget {
  final NewsFeedModel post;
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
              color: Colors.white,
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(10), bottomRight: Radius.circular(10)),
              // boxShadow: [
              //   BoxShadow(color: Colors.grey.withOpacity(.2), blurRadius: 10.0, spreadRadius: 3.0, offset: const Offset(0.0, 0.0))
              // ]
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 40,
                      height: 40,
                      child: Stack(
                        clipBehavior: Clip.none,
                        children: [
                          LikeButton(
                            size: 30,
                            isLiked:  post.isLiked,
                            bubblesSize: 50,
                            // circleColor:
                            // CircleColor(start: Color(0xff00ddff), end: Color(0xff0099cc)),
                            // bubblesColor: BubblesColor(
                            //   dotPrimaryColor: Color(0xff33b5e5),
                            //   dotSecondaryColor: Color(0xff0099cc),
                            // ),
                            onTap: (bool isLiked) async{
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

                          return !isLiked;
                          },
                            likeBuilder: (bool isLiked) {
                              return Icon(
                               Icons.favorite ,
                                color: isLiked ? Colors.red : Colors.grey,
                                size:30,
                              );
                            },

                          ),

                          //ToDo : like buttun

                          // Icon((post.isLiked == true) ? Icons.favorite : Icons.favorite_border,
                          //     size: 30, color: (post.isLiked == true) ? Colors.red : Colors.black),
                          // Positioned(
                          //     top: -13,
                          //     left: 20,
                          //     child: post.totalLike == 0
                          //         ? const SizedBox.shrink()
                          //         : Container(
                          //             padding: const EdgeInsets.all(7),
                          //             decoration: BoxDecoration(
                          //                 shape: BoxShape.circle,
                          //                 color: AppColors.feedback,
                          //                 border: Border.all(color: Colors.white),
                          //                 boxShadow: [
                          //                   BoxShadow(
                          //                       color: Colors.grey.withOpacity(.2),
                          //                       blurRadius: 10.0,
                          //                       spreadRadius: 3.0,
                          //                       offset: const Offset(0.0, 0.0))
                          //                 ]),
                          //             child: CustomText(title: post.totalLike.toString(), fontSize: 10, color: Colors.white),
                          //           ))
                        ],
                      ),
                    ),
                    const SizedBox(width: 30.0),
                    InkWell(
                      onTap: () {
                        Provider.of<AuthProvider>(context, listen: false).getUserInfo();
                        Helper.toScreen(
                            SinglePostScreen(post.commentUrl!,
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
                          children: const [
                            Icon(CupertinoIcons.chat_bubble, size: 30, color: Colors.black),
                            // Positioned(
                            //     top: -13,
                            //     left: 20,
                            //     child: post.totalComment == 0
                            //         ? const SizedBox.shrink()
                            //         : Container(
                            //             padding: const EdgeInsets.all(7),
                            //             decoration: BoxDecoration(
                            //                 shape: BoxShape.circle,
                            //                 color: AppColors.feedback,
                            //                 border: Border.all(color: Colors.white),
                            //                 boxShadow: [
                            //                   BoxShadow(
                            //                       color: Colors.grey.withOpacity(.2),
                            //                       blurRadius: 10.0,
                            //                       spreadRadius: 3.0,
                            //                       offset: const Offset(0.0, 0.0))
                            //                 ]),
                            //             child: CustomText(title: post.totalComment.toString(), fontSize: 10, color: Colors.white),
                            //           ))
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
                    ),
                  ],
                ),
              ),
              post.totalLiked == 0 && post.totalShared == 0 && post.totalComment == 0
                  ? const SizedBox.shrink()
                  : Container(
                      color: Colors.grey.withOpacity(.3),
                      height: 1,
                      margin: const EdgeInsets.only(top: 5, bottom: 10),
                    ),
              post.totalLiked == 0 && post.totalShared == 0 && post.totalComment == 0
                  ? const SizedBox.shrink()
                  : Padding(
                      padding: const EdgeInsets.only(left: 10, right: 15, bottom: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              if (post.totalLiked != 0) likeModalBottomView(context, post, true);
                            },
                            child: post.totalLiked == 0
                                ? const SizedBox.shrink()
                                : Row(
                                    children: [
                                      Stack(
                                        clipBehavior: Clip.none,
                                        children: const [
                                          SizedBox(width: 45),
                                          Icon(FontAwesomeIcons.solidHeart, size: 20, color: kPrimaryColor),
                                          Positioned(
                                              left: 21, top: -2, child: Icon(FontAwesomeIcons.thumbsUp, size: 20, color: kPrimaryColor)),
                                        ],
                                      ),
                                      CustomText(
                                          title: ' ${post.totalLiked.toString()} ${post.totalLiked == 1 ? "Like" : "Likes"}',
                                          fontSize: 14,
                                          color: kPrimaryColor.withOpacity(.8)),
                                    ],
                                  ),
                          ),
                          Row(
                            children: [
                              InkWell(
                                onTap: () {
                                  Provider.of<AuthProvider>(context, listen: false).getUserInfo();
                                  Helper.toScreen(
                                      SinglePostScreen(post.commentUrl!,
                                          isHomeScreen: isHomeScreen,
                                          isProfileScreen: isFromProfile,
                                          index: index,
                                          postID: postID,
                                          groupID: groupPageID,
                                          isFromPage: isPage,
                                          isFromGroup: isGroup));
                                },
                                child: CustomText(
                                    title: post.totalComment == 0
                                        ? ""
                                        : '${post.totalComment.toString()} ${post.totalComment == 1 ? "comment" : "comments"}',
                                    fontSize: 14,
                                    color: kPrimaryColor.withOpacity(.8)),
                              ),
                              InkWell(
                                onTap: () {
                                  if (post.totalShared != 0) likeModalBottomView(context, post, false);
                                },
                                child: CustomText(
                                    title: post.totalShared == 0
                                        ? ""
                                        : '  ${post.totalShared.toString()} ${post.totalShared == 1 ? "share" : "shares"}',
                                    fontSize: 14,
                                    color: kPrimaryColor.withOpacity(.8)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        );
      },
    );
  }
}