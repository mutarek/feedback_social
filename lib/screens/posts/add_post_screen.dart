import 'package:als_frontend/data/model/response/news_feed_model.dart';
import 'package:als_frontend/provider/group_provider.dart';
import 'package:als_frontend/provider/newsfeed_provider.dart';
import 'package:als_frontend/provider/post_provider.dart';
import 'package:als_frontend/screens/posts/view/video_view.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/custom_text.dart';
import 'package:als_frontend/widgets/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AddPostScreen extends StatelessWidget {
  final String profileImage;
  final int groupID;
  final bool isFromGroupScreen;

  AddPostScreen(this.profileImage, {this.groupID = 0, this.isFromGroupScreen = false, Key? key}) : super(key: key);
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Provider.of<PostProvider>(context, listen: false).clearImageVideo(isFirstTime: true);

    return Scaffold(
      bottomNavigationBar: Consumer3<PostProvider, NewsFeedProvider, GroupProvider>(
        builder: (context, postProvider, newsfeedProvider, groupProvider, child) => Container(
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
                            CustomText(title: 'Photo', textStyle: latoStyle700Bold.copyWith()),
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
                            CustomText(title: 'Video', textStyle: latoStyle700Bold.copyWith()),
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
                          CustomText(title: 'Event', textStyle: latoStyle700Bold.copyWith()),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () {
                  if (isFromGroupScreen) {
                    postProvider.addPost(descriptionController.text, (bool status, NewsFeedData n, int value) {
                      if (status) {
                        descriptionController.clear();
                        postProvider.clearImageVideo();
                        groupProvider.addGroupPostTimeLine(n);
                      }
                    }, isFromGroup: true, groupID: groupID);
                  } else {
                    newsfeedProvider.initializeCount0();
                    postProvider.addPost(
                      descriptionController.text,
                      (bool status, NewsFeedData n, int value) {
                        if (status) {
                          descriptionController.clear();
                          postProvider.clearImageVideo();
                          newsfeedProvider.addPostOnTimeLine(n);
                          newsfeedProvider.addedDataOnLists();
                        }
                      },
                    );
                  }

                  Navigator.of(context).pop([true]);
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
              )
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
                      CircleAvatar(backgroundImage: NetworkImage(profileImage), backgroundColor: Colors.grey.withOpacity(.4)),
                      Expanded(
                          child: CustomTextField(
                        hintText: 'Write Somethings',
                        //autoFocus: true,
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
