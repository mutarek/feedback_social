import 'package:als_frontend/old_code/const/palette.dart';
import 'package:als_frontend/provider/auth_provider.dart';
import 'package:als_frontend/provider/comment_provider.dart';
import 'package:als_frontend/provider/group_provider.dart';
import 'package:als_frontend/provider/newsfeed_provider.dart';
import 'package:als_frontend/provider/page_provider.dart';
import 'package:als_frontend/provider/profile_provider.dart';
import 'package:als_frontend/screens/home/view/comment_widget.dart';
import 'package:als_frontend/screens/home/widget/photo_widget.dart';
import 'package:als_frontend/screens/home/widget/post_header.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class SinglePostScreen extends StatefulWidget {
  final String url;
  final bool isFromHomeTimeline;
  final bool isFromNotification;
  final bool isProfileScreen;
  final int timelineIndex;
  final int postID;
  final int groupID;
  final bool isFromGroup;
  final bool isFromPage;

  const SinglePostScreen(this.url,
      {this.isFromHomeTimeline = false,
      this.isFromNotification = false,
      this.isFromGroup = false,
      this.postID = 0,
      this.groupID = 0,
      this.isProfileScreen = false,
      this.isFromPage = false,
      this.timelineIndex = 0,
      Key? key})
      : super(key: key);

  @override
  State<SinglePostScreen> createState() => _SinglePostScreenState();
}

class _SinglePostScreenState extends State<SinglePostScreen> {
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
    Provider.of<AuthProvider>(context, listen: false).getUserInfo();
  }

  final TextEditingController commentController = TextEditingController();
  final TextEditingController replyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () {
        Provider.of<CommentProvider>(context, listen: false).channelDismiss();
        Provider.of<CommentProvider>(context, listen: false).replyChannelDismiss();
        Get.back();
        return Future.value(true);
      },
      child: Consumer3<NewsFeedProvider, CommentProvider, AuthProvider>(
          builder: (context, newsFeedProvider, commentProvider, authProvider, child) => Scaffold(
                backgroundColor: Colors.white,
                bottomSheet: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(color: Colors.grey.withOpacity(.2), blurRadius: 10.0, spreadRadius: 3.0, offset: const Offset(0.0, 0.0))
                      ],
                      borderRadius: BorderRadius.circular(0)),
                  child: TextField(
                    maxLines: null,
                    textAlign: TextAlign.start,
                    decoration: InputDecoration(
                        suffixIcon: commentProvider.isCommentLoading
                            ? const SizedBox(height: 40, width: 40, child: Center(child: CircularProgressIndicator()))
                            : IconButton(
                                onPressed: () {
                                  commentProvider
                                      .addComment(commentController.text, authProvider.name, authProvider.profileImage,
                                          newsFeedProvider.singleNewsFeedModel.id!, int.parse(authProvider.userID), widget.url)
                                      .then((value) {
                                    if (value == true) {
                                      newsFeedProvider.updateSingleCommentDataCount();
                                      if (widget.isFromHomeTimeline) {
                                        Provider.of<NewsFeedProvider>(context, listen: false).updateCommentDataCount(widget.timelineIndex);
                                      } else if (widget.isProfileScreen) {
                                        Provider.of<ProfileProvider>(context, listen: false).updateCommentDataCount(widget.timelineIndex);
                                      } else if (widget.isFromGroup) {
                                        Provider.of<GroupProvider>(context, listen: false).updateCommentDataCount(widget.timelineIndex);
                                      } else if (widget.isFromPage) {
                                        Provider.of<PageProvider>(context, listen: false).updateCommentDataCount(widget.timelineIndex);
                                      }
                                    }
                                  });

                                  commentController.text = "";
                                  // timelineProvider.channelDismiss();
                                  FocusScope.of(context).unfocus();
                                },
                                icon: Icon(FontAwesomeIcons.paperPlane, color: Palette.primary, size: height * 0.05 * .5),
                              ),
                        contentPadding: EdgeInsets.fromLTRB(width * 0.04, height * 0.017, width * 0.02, 00),
                        hintText: "Write Comment Here...",
                        hintStyle: GoogleFonts.lato(fontWeight: FontWeight.w500, fontSize: 15, color: Colors.black.withOpacity(.6)),
                        border: InputBorder.none),
                    controller: commentController,
                  ),
                ),
                body: newsFeedProvider.isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : SafeArea(
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(.2), blurRadius: 10.0, spreadRadius: 3.3, offset: const Offset(0.0, 0.0))
                            ],
                          ),
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            padding: const EdgeInsets.only(bottom: 40),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                PostHeaderWidget(
                                  post: newsFeedProvider.singleNewsFeedModel,
                                  index: 0,
                                ),
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
                                if ((newsFeedProvider.singleNewsFeedModel.totalImage! + newsFeedProvider.singleNewsFeedModel.totalVideo!) !=
                                    0)
                                  PostPhotoContainer(0, postImageUrl: newsFeedProvider.singleNewsFeedModel),
                                const SizedBox(height: 10.0),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        newsFeedProvider
                                            .singlePostLike(newsFeedProvider.singleNewsFeedModel.id!,
                                                isGroup: widget.isFromGroup, groupID: widget.groupID)
                                            .then((value) {
                                          if (value != -1) {
                                            if (widget.isFromHomeTimeline) {
                                              newsFeedProvider.changeLikeStatus(value, widget.timelineIndex);
                                            } else if (widget.isProfileScreen) {
                                              Provider.of<ProfileProvider>(context, listen: false)
                                                  .changeLikeStatus(value, widget.timelineIndex);
                                            } else if (widget.isFromGroup) {
                                              Provider.of<GroupProvider>(context, listen: false)
                                                  .changeLikeStatus(value, widget.timelineIndex);
                                            }
                                          }
                                        });
                                      },
                                      child: SizedBox(
                                        width: 40,
                                        height: 40,
                                        child: Stack(
                                          clipBehavior: Clip.none,
                                          children: [
                                            Icon((newsFeedProvider.isLikeMe) ? Icons.favorite : Icons.favorite_border,
                                                size: 30, color: (newsFeedProvider.isLikeMe) ? Colors.red : Colors.black),
                                            Positioned(
                                                top: -13,
                                                left: 20,
                                                child: newsFeedProvider.singleNewsFeedModel.totalLike == 0
                                                    ? const SizedBox.shrink()
                                                    : Container(
                                                        padding: const EdgeInsets.all(7),
                                                        decoration: BoxDecoration(
                                                            shape: BoxShape.circle,
                                                            color: Colors.blue,
                                                            border: Border.all(color: Colors.white),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                  color: Colors.grey.withOpacity(.2),
                                                                  blurRadius: 10.0,
                                                                  spreadRadius: 3.0,
                                                                  offset: const Offset(0.0, 0.0))
                                                            ]),
                                                        child: CustomText(
                                                            title: newsFeedProvider.singleNewsFeedModel.totalLike.toString(), fontSize: 10),
                                                      ))
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 30.0),
                                    InkWell(
                                      onTap: () {
                                        // Get.to(CommentsScreen(index, post.id as int,
                                        //     isHomeScreen: isHomeNewsFeedProvider,
                                        //     isProfileScreen: isFromProfile,
                                        //     groupID: groupID,
                                        //     isGroupScreen: isGroup));
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
                                                child: newsFeedProvider.singleNewsFeedModel.totalComment == 0
                                                    ? const SizedBox.shrink()
                                                    : Container(
                                                        padding: const EdgeInsets.all(7),
                                                        decoration: BoxDecoration(
                                                            shape: BoxShape.circle,
                                                            color: Colors.blue,
                                                            border: Border.all(color: Colors.white),
                                                            boxShadow: [
                                                              BoxShadow(
                                                                  color: Colors.grey.withOpacity(.2),
                                                                  blurRadius: 10.0,
                                                                  spreadRadius: 3.0,
                                                                  offset: const Offset(0.0, 0.0))
                                                            ]),
                                                        child: CustomText(
                                                            title: newsFeedProvider.singleNewsFeedModel.totalComment.toString(),
                                                            fontSize: 10),
                                                      ))
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 1.0),
                                    newsFeedProvider.singleNewsFeedModel.isShare!
                                        ? InkWell(
                                            onTap: () {
                                              //Get.to(CommentsScreen(index, post.id as int, isHomeScreen: true));
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
                                      ? Center(child: Text('No Comment Found', style: latoStyle800ExtraBold.copyWith()))
                                      : ListView.builder(
                                          itemCount: commentProvider.comments.length,
                                          shrinkWrap: true,
                                          physics: const NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            return CommentWidget(
                                              width: width,
                                              height: height,
                                              onTap: () {},
                                              commentModels: commentProvider.comments[index],
                                              index: index,
                                              url: widget.url,
                                              replyController: replyController,
                                              postID: newsFeedProvider.singleNewsFeedModel.id!,
                                              isFromGroup: widget.isFromGroup,
                                              isFromPage: widget.isFromPage,
                                              isProfileScreen: widget.isProfileScreen,
                                              isFromHomeTimeline: widget.isFromHomeTimeline,
                                            );
                                          }),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
              )),
    );
  }
}
