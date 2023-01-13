import 'package:als_frontend/data/model/response/news_feed_model.dart';
import 'package:als_frontend/provider/group_provider.dart';
import 'package:als_frontend/provider/newsfeed_provider.dart';
import 'package:als_frontend/provider/notication_provider.dart';
import 'package:als_frontend/provider/page_provider.dart';
import 'package:als_frontend/provider/post_provider.dart';
import 'package:als_frontend/provider/profile_provider.dart';
import 'package:als_frontend/screens/posts/view/video_view.dart';
import 'package:als_frontend/translations/locale_keys.g.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/custom_text.dart';
import 'package:als_frontend/widgets/custom_text_field.dart';
import 'package:als_frontend/widgets/network_image.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddPostScreen extends StatefulWidget {
  final String profileImage;
  final int groupPageID;
  final bool isFromGroupScreen;
  final bool isFromProfileScreen;
  final bool isForPage;
  final bool isEditPost;
  final NewsFeedModel? post;
  final int index;

  const AddPostScreen(this.profileImage,
      {this.groupPageID = 0,
      this.index = 0,
      this.isFromGroupScreen = false,
      this.isEditPost = false,
      this.isForPage = false,
      this.isFromProfileScreen = false,
      this.post,
      Key? key})
      : super(key: key);

  @override
  State<AddPostScreen> createState() => _AddPostScreenState();
}

class _AddPostScreenState extends State<AddPostScreen> {
  TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.isEditPost) {
      descriptionController.text = widget.post!.description!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Consumer5<PostProvider, NewsFeedProvider, GroupProvider, PageProvider, ProfileProvider>(
        builder: (context, postProvider, newsfeedProvider, groupProvider, pageProvider, profileProvider, child) => Container(
          height: 50,
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(color: Colors.blue.withOpacity(.1), borderRadius: BorderRadius.circular(10)),
          child: Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          postProvider.pickImage();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.photo_camera_back, size: 20, color: Colors.grey),
                            const SizedBox(width: 5),
                            CustomText(title: LocaleKeys.photos.tr(), textStyle: latoStyle700Bold.copyWith()),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          postProvider.pickVideo();
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(CupertinoIcons.video_camera, size: 28, color: Colors.grey),
                            const SizedBox(width: 5),
                            CustomText(title: LocaleKeys.video.tr(), textStyle: latoStyle700Bold.copyWith()),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.calendar_month, size: 20, color: Colors.grey),
                          const SizedBox(width: 5),
                          CustomText(title: LocaleKeys.event.tr(), textStyle: latoStyle700Bold.copyWith()),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Consumer<NotificationProvider>(builder: (context, notificationPro, child) {
                return InkWell(
                  onTap: () {
                    if (widget.isEditPost) {
                      postProvider
                          .updatePost(descriptionController.text, widget.post!.id! as int,
                              isFromGroup: widget.isFromGroupScreen, groupPageID: widget.groupPageID, isFromPage: widget.isForPage)
                          .then((value) {
                        descriptionController.clear();
                        postProvider.clearImageVideo();
                        if (value.status!) {
                          if (widget.isFromGroupScreen) {
                            groupProvider.updatePostOnTimeLine(widget.index, value.newsFeedData!);
                          } else if (widget.isForPage) {
                            pageProvider.updatePostOnTimeLine(widget.index, value.newsFeedData!);
                          } else if (widget.isFromProfileScreen) {
                            profileProvider.updatePostOnTimeLine(widget.index, value.newsFeedData!);
                          } else {
                            newsfeedProvider.updatePostOnTimeLine(widget.index, value.newsFeedData!);
                          }
                        }
                      });
                    } else {
                      postProvider
                          .addPost(descriptionController.text,
                              isFromGroup: widget.isFromGroupScreen, groupPageID: widget.groupPageID, isFromPage: widget.isForPage)
                          .then((value) {
                        descriptionController.clear();
                        postProvider.clearImageVideo();
                        if (value.status!) {
                          if (widget.isFromGroupScreen) {
                            groupProvider.addGroupPostTimeLine(value.newsFeedData!);
                          } else if (widget.isForPage) {
                            pageProvider.addPagePostToTimeLine(value.newsFeedData!);
                          } else {
                            newsfeedProvider.addPostOnTimeLine(value.newsFeedData!);
                          }
                        }
                      });
                    }
                    Navigator.of(context).pop();
                  },
                  child: Container(
                    width: 50,
                    height: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.blue.withOpacity(.3),
                        borderRadius: const BorderRadius.only(bottomRight: Radius.circular(10), topRight: Radius.circular(10))),
                    child: const Icon(Icons.send, color: Color(0xff031765)),
                  ),
                );
              })
            ],
          ),
        ),
      ),
      body: Consumer<PostProvider>(
        builder: (context, postProvider, child) => SafeArea(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(color: Colors.grey.withOpacity(.1), blurRadius: 10.0, spreadRadius: 3.3, offset: const Offset(0.0, 0.0))
              ],
            ),
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      circularImage(widget.profileImage, 30, 30),
                      // CircleAvatar(backgroundImage:CachedNetworkImageProvider(widget.profileImage),
                      //     backgroundColor: Colors.grey.withOpacity(.4)),
                      Expanded(
                          child: CustomTextField(
                        hintText: LocaleKeys.write_Something.tr(),
                        fillColor: Colors.transparent,
                        isCancelShadow: true,
                        borderRadius: 0,
                        horizontalSize: 9,
                        maxLines: null,
                        controller: descriptionController,
                        inputAction: TextInputAction.done,
                      )),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                ListView.builder(
                    itemCount: postProvider.afterConvertImageLists.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Container(
                          margin: const EdgeInsets.only(bottom: 15),
                          alignment: Alignment.center,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Stack(
                                children: [
                                  Image.file(postProvider.afterConvertImageLists[index]),
                                  Positioned(
                                      right: 5,
                                      top: 5,
                                      child: IconButton(
                                          onPressed: () {
                                            postProvider.cancelImageFromList(index);
                                          },
                                          icon: const Icon(Icons.clear, color: Colors.white)))
                                ],
                              )));
                    }),
                ListView.builder(
                    itemCount: postProvider.video.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Container(
                          margin: const EdgeInsets.only(bottom: 15),
                          alignment: Alignment.center,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Stack(
                                children: [
                                  VideoViewFromFile(postProvider.video[index]),
                                  Positioned(
                                    left: 0,
                                    right: 0,
                                    top: 0,
                                    bottom: 0,
                                    child: Container(
                                      width: double.infinity,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(color: Colors.white.withOpacity(.3)),
                                      child:
                                          IconButton(onPressed: () {}, icon: const Icon(Icons.play_circle, color: Colors.black, size: 38)),
                                    ),
                                  ),
                                  Positioned(
                                      right: 5,
                                      top: 10,
                                      child: IconButton(
                                          onPressed: () {
                                            postProvider.cancelVideoFromList(index);
                                          },
                                          icon: const Icon(Icons.clear, color: Colors.white)))
                                ],
                              )));
                    }),
                ListView.builder(
                    itemCount: postProvider.imageVideoLists.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Container(
                          margin: const EdgeInsets.only(bottom: 15),
                          alignment: Alignment.center,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: Stack(
                                children: [
                                  customNetworkImage(context, postProvider.imageVideoLists[index].url),
                                  Positioned(
                                      right: 5,
                                      top: 5,
                                      child: IconButton(
                                          onPressed: () {
                                            postProvider.clearUserImage(index);
                                          },
                                          icon: const Icon(Icons.clear, color: Colors.white)))
                                ],
                              )));
                    }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
