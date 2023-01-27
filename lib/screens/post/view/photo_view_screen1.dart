import 'package:als_frontend/data/model/response/news_feed_model.dart';
import 'package:als_frontend/data/model/response/watch_list_model.dart';
import 'package:als_frontend/provider/comment_provider.dart';
import 'package:als_frontend/provider/other_provider.dart';
import 'package:als_frontend/screens/post/widget/post_widget.dart';
import 'package:als_frontend/screens/video/video_screen.dart';
import 'package:als_frontend/util/helper.dart';
import 'package:als_frontend/util/image.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/network_image.dart';
import 'package:als_frontend/widgets/single_image_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feed_reaction/flutter_feed_reaction.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PhotoViewScreen1 extends StatefulWidget {
  final NewsFeedModel newsfeedModel;
  final int postIndex;

  const PhotoViewScreen1(this.newsfeedModel, this.postIndex, {Key? key}) : super(key: key);

  @override
  State<PhotoViewScreen1> createState() => _PhotoViewScreen1State();
}

class _PhotoViewScreen1State extends State<PhotoViewScreen1> {
  int totalImage = 0;
  int totalVideo = 0;
  int totalImageVideo = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer2<CommentProvider, OtherProvider>(
          builder: (context, commentProvider, otherProvider, child) {
            totalImage = otherProvider.imageVideoLists.imagesData!.length;
            totalVideo = otherProvider.imageVideoLists.videosData!.length;
            totalImageVideo = totalImage + totalVideo;

            return ListView.builder(
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(vertical: 0),
                physics: const BouncingScrollPhysics(),
                itemCount: otherProvider.imageVideoLists.imagesData!.length + otherProvider.imageVideoLists.videosData!.length,
                itemBuilder: (context, index) {
                  bool isVideo = false;
                  String url = '';
                  ImagesData imageData = ImagesData();
                  VideosData videoData = VideosData();
                  if (index >= totalImage) {
                    isVideo = true;
                    url = otherProvider.imageVideoLists.videosData![index - totalImage].thumbnail!;
                    videoData = otherProvider.imageVideoLists.videosData![index - totalImage];
                  } else {
                    isVideo = false;
                    url = otherProvider.imageVideoLists.imagesData![index].image!;
                    imageData = otherProvider.imageVideoLists.imagesData![index];
                  }

                  return InkWell(
                    onTap: () {
                      route(isVideo, url, isVideo?videoData.video!:"");
                    },
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            customNetworkImage(url),
                            isVideo == true
                                ? Positioned(
                                    left: 0,
                                    right: 0,
                                    top: 0,
                                    bottom: 0,
                                    child: Container(
                                      width: double.infinity,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(color: Colors.white.withOpacity(.3)),
                                      child: IconButton(
                                          onPressed: () {
                                            route(isVideo, url, videoData.video!);
                                          },
                                          icon: SvgPicture.asset(ImagesModel.videoIcons)),
                                    ),
                                  )
                                : const SizedBox.shrink()
                          ],
                        ),
                        isVideo == true
                            ? Padding(
                                padding: const EdgeInsets.only(left: 12, top: 7, right: 12),
                                child: Row(
                                  children: [
                                    Stack(
                                      children: [
                                        SizedBox(
                                            height: 17,
                                            width: 50 -
                                                (widget.newsfeedModel.totalLoved! == 0 ? 13 : 0) -
                                                (widget.newsfeedModel.totalSad! == 0 ? 13 : 0)),
                                        reactWidget(ImagesModel.likeIconsSvg, AppColors.primaryColorLight),
                                        widget.newsfeedModel.totalLoved! == 0
                                            ? const SizedBox.shrink()
                                            : Positioned(left: 14, child: reactWidget(ImagesModel.loveIcons, Colors.red)),
                                        widget.newsfeedModel.totalSad! == 0
                                            ? const SizedBox.shrink()
                                            : Positioned(
                                                left: widget.newsfeedModel.totalLoved! == 0 ? 14 : 28,
                                                child: reactWidget(ImagesModel.hahaIcons, Colors.yellow)),
                                      ],
                                    ),
                                    RichText(
                                        text: TextSpan(
                                            text: widget.newsfeedModel.reaction != -1 ? "You " : "",
                                            style: robotoStyle600SemiBold.copyWith(fontSize: 12),
                                            children: [
                                          TextSpan(
                                              text: widget.newsfeedModel.reaction != -1 ? " and" : "",
                                              style: GoogleFonts.roboto(
                                                  fontWeight: FontWeight.w400, fontSize: 12, color: AppColors.primaryColorLight),
                                              children: [
                                                TextSpan(
                                                    text: widget.newsfeedModel.totalReaction.toString(),
                                                    style: robotoStyle600SemiBold.copyWith(fontSize: 12),
                                                    children: [
                                                      TextSpan(
                                                          text:
                                                              " ${widget.newsfeedModel.totalLiked! <= 1 ? widget.newsfeedModel.reaction == true ? "Other" : "Like" : widget.newsfeedModel.reaction == true ? "Others" : "Likes"}",
                                                          style: robotoStyle400Regular.copyWith(fontSize: 12)),
                                                    ])
                                              ])
                                        ])),
                                    const Spacer(),
                                    Row(
                                      children: [
                                        reactWidget(ImagesModel.commentIcons, AppColors.primaryColorLight),
                                        const SizedBox(width: 3),
                                        Text("${widget.newsfeedModel.totalComment}", style: robotoStyle600SemiBold.copyWith(fontSize: 14))
                                      ],
                                    ),
                                    const SizedBox(width: 18),
                                    Row(
                                      children: [
                                        reactWidget(ImagesModel.share2Icons, AppColors.primaryColorLight),
                                        const SizedBox(width: 3),
                                        Text("${widget.newsfeedModel.totalShared}", style: robotoStyle600SemiBold.copyWith(fontSize: 14))
                                      ],
                                    ),
                                  ],
                                ),
                              )
                            : Padding(
                                padding: const EdgeInsets.only(left: 12, top: 7, right: 12),
                                child: Row(
                                  children: [
                                    Stack(
                                      children: [
                                        SizedBox(
                                            height: 17,
                                            width: 50 - (imageData.totalLoved! == 0 ? 13 : 0) - (imageData.totalSad! == 0 ? 13 : 0)),
                                        reactWidget(ImagesModel.likeIconsSvg, AppColors.primaryColorLight),
                                        imageData.totalLoved! == 0
                                            ? const SizedBox.shrink()
                                            : Positioned(left: 14, child: reactWidget(ImagesModel.loveIcons, Colors.red)),
                                        imageData.totalSad! == 0
                                            ? const SizedBox.shrink()
                                            : Positioned(
                                                left: imageData.totalLoved! == 0 ? 14 : 28,
                                                child: reactWidget(ImagesModel.hahaIcons, Colors.yellow)),
                                      ],
                                    ),
                                    RichText(
                                        text: TextSpan(
                                            text: imageData.reaction != -1 ? "You " : "",
                                            style: robotoStyle600SemiBold.copyWith(fontSize: 12),
                                            children: [
                                          TextSpan(
                                              text: imageData.reaction != -1 ? " and" : "",
                                              style: GoogleFonts.roboto(
                                                  fontWeight: FontWeight.w400, fontSize: 12, color: AppColors.primaryColorLight),
                                              children: [
                                                TextSpan(
                                                    text: imageData.totalReaction.toString(),
                                                    style: robotoStyle600SemiBold.copyWith(fontSize: 12),
                                                    children: [
                                                      TextSpan(
                                                          text:
                                                              " ${imageData.totalLiked! <= 1 ? imageData.reaction == true ? "Other" : "Like" : imageData.reaction == true ? "Others" : "Likes"}",
                                                          style: robotoStyle400Regular.copyWith(fontSize: 12)),
                                                    ])
                                              ])
                                        ])),
                                    const Spacer(),
                                    Row(
                                      children: [
                                        reactWidget(ImagesModel.commentIcons, AppColors.primaryColorLight),
                                        const SizedBox(width: 3),
                                        Text("${imageData.totalComment}", style: robotoStyle600SemiBold.copyWith(fontSize: 14))
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
                                  otherProvider.addLikeImageVideo(val.id + 1, isVideo ? index - totalImage : index, isVideo);
                                  if (!isVideo) {
                                    if (imageData.reaction != val.id) {
                                      commentProvider.addRealLike(imageData.reaction == 1
                                          ? imageData.likeReactUrl!
                                          : imageData.reaction == 2
                                              ? imageData.loveReactUrl!
                                              : imageData.sadReactUrl!);
                                    }
                                  }
                                },
                                onPressed: () {},
                                prefix: !isVideo
                                    ? likeCommentShareButtonWidget(
                                        imageData.reaction == -1 || imageData.reaction == 1
                                            ? ImagesModel.likeIcons
                                            : imageData.reaction == 2
                                                ? ImagesModel.loveIcons
                                                : ImagesModel.hahaIcons,
                                        imageData.reaction == -1 || imageData.reaction == 1
                                            ? "Like"
                                            : imageData.reaction == 2
                                                ? "Love"
                                                : "Smail", () {
                                        commentProvider.addRealLike(imageData.reaction == 1
                                            ? imageData.likeReactUrl!
                                            : imageData.reaction == 2
                                                ? imageData.loveReactUrl!
                                                : imageData.sadReactUrl!);

                                        otherProvider.changeImageVideoLikeStatus(widget.postIndex);
                                      }, status: imageData.reaction!)
                                    : likeCommentShareButtonWidget(
                                        widget.newsfeedModel.reaction == -1 || widget.newsfeedModel.reaction == 1
                                            ? ImagesModel.likeIcons
                                            : widget.newsfeedModel.reaction == 2
                                                ? ImagesModel.loveIcons
                                                : ImagesModel.hahaIcons,
                                        widget.newsfeedModel.reaction == -1 || widget.newsfeedModel.reaction == 1
                                            ? "Like"
                                            : widget.newsfeedModel.reaction == 2
                                                ? "Love"
                                                : "Smail",
                                        () {},
                                        status: widget.newsfeedModel.reaction!),
                                containerWidth: 140.0,
                                childAnchor: Alignment.centerLeft,
                              ),
                              likeCommentShareButtonWidget(ImagesModel.commentIcons, "Comment", () {}),
                            ],
                          ),
                        ),
                        const Divider(thickness: 1.8, color: Color(0xffE4E6EB)),
                      ],
                    ),
                  );
                });
          },
        ),
      ),
    );
  }

  void route(bool isVideo, String thumbnail, String video) {
    if (isVideo == true) {
      User user = User(
          id: widget.newsfeedModel.author!.id,
          fullName: widget.newsfeedModel.author!.fullName,
          profileImage: widget.newsfeedModel.author!.profileImage);

      WatchListModel watchListModel = WatchListModel(
          thumbnail: thumbnail,
          video: video,
          user: user,
          watchId: DateTime.now().microsecondsSinceEpoch,
          postId: widget.newsfeedModel.id,
          headerText: widget.newsfeedModel.description,
          createdAt: widget.newsfeedModel.timestamp,
          totalComment: widget.newsfeedModel.totalComment,
          commentUrl: widget.newsfeedModel.commentUrl,
          isLiked: widget.newsfeedModel.reaction != -1,
          likedByUrl: widget.newsfeedModel.likeReactUrl,
          sharedByUrl: widget.newsfeedModel.sharedByUrl,
          totalLiked: widget.newsfeedModel.totalLiked,
          totalShared: widget.newsfeedModel.totalShared);

      Navigator.of(context).push(MaterialPageRoute(builder: (_) => VideoScreen(watchListModel)));
    } else {
      Helper.toScreen(SingleImageView(imageURL: thumbnail));
    }
  }
}
