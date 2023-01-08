import 'package:als_frontend/data/model/response/watch_list_model.dart';
import 'package:als_frontend/helper/number_helper.dart';
import 'package:als_frontend/provider/auth_provider.dart';
import 'package:als_frontend/provider/watch_provider.dart';
import 'package:als_frontend/screens/group/public_group_screen.dart';
import 'package:als_frontend/screens/group/user_group_screen.dart';
import 'package:als_frontend/screens/home/widget/profile_avatar.dart';
import 'package:als_frontend/screens/page/public_page_screen.dart';
import 'package:als_frontend/screens/page/user_page_screen.dart';
import 'package:als_frontend/screens/post/single_post_screen.dart';
import 'package:als_frontend/screens/profile/profile_screen.dart';
import 'package:als_frontend/screens/profile/public_profile_screen.dart';
import 'package:als_frontend/util/helper.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/custom_text.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';
import 'package:video_player/video_player.dart';
import 'package:wakelock/wakelock.dart';
export 'dart:async';
export 'dart:typed_data';
export 'package:flutter/material.dart';
export 'package:flutter/material.dart';
export 'package:flutter/services.dart';
export 'package:flutter/services.dart';
export 'package:image_picker/image_picker.dart';
export 'package:image_picker/image_picker.dart';

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
    Wakelock.enabled;
    if (videoPlayerController != null) {
      videoPlayerController!.dispose();
    }
    showLog(widget.model.video.toString());
    prepareVideo(url: widget.model.video.toString());
  }

  @override
  void dispose() {
    Wakelock.disable();
    videoPlayerController!.dispose();
    videoPlayerController = null;
    super.dispose();
  }

  // @override
  // void deactivate() {
  //   videoPlayerController!.dispose();
  //   super.deactivate();
  // }

  prepareVideo({required String url}) async {
    final fileinfo = await checkCacheforUrl(url);
    if (fileinfo == null) {
      videoPlayerController = VideoPlayerController.network(url);
      initializeVideoPlayerFuture =
          videoPlayerController!.initialize().then((value) {
        cachedForUrl(url);
        setState(() {
          videoPlayerController!.play();
        });
      });
      //cachedForUrl(url);
    } else {
      final file = fileinfo.file;
      videoPlayerController = VideoPlayerController.file(file);
      initializeVideoPlayerFuture =
          videoPlayerController!.initialize().then((value) {
        setState(() {
          videoPlayerController!.play();
        });
      });
    }
  }

  Future<FileInfo?> checkCacheforUrl(String url) async {
    final FileInfo? value = await DefaultCacheManager().getFileFromCache(url);
    return value;
  }

  void cachedForUrl(String url) async {
    await DefaultCacheManager().getSingleFile(url).then((value) {});
    final key = url;
    CacheManager instance = CacheManager(
      Config(
        key,
        stalePeriod: const Duration(hours: 5),
        maxNrOfCacheObjects: 20,
        repo: JsonCacheInfoRepository(databaseName: key),
        fileService: HttpFileService(),
      ),
    );
  } //videoPlayerController!.addListener(checkVideoProgress);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        await videoPlayerController!.pause();
        return true;
      },
      child: Consumer<WatchProvider>(builder: (context, watchProvide, child) {
        return (videoPlayerController == null)
            ? Center(
                child: Image.asset("assets/background/custom_loading.gif"),
              )
            //child: Image.network(widget.model.thumbnail.toString()))
            : ((videoPlayerController!.value.isInitialized)
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 5),
                      Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: widget.model.isPage == true
                              ? Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    InkWell(
                                        onTap: () async {
                                          await videoPlayerController!.pause();
                                          if (Provider.of<AuthProvider>(context,
                                                      listen: false)
                                                  .userID ==
                                              widget.model.user!.id
                                                  .toString()) {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (_) =>
                                                        UserPageScreen(
                                                            widget
                                                                .model.page!.id
                                                                .toString(),
                                                            0)));
                                          } else {
                                            Helper.toScreen(PublicPageScreen(
                                                widget.model.page!.id
                                                    .toString()));
                                          }
                                        },
                                        child: ProfileAvatar(
                                            profileImageUrl: widget
                                                .model.page!.avatar
                                                .toString())),
                                    const SizedBox(width: 8.0),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              const SizedBox(width: 5),
                                              InkWell(
                                                onTap: () async {
                                                  await videoPlayerController!
                                                      .pause();
                                                  if (Provider.of<AuthProvider>(
                                                              context,
                                                              listen: false)
                                                          .userID ==
                                                      widget.model.user!.id
                                                          .toString()) {
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: (_) =>
                                                                UserPageScreen(
                                                                    widget
                                                                        .model
                                                                        .page!
                                                                        .id
                                                                        .toString(),
                                                                    0)));
                                                  } else {
                                                    Helper.toScreen(
                                                        PublicPageScreen(widget
                                                            .model.page!.id
                                                            .toString()));
                                                  }
                                                },
                                                child: Text(
                                                    widget.model.page!.name
                                                        .toString(),
                                                    style: latoStyle500Medium
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w600)),
                                              ),
                                              const SizedBox(width: 5),
                                            ],
                                          ),
                                          const SizedBox(height: 4),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 5),
                                            child: Text(
                                                "Posted By ${widget.model.user!.fullName}",
                                                style:
                                                    latoStyle500Medium.copyWith(
                                                        fontWeight:
                                                            FontWeight.w100)),
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 5),
                                            child: Row(children: [
                                              Text(
                                                  getDate(
                                                      widget.model.createdAt!,
                                                      context),
                                                  style: latoStyle400Regular
                                                      .copyWith(
                                                          color:
                                                              Colors.grey[600],
                                                          fontSize: 12.0)),
                                              Icon(Icons.public,
                                                  color: Colors.grey[600],
                                                  size: 12.0)
                                            ]),
                                          )
                                        ],
                                      ),
                                    ),
                                  ],
                                )
                              : widget.model.isGroup == true
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        InkWell(
                                            onTap: () async {
                                              await videoPlayerController!
                                                  .pause();
                                              if (Provider.of<AuthProvider>(
                                                          context,
                                                          listen: false)
                                                      .userID ==
                                                  widget.model.user!.id
                                                      .toString()) {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (_) =>
                                                            UserGroupScreen(
                                                                widget.model
                                                                    .group!.id
                                                                    .toString(),
                                                                0)));
                                              } else {
                                                Helper.toScreen(
                                                    PublicGroupScreen(widget
                                                        .model.group!.id
                                                        .toString()));
                                              }
                                            },
                                            child: ProfileAvatar(
                                                profileImageUrl: widget
                                                    .model.group!.coverPhoto
                                                    .toString())),
                                        const SizedBox(width: 8.0),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              InkWell(
                                                onTap: () async {
                                                  await videoPlayerController!
                                                      .pause();
                                                  if (Provider.of<AuthProvider>(
                                                              context,
                                                              listen: false)
                                                          .userID ==
                                                      widget.model.user!.id
                                                          .toString()) {
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: (_) =>
                                                                UserGroupScreen(
                                                                    widget
                                                                        .model
                                                                        .group!
                                                                        .id
                                                                        .toString(),
                                                                    0)));
                                                  } else {
                                                    Helper.toScreen(
                                                        PublicGroupScreen(widget
                                                            .model.group!.id
                                                            .toString()));
                                                  }
                                                },
                                                child: Row(
                                                  children: [
                                                    const SizedBox(width: 5),
                                                    InkWell(
                                                      onTap: () {
                                                        if (Provider.of<AuthProvider>(
                                                                    context,
                                                                    listen:
                                                                        false)
                                                                .userID ==
                                                            widget
                                                                .model.user!.id
                                                                .toString()) {
                                                          Navigator.of(context).push(
                                                              MaterialPageRoute(
                                                                  builder: (_) => UserGroupScreen(
                                                                      widget
                                                                          .model
                                                                          .group!
                                                                          .id
                                                                          .toString(),
                                                                      0)));
                                                        } else {
                                                          Helper.toScreen(
                                                              PublicGroupScreen(
                                                                  widget.model
                                                                      .group!.id
                                                                      .toString()));
                                                        }
                                                      },
                                                      child: Text(
                                                          widget
                                                              .model.group!.name
                                                              .toString(),
                                                          style: latoStyle500Medium
                                                              .copyWith(
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .w600)),
                                                    ),
                                                    const SizedBox(width: 5),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5),
                                                child: Text(
                                                    "Posted By ${widget.model.user!.fullName}",
                                                    style: latoStyle500Medium
                                                        .copyWith(
                                                            fontWeight:
                                                                FontWeight
                                                                    .w100)),
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5),
                                                child: Row(children: [
                                                  Text(
                                                      getDate(
                                                          widget
                                                              .model.createdAt!,
                                                          context),
                                                      style: latoStyle400Regular
                                                          .copyWith(
                                                              color: Colors
                                                                  .grey[600],
                                                              fontSize: 12.0)),
                                                  Icon(Icons.public,
                                                      color: Colors.grey[600],
                                                      size: 12.0)
                                                ]),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        InkWell(
                                            onTap: () async {
                                              if (Provider.of<AuthProvider>(
                                                          context,
                                                          listen: false)
                                                      .userID ==
                                                  widget.model.user!.id
                                                      .toString()) {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (_) =>
                                                            const ProfileScreen()));
                                              } else {
                                                Navigator.of(context).push(
                                                    MaterialPageRoute(
                                                        builder: (_) =>
                                                            PublicProfileScreen(
                                                                widget.model
                                                                    .user!.id
                                                                    .toString())));
                                              }
                                              await videoPlayerController!
                                                  .pause();
                                            },
                                            child: ProfileAvatar(
                                                profileImageUrl: widget.model
                                                    .user!.profileImage!)),
                                        const SizedBox(width: 8.0),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: [
                                              InkWell(
                                                onTap: () async {
                                                  if (Provider.of<AuthProvider>(
                                                              context,
                                                              listen: false)
                                                          .userID ==
                                                      widget.model.user!.id
                                                          .toString()) {
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: (_) =>
                                                                const ProfileScreen()));
                                                  } else {
                                                    Navigator.of(context).push(
                                                        MaterialPageRoute(
                                                            builder: (_) =>
                                                                PublicProfileScreen(
                                                                    widget
                                                                        .model
                                                                        .user!
                                                                        .id
                                                                        .toString())));
                                                  }

                                                  await videoPlayerController!
                                                      .pause();
                                                },
                                                child: Row(
                                                  children: [
                                                    const SizedBox(width: 5),
                                                    Text(
                                                        widget.model.user!
                                                            .fullName
                                                            .toString(),
                                                        style: latoStyle500Medium
                                                            .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600)),
                                                    const SizedBox(width: 5),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(height: 4),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 5),
                                                child: Row(children: [
                                                  Text(
                                                      getDate(
                                                          widget
                                                              .model.createdAt!,
                                                          context),
                                                      style: latoStyle400Regular
                                                          .copyWith(
                                                              color: Colors
                                                                  .grey[600],
                                                              fontSize: 12.0)),
                                                  Icon(Icons.public,
                                                      color: Colors.grey[600],
                                                      size: 12.0)
                                                ]),
                                              )
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
                              child: FutureBuilder(
                                future: initializeVideoPlayerFuture,
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState ==
                                      ConnectionState.done) {
                                    return Stack(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(5),
                                          key: PageStorageKey(
                                              widget.model.video),
                                          child: Chewie(
                                            key: PageStorageKey(
                                                widget.model.video),
                                            controller: ChewieController(
                                              allowFullScreen: true,
                                              videoPlayerController:
                                                  videoPlayerController!,
                                              aspectRatio:
                                                  videoPlayerController!
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
                                              errorBuilder:
                                                  (context, errorMessage) {
                                                return Center(
                                                    child: Text(errorMessage,
                                                        style: const TextStyle(
                                                            color:
                                                                Colors.white)));
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    );
                                  } else {
                                    return const Center(
                                        child: CircularProgressIndicator(
                                            color: Colors.black));
                                  }
                                },
                              ),
                            ),
                            const SizedBox(height: 30),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
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
                                      padding: const EdgeInsets.only(
                                          left: 15, right: 15),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              widget.model.isPage == true
                                                  ? watchProvide.addLike(
                                                      widget.model.postId!.toInt(), widget.index,
                                                      isFromPage: true,
                                                      isFromGroup: false,
                                                      groupPageId: widget.model.page!.id
                                                          as int)
                                                  : widget.model.isGroup == true
                                                      ? watchProvide.addLike(
                                                          widget.model.postId!
                                                              .toInt(),
                                                          widget.index,
                                                          isFromPage: false,
                                                          isFromGroup: true,
                                                          groupPageId: widget
                                                              .model
                                                              .group!
                                                              .id as int)
                                                      : watchProvide.addLike(
                                                          widget.model.postId!.toInt(),
                                                          widget.index,
                                                          isFromPage: false,
                                                          isFromGroup: false,
                                                          groupPageId: 0);
                                            },
                                            child: SizedBox(
                                              width: 40,
                                              height: 40,
                                              child: Stack(
                                                clipBehavior: Clip.none,
                                                children: [
                                                  Icon(
                                                      (widget.model.isLiked ==
                                                              true)
                                                          ? Icons.favorite
                                                          : Icons
                                                              .favorite_border,
                                                      size: 30,
                                                      color: (widget.model
                                                                  .isLiked ==
                                                              true)
                                                          ? Colors.red
                                                          : Colors.black),
                                                  Positioned(
                                                      top: -13,
                                                      left: 20,
                                                      child: widget.model
                                                                  .totalLiked ==
                                                              0
                                                          ? const SizedBox
                                                              .shrink()
                                                          : Container(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(7),
                                                              decoration: BoxDecoration(
                                                                  shape: BoxShape
                                                                      .circle,
                                                                  color: AppColors
                                                                      .feedback,
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .white),
                                                                  boxShadow: [
                                                                    BoxShadow(
                                                                        color: Colors
                                                                            .grey
                                                                            .withOpacity(
                                                                                .2),
                                                                        blurRadius:
                                                                            10.0,
                                                                        spreadRadius:
                                                                            3.0,
                                                                        offset: const Offset(
                                                                            0.0,
                                                                            0.0))
                                                                  ]),
                                                              child: CustomText(
                                                                  title: widget
                                                                      .model
                                                                      .totalLiked
                                                                      .toString(),
                                                                  fontSize: 10,
                                                                  color: Colors
                                                                      .white),
                                                            ))
                                                ],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(width: 30.0),
                                          InkWell(
                                            onTap: () async {
                                              Provider.of<AuthProvider>(context,
                                                      listen: false)
                                                  .getUserInfo();
                                              widget.model.isPage == true
                                                  ? Helper.toScreen(SinglePostScreen(
                                                      widget.model.commentUrl!,
                                                      isHomeScreen: false,
                                                      isProfileScreen: false,
                                                      index: 0,
                                                      postID: widget.model.postId!
                                                          .toInt(),
                                                      groupID: widget.model.page!.id!
                                                          .toInt(),
                                                      isFromPage: true,
                                                      isFromGroup: false))
                                                  : widget.model.isGroup == true
                                                      ? Helper.toScreen(SinglePostScreen(
                                                          widget
                                                              .model.commentUrl!,
                                                          isHomeScreen: false,
                                                          isProfileScreen:
                                                              false,
                                                          index: widget.index,
                                                          postID: widget.model.postId!
                                                              .toInt(),
                                                          groupID: widget
                                                              .model.group!.id!
                                                              .toInt(),
                                                          isFromPage: false,
                                                          isFromGroup: true))
                                                      : Helper.toScreen(SinglePostScreen(
                                                          widget.model.commentUrl!,
                                                          isHomeScreen: true,
                                                          isProfileScreen: true,
                                                          index: widget.index,
                                                          postID: widget.model.postId!.toInt(),
                                                          groupID: 0,
                                                          isFromPage: false,
                                                          isFromGroup: false));
                                              await videoPlayerController!
                                                  .pause();
                                            },
                                            child: SizedBox(
                                              width: 40,
                                              height: 40,
                                              child: Stack(
                                                clipBehavior: Clip.none,
                                                children: const [
                                                  Icon(
                                                      CupertinoIcons
                                                          .chat_bubble,
                                                      size: 30,
                                                      color: Colors.black),
                                                ],
                                              ),
                                            ),
                                          ),
                                          // const SizedBox(width: 1.0),
                                          // InkWell(
                                          //   onTap: () {
                                          //     //shareBottomSheet(context, post.isShare! ? post.sharePost!.postUrl! : post.commentUrl!, post);
                                          //   },
                                          //   child: SizedBox(
                                          //     width: 35,
                                          //     height: 35,
                                          //     child: SvgPicture.asset("assets/svg/share.svg", height: 30, color: Colors.black),
                                          //   ),
                                          // ),
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
                                            margin: const EdgeInsets.only(
                                                top: 5, bottom: 10),
                                          ),
                                    widget.model.totalLiked == 0 &&
                                            widget.model.totalShared == 0 &&
                                            widget.model.totalComment == 0
                                        ? const SizedBox.shrink()
                                        : Padding(
                                            padding: const EdgeInsets.only(
                                                left: 10,
                                                right: 15,
                                                bottom: 12),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    //if (post.totalLiked != 0) likeModalBottomView(context, post, true);
                                                  },
                                                  child: widget.model
                                                              .totalLiked ==
                                                          0
                                                      ? const SizedBox.shrink()
                                                      : Row(
                                                          children: [
                                                            Stack(
                                                              clipBehavior:
                                                                  Clip.none,
                                                              children: const [
                                                                SizedBox(
                                                                    width: 45),
                                                                Icon(
                                                                    FontAwesomeIcons
                                                                        .solidHeart,
                                                                    size: 20,
                                                                    color:
                                                                        kPrimaryColor),
                                                                Positioned(
                                                                    left: 21,
                                                                    top: -2,
                                                                    child: Icon(
                                                                        FontAwesomeIcons
                                                                            .thumbsUp,
                                                                        size:
                                                                            20,
                                                                        color:
                                                                            kPrimaryColor)),
                                                              ],
                                                            ),
                                                            CustomText(
                                                                title:
                                                                    ' ${widget.model.totalLiked.toString()} ${widget.model.totalLiked == 1 ? "Like" : "Likes"}',
                                                                fontSize: 14,
                                                                color: kPrimaryColor
                                                                    .withOpacity(
                                                                        .8)),
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
                                                          title: widget.model
                                                                      .totalComment ==
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
                                                          title: widget.model
                                                                      .totalShared ==
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
                            const SizedBox(height: 5),
                          ],
                        ),
                      ),
                    ],
                  )
                : Center(
                    child: Image.asset("assets/background/custom_loading.gif"),
                  ));
      }),
    );
  }

  checkInternetConnect() async {
    bool result = await InternetConnectionChecker().hasConnection;
    return result;
  }
}
