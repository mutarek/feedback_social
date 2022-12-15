import 'package:als_frontend/data/model/response/news_feed_model.dart';
import 'package:als_frontend/dialog_bottom_sheet/share_modal_bottom_sheet.dart';
import 'package:als_frontend/helper/number_helper.dart';
import 'package:als_frontend/provider/auth_provider.dart';
import 'package:als_frontend/provider/comment_provider.dart';
import 'package:als_frontend/provider/group_provider.dart';
import 'package:als_frontend/provider/newsfeed_provider.dart';
import 'package:als_frontend/provider/page_provider.dart';
import 'package:als_frontend/provider/profile_provider.dart';
import 'package:als_frontend/screens/group/public_group_screen.dart';
import 'package:als_frontend/screens/home/shimmer_effect/timeline_post_shimmer_widget.dart';
import 'package:als_frontend/screens/home/view/comment_widget.dart';
import 'package:als_frontend/screens/home/view/like_view.dart';
import 'package:als_frontend/screens/home/widget/photo_widget.dart';
import 'package:als_frontend/screens/home/widget/post_header.dart';
import 'package:als_frontend/screens/home/widget/profile_avatar.dart';
import 'package:als_frontend/screens/profile/profile_screen.dart';
import 'package:als_frontend/screens/profile/public_profile_screen.dart';
import 'package:als_frontend/translations/locale_keys.g.dart';
import 'package:als_frontend/util/helper.dart';
import 'package:als_frontend/util/palette.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SinglePostScreen extends StatefulWidget {
  final String url;
  final bool isHomeScreen;
  final bool isFromNotification;
  final bool isProfileScreen;
  final int index;
  final int postID;
  final int groupID;
  final bool isFromGroup;
  final bool isFromPage;

  const SinglePostScreen(this.url,
      {this.isHomeScreen = false,
      this.isFromNotification = false,
      this.isFromGroup = false,
      this.postID = 0,
      this.groupID = 0,
      this.isProfileScreen = false,
      this.isFromPage = false,
      this.index = 0,
      Key? key})
      : super(key: key);

  @override
  State<SinglePostScreen> createState() => _SinglePostScreenState();
}

class _SinglePostScreenState extends State<SinglePostScreen> {
  ScrollController controller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<NewsFeedProvider>(context, listen: false).callForSinglePosts(widget.url);
    Provider.of<CommentProvider>(context, listen: false).initializeCommentData(widget.url);
    if (widget.isFromGroup || widget.isFromPage) {
      Provider.of<CommentProvider>(context, listen: false).initializeSocket(widget.postID);
    } else {
      Provider.of<CommentProvider>(context, listen: false).initializeSinglePostSocket(widget.url);
    }

    controller.addListener(() {
      if (controller.offset >= controller.position.maxScrollExtent &&
          !controller.position.outOfRange &&
          Provider.of<CommentProvider>(context, listen: false).hasNextData) {
        Provider.of<CommentProvider>(context, listen: false).updatePageNo(widget.url);
      }
    });
  }

  final TextEditingController commentController = TextEditingController();
  final TextEditingController replyController = TextEditingController();


  void route(BuildContext context, int code, NewsFeedModel newsFeedData) {
    if (newsFeedData.sharePost!.shareFrom == 'group' && code == 0) {
      Helper.toScreen(PublicGroupScreen(newsFeedData.sharePost!.post!.groupModel!.id.toString(), index: 0));
    } else {
      if (Provider.of<AuthProvider>(context, listen: false).userID == newsFeedData.sharePost!.post!.author!.id.toString()) {
        Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ProfileScreen()));
      } else {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => PublicProfileScreen(newsFeedData.sharePost!.post!.author!.id.toString())));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () {
        Provider.of<CommentProvider>(context, listen: false).channelDismiss();
        Provider.of<CommentProvider>(context, listen: false).replyChannelDismiss();
        Helper.back();
        return Future.value(true);
      },
      child: Consumer3<NewsFeedProvider, CommentProvider, AuthProvider>(
          builder: (context, newsFeedProvider, commentProvider, authProvider, child) => Scaffold(
                backgroundColor: Colors.white,
                bottomSheet: Container(
                  height: 70,
                  padding: const EdgeInsets.only(top: 5),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: Colors.grey.withOpacity(.2), blurRadius: 10.0, spreadRadius: 3.0, offset: const Offset(0.0, 0.0))
                      ],
                      borderRadius: BorderRadius.circular(0)),
                  child: Column(
                    children: [
                      commentProvider.isShowCancelButton
                          ? Row(
                              children: [
                                const SizedBox(width: 15),
                                CustomText(title: LocaleKeys.replying_to.tr(), color: Colors.black),
                                CustomText(title: '${commentProvider.replyUserName} .', color: Colors.black, fontWeight: FontWeight.w700),
                                InkWell(
                                    onTap: () {
                                      commentProvider.resetReply();
                                    },
                                    child: CustomText(
                                        title: LocaleKeys.cancel.tr(), color: Colors.grey, fontWeight: FontWeight.w700)),
                              ],
                            )
                          : const SizedBox.shrink(),
                      TextField(
                        maxLines: 1,
                        textAlign: TextAlign.start,
                        decoration: InputDecoration(
                            suffixIcon: commentProvider.isCommentLoading
                                ? const SizedBox(height: 40, width: 40, child: Center(child: CupertinoActivityIndicator()))
                                : IconButton(
                                    onPressed: () {
                                      if (commentProvider.isShowCancelButton) {
                                        FocusScope.of(context).unfocus();
                                        commentProvider.addReply(commentController.text, widget.url).then((value) {
                                          if (value) {
                                            commentController.clear();
                                            Provider.of<NewsFeedProvider>(context, listen: false).updateSingleCommentDataCount();
                                            if (widget.isHomeScreen) {
                                              Provider.of<NewsFeedProvider>(context, listen: false).updateCommentDataCount(widget.index);
                                            } else if (widget.isProfileScreen) {
                                              Provider.of<ProfileProvider>(context, listen: false).updateCommentDataCount(widget.index);
                                            } else if (widget.isFromGroup) {
                                              Provider.of<GroupProvider>(context, listen: false).updateCommentDataCount(widget.index);
                                            } else if (widget.isFromPage) {
                                              Provider.of<PageProvider>(context, listen: false).updateCommentDataCount(widget.index);
                                            }
                                          }
                                        });
                                      } else {
                                        commentProvider
                                            .addComment(commentController.text, authProvider.name, authProvider.profileImage,
                                                newsFeedProvider.singleNewsFeedModel.id! as int, int.parse(authProvider.userID), widget.url)
                                            .then((value) {
                                          if (value == true) {
                                            newsFeedProvider.updateSingleCommentDataCount();
                                            if (widget.isHomeScreen) {
                                              Provider.of<NewsFeedProvider>(context, listen: false).updateCommentDataCount(widget.index);
                                            } else if (widget.isProfileScreen) {
                                              Provider.of<ProfileProvider>(context, listen: false).updateCommentDataCount(widget.index);
                                            } else if (widget.isFromGroup) {
                                              Provider.of<GroupProvider>(context, listen: false).updateCommentDataCount(widget.index);
                                            } else if (widget.isFromPage) {
                                              Provider.of<PageProvider>(context, listen: false).updateCommentDataCount(widget.index);
                                            }
                                          }
                                        });
                                      }

                                      commentController.text = "";
                                      // timelineProvider.channelDismiss();
                                      FocusScope.of(context).unfocus();
                                    },
                                    icon: Icon(FontAwesomeIcons.paperPlane, color: Palette.primary, size: height * 0.05 * .5),
                                  ),
                            contentPadding: EdgeInsets.fromLTRB(width * 0.04, height * 0.017, width * 0.02, 00),
                            hintText:
                                "${LocaleKeys.write.tr()} ${commentProvider.isShowCancelButton ? LocaleKeys.reply.tr() : LocaleKeys.comment.tr()} ${LocaleKeys.here.tr()}",
                            hintStyle: GoogleFonts.lato(fontWeight: FontWeight.w500, fontSize: 15, color: Colors.black.withOpacity(.6)),
                            border: InputBorder.none),
                        controller: commentController,
                      ),
                    ],
                  ),
                ),
                body: newsFeedProvider.isLoadingSinglePost
                    ? const TimeLinePostShimmerWidget(20)
                    : SafeArea(
                        child: Container(
                          padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                          decoration: const BoxDecoration(color: Colors.white),
                          child: SingleChildScrollView(
                            controller: controller,
                            physics: const BouncingScrollPhysics(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                PostHeaderWidget(post: newsFeedProvider.singleNewsFeedModel, index: 0),
                                SizedBox(
                                    height: newsFeedProvider.singleNewsFeedModel.description == null ||
                                            newsFeedProvider.singleNewsFeedModel.description!.isEmpty
                                        ? 0
                                        : 8.0),
                                Text(
                                    newsFeedProvider.singleNewsFeedModel.description == null ||
                                            newsFeedProvider.singleNewsFeedModel.description!.isEmpty
                                        ? ''
                                        : newsFeedProvider.singleNewsFeedModel.description!,
                                    style: latoStyle400Regular),
                                const SizedBox(height: 5),
                                if ((newsFeedProvider.singleNewsFeedModel.totalImage! + newsFeedProvider.singleNewsFeedModel.totalVideo!) !=
                                    0)
                                  PostPhotoContainer(0, newsfeedModel: newsFeedProvider.singleNewsFeedModel),
                                !newsFeedProvider.singleNewsFeedModel.isShare!
                                    ? const SizedBox()
                                    : Container(
                                        padding: const EdgeInsets.all(5),
                                        margin: const EdgeInsets.only(top: 10),
                                        decoration: BoxDecoration(
                                            border: Border.all(color: Colors.grey.withOpacity(.1)),
                                            borderRadius: BorderRadius.circular(10)),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    route(
                                                        context,
                                                        newsFeedProvider.singleNewsFeedModel.sharePost!.shareFrom == 'group' ? 0 : 1,
                                                        newsFeedProvider.singleNewsFeedModel);
                                                  },
                                                  child: ProfileAvatar(
                                                      profileImageUrl: newsFeedProvider.singleNewsFeedModel.sharePost!.shareFrom == 'group'
                                                          ? newsFeedProvider.singleNewsFeedModel.sharePost!.post!.groupModel!.coverPhoto!
                                                          : newsFeedProvider.singleNewsFeedModel.sharePost!.post!.author!.profileImage!),
                                                ),
                                                const SizedBox(width: 8.0),
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          route(
                                                              context,
                                                              newsFeedProvider.singleNewsFeedModel.sharePost!.shareFrom == 'group' ? 0 : 1,
                                                              newsFeedProvider.singleNewsFeedModel);
                                                        },
                                                        child: Text(
                                                            newsFeedProvider.singleNewsFeedModel.sharePost!.shareFrom == 'group'
                                                                ? newsFeedProvider.singleNewsFeedModel.sharePost!.post!.groupModel!.name!
                                                                : newsFeedProvider.singleNewsFeedModel.sharePost!.post!.author!.fullName!,
                                                            style: latoStyle500Medium.copyWith(fontWeight: FontWeight.w600)),
                                                      ),
                                                      SizedBox(
                                                          height:
                                                              newsFeedProvider.singleNewsFeedModel.sharePost!.shareFrom == 'group' ? 4 : 0),
                                                      newsFeedProvider.singleNewsFeedModel.sharePost!.shareFrom == 'group'
                                                          ? InkWell(
                                                              onTap: () {
                                                                route(context, 1, newsFeedProvider.singleNewsFeedModel);
                                                              },
                                                              child: Text(
                                                                  "${newsFeedProvider.singleNewsFeedModel.sharePost!.post!.author!.fullName!} Posted Here",
                                                                  style: latoStyle500Medium.copyWith(fontWeight: FontWeight.w400)),
                                                            )
                                                          : const SizedBox(),
                                                      Row(
                                                        children: [
                                                          Text(getDate(newsFeedProvider.singleNewsFeedModel.sharePost!.timestamp!, context),
                                                              style: latoStyle400Regular.copyWith(color: Colors.grey[600], fontSize: 12.0)),
                                                          Icon(Icons.public, color: Colors.grey[600], size: 12.0)
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                                height: newsFeedProvider.singleNewsFeedModel.sharePost!.post!.description!.isNotEmpty
                                                    ? 8.0
                                                    : 0),
                                            newsFeedProvider.singleNewsFeedModel.sharePost!.post!.description!.isNotEmpty
                                                ? Text(newsFeedProvider.singleNewsFeedModel.sharePost!.post!.description!,
                                                    style: latoStyle400Regular)
                                                : const SizedBox(),
                                            SizedBox(
                                                height: newsFeedProvider.singleNewsFeedModel.sharePost!.post!.totalImage != 0 &&
                                                        newsFeedProvider.singleNewsFeedModel.sharePost!.post!.description != null
                                                    ? 10.0
                                                    : 0),
                                            if ((newsFeedProvider.singleNewsFeedModel.sharePost!.post!.totalImage! +
                                                    newsFeedProvider.singleNewsFeedModel.sharePost!.post!.totalVideo!) !=
                                                0)
                                              PostPhotoContainer(0,
                                                  newsfeedModel: NewsFeedModel(
                                                      totalImage: newsFeedProvider.singleNewsFeedModel.sharePost!.post!.totalImage!,
                                                      images: newsFeedProvider.singleNewsFeedModel.sharePost!.post!.images!,
                                                      totalVideo: newsFeedProvider.singleNewsFeedModel.sharePost!.post!.totalVideo,
                                                      videos: newsFeedProvider.singleNewsFeedModel.sharePost!.post!.videos)),
                                            SizedBox(
                                                height: ((newsFeedProvider.singleNewsFeedModel.totalImage! +
                                                            newsFeedProvider.singleNewsFeedModel.totalVideo!) !=
                                                        0)
                                                    ? 10.0
                                                    : 15.0),
                                          ],
                                        ),
                                      ),
                                const SizedBox(height: 15.0),
                                newsFeedProvider.singleNewsFeedModel.totalLiked == 0 &&
                                        newsFeedProvider.singleNewsFeedModel.totalComment == 0 &&
                                        newsFeedProvider.singleNewsFeedModel.totalShared == 0
                                    ? const SizedBox.shrink()
                                    : Padding(
                                        padding: const EdgeInsets.only(left: 10, right: 15),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            InkWell(
                                              onTap: () {
                                                if (newsFeedProvider.singleNewsFeedModel.totalLiked != 0) {
                                                  likeModalBottomView(context, newsFeedProvider.singleNewsFeedModel, true);
                                                }
                                              },
                                              child: newsFeedProvider.singleNewsFeedModel.totalLiked == 0
                                                  ? const SizedBox.shrink()
                                                  : Row(
                                                      children: [
                                                        Stack(
                                                          clipBehavior: Clip.none,
                                                          children: const [
                                                            SizedBox(width: 45),
                                                            Icon(FontAwesomeIcons.solidHeart, size: 20, color: kPrimaryColor),
                                                            Positioned(
                                                                left: 21,
                                                                top: -2,
                                                                child: Icon(FontAwesomeIcons.thumbsUp, size: 20, color: kPrimaryColor)),
                                                          ],
                                                        ),
                                                        CustomText(
                                                            title:
                                                                ' ${newsFeedProvider.singleNewsFeedModel.totalLiked.toString()} ${newsFeedProvider.singleNewsFeedModel.totalLiked == 0 || newsFeedProvider.singleNewsFeedModel.totalLiked == 1 ? "Like" : "Likes"}',
                                                            fontSize: 14,
                                                            color: kPrimaryColor.withOpacity(.8)),
                                                      ],
                                                    ),
                                            ),
                                            Row(
                                              children: [
                                                CustomText(
                                                    title: newsFeedProvider.singleNewsFeedModel.totalComment == 0
                                                        ? ""
                                                        : '${newsFeedProvider.singleNewsFeedModel.totalComment.toString()} ${newsFeedProvider.singleNewsFeedModel.totalComment == 1 ? "comment" : "comments"}',
                                                    fontSize: 14,
                                                    color: kPrimaryColor.withOpacity(.8)),
                                                InkWell(
                                                  onTap: () {
                                                    if (newsFeedProvider.singleNewsFeedModel.totalShared != 0) {
                                                      likeModalBottomView(context, newsFeedProvider.singleNewsFeedModel, false);
                                                    }
                                                  },
                                                  child: CustomText(
                                                      title: newsFeedProvider.singleNewsFeedModel.totalShared == 0
                                                          ? ""
                                                          : '  ${newsFeedProvider.singleNewsFeedModel.totalShared.toString()} ${newsFeedProvider.singleNewsFeedModel.totalShared == 1 ? "share" : "shares"}',
                                                      fontSize: 14,
                                                      color: kPrimaryColor.withOpacity(.8)),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                newsFeedProvider.singleNewsFeedModel.totalLiked == 0 &&
                                        newsFeedProvider.singleNewsFeedModel.totalComment == 0 &&
                                        newsFeedProvider.singleNewsFeedModel.totalShared == 0
                                    ? const SizedBox.shrink()
                                    : Container(
                                        color: Colors.grey.withOpacity(.3), height: 1, margin: const EdgeInsets.only(top: 10, bottom: 5)),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        newsFeedProvider.singlePostLike(newsFeedProvider.singleNewsFeedModel.id! as int, (bool status) {
                                          if (widget.isHomeScreen) {
                                            newsFeedProvider.changeLikeStatus(status ? 1 : 0, widget.index);
                                          } else if (widget.isProfileScreen) {
                                            Provider.of<ProfileProvider>(context, listen: false)
                                                .changeLikeStatus(status ? 1 : 0, widget.index);
                                          } else if (widget.isFromGroup) {
                                            Provider.of<GroupProvider>(context, listen: false)
                                                .changeLikeStatus(status ? 1 : 0, widget.index);
                                          }
                                        }, isGroup: widget.isFromGroup, groupID: widget.groupID);
                                      },
                                      child: SizedBox(
                                        width: 40,
                                        height: 40,
                                        child: Stack(
                                          clipBehavior: Clip.none,
                                          children: [
                                            Icon(
                                                (newsFeedProvider.singleNewsFeedModel.isLiked == true)
                                                    ? Icons.favorite
                                                    : Icons.favorite_border,
                                                size: 30,
                                                color: (newsFeedProvider.singleNewsFeedModel.isLiked == true) ? Colors.red : Colors.black),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 30.0),
                                    SizedBox(
                                      width: 40,
                                      height: 40,
                                      child: Stack(
                                        clipBehavior: Clip.none,
                                        children: const [
                                          Icon(CupertinoIcons.chat_bubble, size: 30, color: Colors.black),
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 1.0),
                                    newsFeedProvider.singleNewsFeedModel.isShare!
                                        ? InkWell(
                                            onTap: () {
                                              shareBottomSheet(
                                                  context,
                                                  newsFeedProvider.singleNewsFeedModel.isShare!
                                                      ? newsFeedProvider.singleNewsFeedModel.sharePost!.postUrl!
                                                      : newsFeedProvider.singleNewsFeedModel.commentUrl!,
                                                  newsFeedProvider.singleNewsFeedModel);
                                            },
                                            child: SizedBox(
                                              width: 35,
                                              height: 35,
                                              child: SvgPicture.asset("assets/svg/share.svg", height: 30, color: Colors.black),
                                            ),
                                          )
                                        : InkWell(onTap: () {}, child: const Icon(CupertinoIcons.bookmark, size: 25, color: Colors.black)),
                                  ],
                                ),
                                const Divider(),
                                Align(
                                  alignment: Alignment.topCenter,
                                  child: commentProvider.comments.isEmpty
                                      ? Container(
                                          height: 40,
                                          alignment: Alignment.center,
                                          child: Text(LocaleKeys.no_Comment_Found.tr(), style: latoStyle800ExtraBold.copyWith()))
                                      : ListView.builder(
                                          itemCount: commentProvider.comments.length,
                                          shrinkWrap: true,
                                          padding: EdgeInsets.only(bottom: newsFeedProvider.singleNewsFeedModel.totalComment! > 5 ? 40 : 0),
                                          physics: const NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            return CommentWidget(
                                              width: width,
                                              height: height,
                                              onTap: () {},
                                              commentModels: commentProvider.comments[index],
                                              index: index,
                                              postIndex: widget.index,
                                              url: widget.url,
                                              replyController: replyController,
                                              postID: newsFeedProvider.singleNewsFeedModel.id! as int,
                                              isFromGroup: widget.isFromGroup,
                                              isFromPage: widget.isFromPage,
                                              isProfileScreen: widget.isProfileScreen,
                                              isHomeScreen: widget.isHomeScreen,
                                            );
                                          }),
                                ),
                                const SizedBox(height: 100)
                              ],
                            ),
                          ),
                        ),
                      ),
              )),
    );
  }
}
