import 'package:als_frontend/data/model/response/news_feed_model.dart';
import 'package:als_frontend/dialog_bottom_sheet/add_dialogue.dart';
import 'package:als_frontend/dialog_bottom_sheet/delete_dialogue.dart';
import 'package:als_frontend/dialog_bottom_sheet/like_modal_bottom_sheet.dart';
import 'package:als_frontend/dialog_bottom_sheet/share_modal_bottom_sheet.dart';
import 'package:als_frontend/helper/number_helper.dart';
import 'package:als_frontend/helper/open_call_url_map_sms_helper.dart';
import 'package:als_frontend/helper/url_checkig_helper.dart';
import 'package:als_frontend/provider/auth_provider.dart';
import 'package:als_frontend/provider/comment_provider.dart';
import 'package:als_frontend/provider/page_provider.dart';
import 'package:als_frontend/provider/post_provider.dart';
import 'package:als_frontend/screens/group/public_group_screen.dart';
import 'package:als_frontend/screens/page/page_details_screen.dart';
import 'package:als_frontend/screens/page/widget/popup_menu_widget.dart';
import 'package:als_frontend/screens/post/single_post_screen1.dart';
import 'package:als_frontend/screens/post/widget/photo_widget1.dart';
import 'package:als_frontend/screens/posts/add_post_screen.dart';
import 'package:als_frontend/screens/profile/profile_screen.dart';
import 'package:als_frontend/screens/profile/public_profile_screen.dart';
import 'package:als_frontend/util/app_constant.dart';
import 'package:als_frontend/util/helper.dart';
import 'package:als_frontend/util/image.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/any_link_preview_global_widget.dart';
import 'package:als_frontend/widgets/network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feed_reaction/flutter_feed_reaction.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../provider/newsfeed_provider.dart';

class PostWidget extends StatelessWidget {
  final NewsFeedModel newsFeedData;
  final int index;
  final bool isHomeScreen;
  final bool isProfileScreen;
  final int groupPageID;
  final bool isGroup;
  final bool isPage;
  final bool isHideCommentButton;
  final bool isAdmin;

  const PostWidget(this.newsFeedData,
      {required this.index,
      this.isHomeScreen = false,
      this.isProfileScreen = false,
      this.isHideCommentButton = false,
      this.isGroup = false,
      this.isPage = false,
      this.isAdmin = false,
      this.groupPageID = 0,
      Key? key})
      : super(key: key);

  void route(BuildContext context, int code) {
    if (newsFeedData.postType == AppConstant.postTypeGroup && code == 0) {
      Helper.toScreen(PublicGroupScreen(newsFeedData.groupModel!.id.toString(), index: index));
    } else if (newsFeedData.postType == AppConstant.postTypePage && code == 1) {
      Helper.toScreen(PageDetailsScreen(newsFeedData.pageModel!.id.toString(), index: index));
    } else {
      if (Provider.of<AuthProvider>(context, listen: false).userID == newsFeedData.author!.id.toString()) {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ProfileScreen()));
      } else {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) => PublicProfileScreen(newsFeedData.author!.id.toString())));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer3<CommentProvider, NewsFeedProvider, PostProvider>(
        builder: (context, commentProvider, newsFeedProvider, postProvider, child) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      (newsFeedData.postType == AppConstant.postTypePage || newsFeedData.postType == AppConstant.postTypeGroup) &&
                              !isPage &&
                              !isGroup
                          ? InkWell(
                              onTap: () {
                                if (newsFeedData.postType == AppConstant.postTypePage) {
                                  route(context, 1);
                                } else {
                                  route(context, 0);
                                }
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    height: 36,
                                    width: 36,
                                    padding: const EdgeInsets.all(2),
                                    decoration:
                                        BoxDecoration(border: Border.all(color: AppColors.primaryColorLight), shape: BoxShape.circle),
                                    child: circularImage(
                                        newsFeedData.postType == AppConstant.postTypePage
                                            ? newsFeedData.pageModel!.avatar!
                                            : newsFeedData.groupModel!.coverPhoto!,
                                        36,
                                        36),
                                  ),
                                  const SizedBox(width: 8),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                          newsFeedData.postType == AppConstant.postTypePage
                                              ? newsFeedData.pageModel!.name!
                                              : newsFeedData.groupModel!.name!,
                                          style: robotoStyle700Bold),
                                      Row(
                                        children: [
                                          SvgPicture.asset(ImagesModel.timeIcons, width: 12, height: 13),
                                          const SizedBox(width: 2),
                                          Text("${getDate(newsFeedData.timestamp!, context)}  -",
                                              style: robotoStyle500Medium.copyWith(fontSize: 10)),
                                          const SizedBox(width: 3),
                                          SvgPicture.asset(ImagesModel.globalIcons, width: 12, height: 12),
                                        ],
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            )
                          : Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  height: 36,
                                  width: 36,
                                  padding: const EdgeInsets.all(2),
                                  decoration: BoxDecoration(border: Border.all(color: AppColors.primaryColorLight), shape: BoxShape.circle),
                                  child: circularImage(
                                      isPage
                                          ? newsFeedData.pageModel!.avatar!
                                          : isGroup
                                              ? newsFeedData.groupModel!.coverPhoto!
                                              : newsFeedData.author!.profileImage!,
                                      36,
                                      36),
                                ),
                                const SizedBox(width: 8),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                        isPage
                                            ? newsFeedData.pageModel!.name!
                                            : isGroup
                                                ? newsFeedData.groupModel!.name!
                                                : newsFeedData.author!.fullName!,
                                        style: robotoStyle700Bold),
                                    Row(
                                      children: [
                                        SvgPicture.asset(ImagesModel.timeIcons, width: 12, height: 13),
                                        const SizedBox(width: 2),
                                        Text("${getDate(newsFeedData.timestamp!, context)}  -",
                                            style: robotoStyle500Medium.copyWith(fontSize: 10)),
                                        const SizedBox(width: 3),
                                        SvgPicture.asset(ImagesModel.globalIcons, width: 12, height: 12),
                                      ],
                                    )
                                  ],
                                ),
                              ],
                            ),
                      const Spacer(),
                      PopupMenuButton(
                        itemBuilder: (context) => [
                          // PopupMenuItem 1
                          PopupMenuItem(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                isAdmin
                                    ? PopUpMenuWidget(ImagesModel.reportIcons, 'Edit', () {
                                        Navigator.of(context).pop();
                                        Provider.of<PostProvider>(context, listen: false).clearImageVideo();
                                        Provider.of<PostProvider>(context, listen: false).initializeImageVideo(newsFeedData);
                                        Navigator.of(context).push(MaterialPageRoute(
                                            builder: (_) => AddPostScreen(Provider.of<AuthProvider>(context, listen: false).profileImage,
                                                isFromGroupScreen: isGroup,
                                                isForPage: isPage,
                                                isEditPost: true,
                                                post: newsFeedData,
                                                isFromProfileScreen: isProfileScreen,
                                                index: index)));
                                      })
                                    : PopUpMenuWidget(ImagesModel.saveIcons, 'Save', () {}),
                                const SizedBox(height: 15),
                                isAdmin
                                    ? PopUpMenuWidget(ImagesModel.hideIcons, 'Delete', () {
                                        Navigator.of(context).pop();
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return DeleteDialogue(newsFeedData, index, isHomeScreen);
                                            });
                                      })
                                    : PopUpMenuWidget(ImagesModel.hideIcons, 'Hide this post', () {
                                        postProvider
                                            .hidePagePostFromDatabase(
                                                newsFeedData.id.toString(),
                                                AppConstant.postTypePage == newsFeedData.postType ? true : false,
                                                AppConstant.postTypeGroup == newsFeedData.postType ? true : false)
                                            .then((value) {
                                          if (isHomeScreen == true) {
                                            newsFeedProvider.hideNewsFeedData(index);
                                          }
                                        });
                                        Helper.back();
                                      }),
                                SizedBox(height: isAdmin ? 8 : 15),
                                isAdmin ? const SizedBox.shrink() : PopUpMenuWidget(ImagesModel.copyIcons, 'Copy Link', () {}),
                                SizedBox(height: isAdmin ? 0 : 15),
                                isAdmin
                                    ? const SizedBox.shrink()
                                    : PopUpMenuWidget(ImagesModel.reportIcons, 'Report Post', () {
                                        Navigator.of(context).pop();
                                        showDialog(
                                            context: context,
                                            builder: (context) {
                                              return AddDialogue(newsFeedData);
                                            });
                                      }),
                                SizedBox(height: isAdmin ? 0 : 8)
                              ],
                            ),
                          ),
                          // PopupMenuItem 2
                        ],
                        offset: const Offset(0, 58),
                        color: Colors.white,
                        elevation: 4,
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                        child: Container(
                          height: 24,
                          width: 30,
                          decoration: BoxDecoration(color: const Color(0xffE4E6EB), borderRadius: BorderRadius.circular(10)),
                          child: const Center(child: Icon(Icons.more_horiz)),
                        ),
                      ),
                    ],
                  ),
                ),
                // const SizedBox(height: 5),
                SizedBox(height: newsFeedData.description!.isNotEmpty ? 8.0 : 0),
                newsFeedData.description!.isEmpty
                    ? const SizedBox.shrink()
                    : Container(
                        padding: const EdgeInsets.symmetric(horizontal: 18),
                        child: Column(
                          children: [
                            newsFeedData.description != null &&
                                    newsFeedData.description!.isNotEmpty &&
                                    newsFeedData.description!.contains("http")
                                ? MarkdownBody(
                                    onTapLink: (text, href, title) {
                                      href != null ? openNewLink(href) : null;
                                    },
                                    selectable: true,
                                    data: newsFeedData.description!,
                                    styleSheet: MarkdownStyleSheet(a: const TextStyle(fontSize: 17), p: robotoStyle600SemiBold))
                                : const SizedBox(),
                            SizedBox(height: newsFeedData.description != null && newsFeedData.description!.isNotEmpty ? 1.0 : 0),
                            newsFeedData.description != null &&
                                    newsFeedData.description!.isNotEmpty &&
                                    newsFeedData.totalImage == 0 &&
                                    newsFeedData.description!.contains("http")
                                ? AnyLinkPreviewGlobalWidget(extractdescription(newsFeedData.description!), 120.0, double.infinity, 10.0)
                                : newsFeedData.description!.contains("http")
                                    ? const SizedBox()
                                    : Text(newsFeedData.description!, style: robotoStyle600SemiBold),
                          ],
                        ),
                      ),
                SizedBox(height: newsFeedData.totalImage != 0 && newsFeedData.description!.isNotEmpty ? 10.0 : 10),
                // const SizedBox(height: 7),
                // if ((newsFeedData.totalImage! + newsFeedData.totalVideo!) != 0) PostPhotoContainer(index, newsfeedModel: newsFeedData),
                if ((newsFeedData.totalImage! + newsFeedData.totalVideo!) != 0) PostPhotoWidget(index, newsfeedModel: newsFeedData),
                Padding(
                  padding: const EdgeInsets.only(left: 12, top: 7, right: 12),
                  child: Row(
                    children: [
                      InkWell(
                        onTap: () {
                          commentProvider.changeLikeMenu(0);
                          commentProvider.clearAuthorData();
                          likeModalBottomSheet(newsFeedData);
                        },
                        child: Row(
                          children: [
                            Stack(
                              children: [
                                SizedBox(
                                    height: 17,
                                    width: 50 - (newsFeedData.totalLoved! == 0 ? 13 : 0) - (newsFeedData.totalSad! == 0 ? 13 : 0)),
                                reactWidget(ImagesModel.likeIconsSvg, AppColors.primaryColorLight),
                                newsFeedData.totalLoved! == 0
                                    ? const SizedBox.shrink()
                                    : Positioned(left: 14, child: reactWidget(ImagesModel.loveIcons, Colors.red)),
                                newsFeedData.totalSad! == 0
                                    ? const SizedBox.shrink()
                                    : Positioned(
                                        left: newsFeedData.totalLoved! == 0 ? 14 : 28,
                                        child: reactWidget(ImagesModel.hahaIcons, Colors.yellow)),
                              ],
                            ),
                            RichText(
                                text: TextSpan(
                                    text: newsFeedData.reaction != -1 ? "You " : "",
                                    style: robotoStyle600SemiBold.copyWith(fontSize: 12),
                                    children: [
                                  TextSpan(
                                      text: newsFeedData.reaction != -1 ? " and" : "",
                                      style:
                                          GoogleFonts.roboto(fontWeight: FontWeight.w400, fontSize: 12, color: AppColors.primaryColorLight),
                                      children: [
                                        TextSpan(
                                            text: newsFeedData.totalReaction.toString(),
                                            style: robotoStyle600SemiBold.copyWith(fontSize: 12),
                                            children: [
                                              TextSpan(
                                                  text:
                                                      " ${newsFeedData.totalReaction! <= 1 ? newsFeedData.reaction == -1 ? "Other" : "Like" : newsFeedData.reaction == -1 ? "Others" : "Likes"}",
                                                  style: robotoStyle400Regular.copyWith(fontSize: 12)),
                                            ])
                                      ])
                                ])),
                          ],
                        ),
                      ),
                      const Spacer(),
                      Row(
                        children: [
                          reactWidget(ImagesModel.commentIcons, AppColors.primaryColorLight),
                          const SizedBox(width: 3),
                          Text("${newsFeedData.totalComment}", style: robotoStyle600SemiBold.copyWith(fontSize: 14))
                        ],
                      ),
                      const SizedBox(width: 18),
                      Row(
                        children: [
                          reactWidget(ImagesModel.share2Icons, AppColors.primaryColorLight),
                          const SizedBox(width: 3),
                          Text("${newsFeedData.totalShared}", style: robotoStyle600SemiBold.copyWith(fontSize: 14))
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 14),
                Padding(
                  padding: const EdgeInsets.only(left: 18, right: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FlutterFeedReaction(
                        reactions: [
                          feedReactionWidget(0, "Like", ImagesModel.likeIconsSvg, colorText),
                          feedReactionWidget(1, "Love", ImagesModel.loveIcons, colorLoveReact),
                          feedReactionWidget(2, "Haha", ImagesModel.hahaIcons, colorHahaReact),
                        ],
                        dragSpace: 40.0,
                        onReactionSelected: (val) {
                          Provider.of<PageProvider>(context, listen: false).addLike(val.id + 1, index);
                          if (newsFeedData.reaction != val.id) {
                            commentProvider.addRealLike(newsFeedData.reaction == 1
                                ? newsFeedData.likeReactUrl!
                                : newsFeedData.reaction == 2
                                    ? newsFeedData.loveReactUrl!
                                    : newsFeedData.sadReactUrl!);
                          }
                        },
                        onPressed: () {},
                        prefix: likeCommentShareButtonWidget(
                            newsFeedData.reaction == -1 || newsFeedData.reaction == 1
                                ? ImagesModel.likeIcons
                                : newsFeedData.reaction == 2
                                    ? ImagesModel.loveIcons
                                    : ImagesModel.hahaIcons,
                            newsFeedData.reaction == -1 || newsFeedData.reaction == 1
                                ? "Like"
                                : newsFeedData.reaction == 2
                                    ? "Love"
                                    : "Smail", () {
                          commentProvider.addRealLike(newsFeedData.reaction == 1
                              ? newsFeedData.likeReactUrl!
                              : newsFeedData.reaction == 2
                                  ? newsFeedData.loveReactUrl!
                                  : newsFeedData.sadReactUrl!);
                          Provider.of<PageProvider>(context, listen: false).changeLikeStatus(index);
                        }, status: newsFeedData.reaction!),
                        containerWidth: 140.0,
                        childAnchor: Alignment.centerLeft,
                      ),
                      isHideCommentButton
                          ? const SizedBox.shrink()
                          : likeCommentShareButtonWidget(ImagesModel.commentIcons, "Comment", () {
                              Helper.toScreen(SinglePostScreen1(newsFeedData.id.toString(),
                                  index: index, isFromPage: isPage, commentUrl: newsFeedData.commentUrl!));
                            }),
                      PopupMenuButton(
                        itemBuilder: (context) => [
                          // PopupMenuItem 1
                          PopupMenuItem(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                PopUpMenuWidget(ImagesModel.shareTimelinesIcons, 'Share on your timeline', () {
                                  shareBottomSheet(context, "", newsFeedData);
                                }, size: 18),
                                PopUpMenuWidget(ImagesModel.shareTimelinesIcons, 'Share on your timeline', () {
                                  shareBottomSheet(context, newsFeedData.sharedByUrl.toString(), newsFeedData);
                                }, size: 18),
                                const SizedBox(height: 18),
                                PopUpMenuWidget(ImagesModel.shareMessageIcons, 'Share via message', () {}, size: 18),
                                const SizedBox(height: 18),
                                PopUpMenuWidget(ImagesModel.shareFriendIcons, 'Share to friends timeline', () {}, size: 16),
                                const SizedBox(height: 18),
                                PopUpMenuWidget(ImagesModel.shareGroupIcons, 'Share to a group', () {}, size: 16),
                                const SizedBox(height: 18),
                                PopUpMenuWidget(ImagesModel.pageIconsPng, 'Share to a page', () {}, size: 18, isShowAssetImage: true),
                                const SizedBox(height: 10),
                              ],
                            ),
                          ),
                          // PopupMenuItem 2
                        ],
                        offset: const Offset(0, 58),
                        color: Colors.white,
                        elevation: 4,
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                        child: Row(
                          children: [
                            Container(
                              height: 23,
                              width: 37,
                              decoration: BoxDecoration(color: AppColors.primaryColorLight, borderRadius: BorderRadius.circular(18)),
                              child: Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: SvgPicture.asset(ImagesModel.share2Icons, height: 13, width: 12, color: Colors.white)),
                            ),
                            const SizedBox(width: 5),
                            Text("Share", style: robotoStyle600SemiBold.copyWith())
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const Divider(thickness: 1.8, color: Color(0xffE4E6EB)),
              ],
            ));
  }
}

FeedReaction feedReactionWidget(int id, String title, String imagePath, Color color) {
  return FeedReaction(
    id: id,
    header: Text(title),
    reaction: Container(
      width: 30.0,
      height: 30.0,
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      child: SvgPicture.asset(imagePath, color: Colors.white),
    ),
  );
}

Widget reactWidget(String imagePath, Color color) {
  return Container(
    height: 17,
    width: 17,
    decoration: BoxDecoration(shape: BoxShape.circle, color: color),
    child: Center(child: SvgPicture.asset(imagePath, fit: BoxFit.cover, height: 9, width: 8)),
  );
}

Widget likeCommentShareButtonWidget(String image, String title, GestureTapCallback callback, {int status = 0}) {
  return InkWell(
    onTap: callback,
    child: Row(
      children: [
        Container(
          height: 23,
          width: 37,
          decoration: BoxDecoration(
              color: status == 0 || status == -1
                  ? AppColors.primaryColorLight
                  : status == 1
                      ? feedback
                      : status == 2
                          ? colorLoveReact
                          : colorHahaReact,
              borderRadius: BorderRadius.circular(18)),
          child: Padding(padding: const EdgeInsets.all(4.0), child: SvgPicture.asset(image, height: 13, width: 12, color: Colors.white)),
        ),
        const SizedBox(width: 5),
        Text(title, style: robotoStyle600SemiBold.copyWith())
      ],
    ),
  );
}
