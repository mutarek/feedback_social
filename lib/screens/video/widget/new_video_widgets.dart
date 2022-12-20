export 'package:flutter/material.dart';
export 'package:flutter/services.dart';
export 'dart:typed_data';
export 'package:image_picker/image_picker.dart';
export 'package:flutter/material.dart';
export 'package:image_picker/image_picker.dart';
export 'dart:async';
export 'package:flutter/services.dart';
import 'package:als_frontend/data/model/response/watch_list_model.dart';
import 'package:als_frontend/provider/auth_provider.dart';
import 'package:als_frontend/provider/watch_provider.dart';
import 'package:als_frontend/screens/group/public_group_screen.dart';
import 'package:als_frontend/screens/home/widget/profile_avatar.dart';
import 'package:als_frontend/screens/post/single_post_screen.dart';
import 'package:als_frontend/util/helper.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/custom_text.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';

class NewVideoPlayer extends StatefulWidget {
  const NewVideoPlayer(this.model, this.index, {Key? key}) : super(key: key);
  final WatchListModel model;
  final int index;

  @override
  State<NewVideoPlayer> createState() => _NewVideoPlayerState();
}

class _NewVideoPlayerState extends State<NewVideoPlayer> {
  late Future<void> initializeVideoPlayerFuture;
  VideoPlayerController? videoPlayerController;

  @override
  void initState() {
    super.initState();
    prepareVideo(url: widget.model.video.toString());
  }

  @override
  void dispose() {
    clear();
    super.dispose();
  }

  clear() {
    videoPlayerController!.dispose();
    // videoPlayerController!.removeListener(checkVideoProgress);
  }

  prepareVideo({required String url}) {
    if (videoPlayerController != null) {}
    videoPlayerController = VideoPlayerController.network(url);
    initializeVideoPlayerFuture = videoPlayerController!.initialize();
  }

  //videoPlayerController!.addListener(checkVideoProgress);

  @override
  Widget build(BuildContext context) {
    return Consumer<WatchProvider>(builder: (context, watchProvide, child) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: widget.model.isPage == true
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                            child: ProfileAvatar(
                                profileImageUrl:
                                    widget.model.page!.avatar.toString())),
                        const SizedBox(width: 8.0),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              InkWell(
                                child: Row(
                                  children: [
                                    const SizedBox(width: 5),
                                    Text(widget.model.page!.name.toString(),
                                        style: latoStyle500Medium.copyWith(
                                            fontWeight: FontWeight.w600)),
                                    const SizedBox(width: 5),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 4),
                              Padding(
                                padding: EdgeInsets.only(left: 5),
                                child: Text(
                                    "Posted By ${widget.model.user!.fullName}",
                                    style: latoStyle500Medium.copyWith(
                                        fontWeight: FontWeight.w100)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    )
                  : widget.model.isGroup == true
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                                onTap: () {
                                  Helper.toScreen(PublicGroupScreen(
                                      widget.model.group!.id.toString(),
                                      index: 1));
                                },
                                child: ProfileAvatar(
                                    profileImageUrl: widget
                                        .model.group!.coverPhoto
                                        .toString())),
                            const SizedBox(width: 8.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Helper.toScreen(PublicGroupScreen(
                                          widget.model.group!.id.toString(),
                                          index: 1));
                                    },
                                    child: Row(
                                      children: [
                                        const SizedBox(width: 5),
                                        Text(
                                            widget.model.group!.name.toString(),
                                            style: latoStyle500Medium.copyWith(
                                                fontWeight: FontWeight.w600)),
                                        const SizedBox(width: 5),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Padding(
                                    padding: EdgeInsets.only(left: 5),
                                    child: Text(
                                        "Posted By ${widget.model.user!.fullName}",
                                        style: latoStyle500Medium.copyWith(
                                            fontWeight: FontWeight.w100)),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                                child: ProfileAvatar(
                                    profileImageUrl:
                                        widget.model.user!.profileImage!)),
                            const SizedBox(width: 8.0),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  InkWell(
                                    child: Row(
                                      children: [
                                        const SizedBox(width: 5),
                                        Text(
                                            widget.model.user!.fullName
                                                .toString(),
                                            style: latoStyle500Medium.copyWith(
                                                fontWeight: FontWeight.w600)),
                                        const SizedBox(width: 5),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                ],
                              ),
                            ),
                          ],
                        )),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: CustomText(
                title: widget.model.headerText,
                color: Colors.black,
                fontWeight: FontWeight.w600,
                fontSize: 16),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: SizedBox(
                    height: MediaQuery.of(context).size.height / 2,
                    child: FutureBuilder(
                      future: initializeVideoPlayerFuture,
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          return Stack(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(5),
                                key: PageStorageKey(widget.model.video),
                                child: Chewie(
                                  key: PageStorageKey(widget.model.video),
                                  controller: ChewieController(
                                    allowFullScreen: false,
                                    videoPlayerController:
                                        videoPlayerController!,
                                    aspectRatio: videoPlayerController!
                                        .value.aspectRatio,
                                    showControls: true,
                                    showOptions: false,
                                    showControlsOnInitialize: false,
                                    zoomAndPan: true,
                                    allowedScreenSleep: false,
                                    useRootNavigator: false,
                                    controlsSafeAreaMinimum:
                                        const EdgeInsets.all(10),

                                    // Prepare the video to be played and display the first frame
                                    autoInitialize: true,
                                    looping: false,
                                    autoPlay: true,
                                    allowMuting: true,
                                    // Errors can occur for example when trying to play a video
                                    // from a non-existent URL
                                    errorBuilder: (context, errorMessage) {
                                      return Center(
                                        child: Text(
                                          errorMessage,
                                          style: const TextStyle(
                                              color: Colors.white),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                            ],
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: Colors.black,
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    decoration: BoxDecoration(
                        color: AppColors.scaffold,
                        borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey.withOpacity(.2),
                              blurRadius: 10.0,
                              spreadRadius: 3.0,
                              offset: const Offset(0.0, 0.0))
                        ]),
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              InkWell(
                                onTap: () {
                                  watchProvide.addLike(
                                      widget.model.postId as int, widget.index);
                                  print('like tap');
                                },
                                child: SizedBox(
                                  width: 40,
                                  height: 40,
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Icon(
                                          (widget.model.isLiked == true)
                                              ? Icons.favorite
                                              : Icons.favorite_border,
                                          size: 30,
                                          color: (widget.model.isLiked == true)
                                              ? Colors.red
                                              : Colors.black),
                                      Positioned(
                                          top: -13,
                                          left: 20,
                                          child: widget.model.totalLiked == 0
                                              ? const SizedBox.shrink()
                                              : Container(
                                                  padding:
                                                      const EdgeInsets.all(7),
                                                  decoration: BoxDecoration(
                                                      shape: BoxShape.circle,
                                                      color: AppColors.feedback,
                                                      border: Border.all(
                                                          color: Colors.white),
                                                      boxShadow: [
                                                        BoxShadow(
                                                            color: Colors.grey
                                                                .withOpacity(
                                                                    .2),
                                                            blurRadius: 10.0,
                                                            spreadRadius: 3.0,
                                                            offset:
                                                                const Offset(
                                                                    0.0, 0.0))
                                                      ]),
                                                  child: CustomText(
                                                      title: widget
                                                          .model.totalLiked
                                                          .toString(),
                                                      fontSize: 10,
                                                      color: Colors.white),
                                                ))
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 30.0),
                              InkWell(
                                onTap: () {
                                  Provider.of<AuthProvider>(context,
                                          listen: false)
                                      .getUserInfo();
                                  Helper.toScreen(SinglePostScreen(
                                      widget.model.commentUrl!,
                                      isHomeScreen: false,
                                      isProfileScreen: false,
                                      index: widget.index,
                                      postID: widget.model.postId as int,
                                      groupID: 1,
                                      isFromPage: false,
                                      isFromGroup: false));
                                },
                                child: SizedBox(
                                  width: 40,
                                  height: 40,
                                  child: Stack(
                                    clipBehavior: Clip.none,
                                    children: const [
                                      Icon(CupertinoIcons.chat_bubble,
                                          size: 30, color: Colors.black),
                                    ],
                                  ),
                                ),
                              ),
                              const SizedBox(width: 1.0),
                              InkWell(
                                onTap: () {
                                  //shareBottomSheet(context, post.isShare! ? post.sharePost!.postUrl! : post.commentUrl!, post);
                                },
                                child: SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: SvgPicture.asset(
                                      "assets/svg/share.svg",
                                      height: 30,
                                      color: Colors.black),
                                ),
                              ),
                            ],
                          ),
                        ),
                        widget.model.totalLiked == 0 &&
                                widget.model.totalShared == 0 &&
                                widget.model.totalComment == 0
                            ? const SizedBox.shrink()
                            : Container(
                                color: Colors.grey.withOpacity(.3),
                                height: 1,
                                margin:
                                    const EdgeInsets.only(top: 5, bottom: 10),
                              ),
                        widget.model.totalLiked == 0 &&
                                widget.model.totalShared == 0 &&
                                widget.model.totalComment == 0
                            ? const SizedBox.shrink()
                            : Padding(
                                padding: const EdgeInsets.only(
                                    left: 10, right: 15, bottom: 12),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        //if (post.totalLiked != 0) likeModalBottomView(context, post, true);
                                      },
                                      child: widget.model.totalLiked == 0
                                          ? const SizedBox.shrink()
                                          : Row(
                                              children: [
                                                Stack(
                                                  clipBehavior: Clip.none,
                                                  children: const [
                                                    SizedBox(width: 45),
                                                    Icon(
                                                        FontAwesomeIcons
                                                            .solidHeart,
                                                        size: 20,
                                                        color: kPrimaryColor),
                                                    Positioned(
                                                        left: 21,
                                                        top: -2,
                                                        child: Icon(
                                                            FontAwesomeIcons
                                                                .thumbsUp,
                                                            size: 20,
                                                            color:
                                                                kPrimaryColor)),
                                                  ],
                                                ),
                                                CustomText(
                                                    title:
                                                        ' ${widget.model.totalLiked.toString()} ${widget.model.totalLiked == 1 ? "Like" : "Likes"}',
                                                    fontSize: 14,
                                                    color: kPrimaryColor
                                                        .withOpacity(.8)),
                                              ],
                                            ),
                                    ),
                                    Row(
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            // Provider.of<AuthProvider>(context, listen: false).getUserInfo();
                                            // Helper.toScreen(
                                            //     SinglePostScreen(post.commentUrl!,
                                            //         isHomeScreen: isHomeScreen,
                                            //         isProfileScreen: isFromProfile,
                                            //         index: index,
                                            //         postID: postID,
                                            //         groupID: groupPageID,
                                            //         isFromPage: isPage,
                                            //         isFromGroup: isGroup));
                                          },
                                          child: CustomText(
                                              title: widget
                                                          .model.totalComment ==
                                                      0
                                                  ? ""
                                                  : '${widget.model.totalComment.toString()} ${widget.model.totalComment == 1 ? "comment" : "comments"}',
                                              fontSize: 14,
                                              color: kPrimaryColor
                                                  .withOpacity(.8)),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            // if (post.totalShared != 0) likeModalBottomView(context, post, false);
                                          },
                                          child: CustomText(
                                              title: widget.model.totalShared ==
                                                      0
                                                  ? ""
                                                  : '  ${widget.model.totalShared.toString()} ${widget.model.totalShared == 1 ? "share" : "shares"}',
                                              fontSize: 14,
                                              color: kPrimaryColor
                                                  .withOpacity(.8)),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ],
      );
    });
  }
}
