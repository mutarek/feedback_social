// ignore_for_file: unnecessary_null_comparison

import 'package:als_frontend/old_code/const/palette.dart';
import 'package:als_frontend/old_code/provider/provider.dart';
import 'package:als_frontend/old_code/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

class UserPostCommentsScreen extends StatefulWidget {
  //final WebSocketChannel channel = IOWebSocketChannel.connect('wss://als-social.com/ws/post/10/comment/timeline_post/');
  final int index;
  final int postID;
  final bool isHomeScreen;
  final bool isPublicScreen;

  UserPostCommentsScreen(this.index, this.postID, {this.isHomeScreen = false,this.isPublicScreen = false, Key? key}) : super(key: key);

  @override
  State<UserPostCommentsScreen> createState() => _UserPostCommentsScreenState();
}

class _UserPostCommentsScreenState extends State<UserPostCommentsScreen> {
  @override
  void initState() {
    Provider.of<TimelinePostCommentProvider>(context, listen: false).getData(widget.postID);
    Provider.of<TimelinePostCommentProvider>(context, listen: false).initializeSocket(widget.postID);

    super.initState();
    //streamListener();
  }

  TextEditingController commentController = TextEditingController();

  Future<void> _refresh() async {}


  @override
  Widget build(BuildContext context) {
    // Provider.of<TimelinePostCommentProvider>(context, listen: false).userPostComments();
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: (){
        Provider.of<TimelinePostCommentProvider>(context, listen: false).channelDismiss();
        Get.back();
        return Future.value(true);
      },
      child: SafeArea(
        child: Scaffold(
          // bottomNavigationBar: Container(
          //   height: 70,
          //   child: Row(
          //
          //   ),
          // ),
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Palette.scaffold,
            centerTitle: true,
            elevation: 0,
            leading: IconButton(
              onPressed: () {
                Provider.of<TimelinePostCommentProvider>(context, listen: false).channelDismiss();
                Get.back();
              },
              icon: const Icon(FontAwesomeIcons.arrowLeft, color: Palette.primary),
            ),
          ),
          backgroundColor: Palette.scaffold,
          body: Consumer<TimelinePostCommentProvider>(
              builder: (context, timelineProvider, child) => RefreshIndicator(
                    onRefresh: _refresh,
                    child: GestureDetector(
                      onTap: () {
                        FocusScope.of(context).requestFocus(FocusNode());
                      },
                      child: Column(
                        children: [
                          Expanded(
                            child: Align(
                              alignment: Alignment.topCenter,
                              child: Consumer3<UserNewsfeedPostProvider, ProfileDetailsProvider, TimelinePostCommentProvider>(
                                  builder: (context, provider, provider2, timelinePostCommentProvider, child) {
                                return ListView.builder(
                                    itemCount: timelinePostCommentProvider.comments.length,
                                    itemBuilder: (context, index) {
                                      return CommentWidget(
                                        width: width,
                                        height: height,
                                        onTap: () {},
                                        image: timelinePostCommentProvider.comments[index].author!.profileImage!,
                                        name: timelinePostCommentProvider.comments[index].author!.fullName!,
                                        comment: timelinePostCommentProvider.comments[index].comment!,
                                      );
                                    });
                              }),
                            ),
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: Align(
                                  alignment: Alignment.bottomLeft,
                                  child: Padding(
                                    padding: EdgeInsets.only(left: width * 0.03, bottom: height * 0.02),
                                    child: Container(
                                      height: height * 0.08,
                                      width: width * 0.795,
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
                                      child: Padding(
                                        padding: EdgeInsets.only(top: height * 0.01, left: width * 0.02),
                                        child: TextField(
                                          textAlign: TextAlign.start,
                                          controller: commentController,
                                          decoration: const InputDecoration.collapsed(hintText: "Comment here.."),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: Consumer2<TimelinePostCommentProvider, UserProfileProvider>(
                                    builder: (context, provider, userProfileProvider, child) {
                                  return Padding(
                                    padding: EdgeInsets.only(bottom: height * 0.02),
                                    child: SizedBox(
                                      height: height * 0.079,
                                      child: ElevatedButton(
                                          style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Palette.primary)),
                                          onPressed: () {
                                            provider
                                                .addComment(
                                                    commentController.text,
                                                    "${userProfileProvider.userprofileData.firstName!} ${userProfileProvider.userprofileData.lastName!}",
                                                    userProfileProvider.userprofileData.profileImage!,
                                                    widget.postID,
                                                    userProfileProvider.userprofileData.id!)
                                                .then((value) {
                                              if (value == true) {
                                                if (widget.isHomeScreen) {
                                                  Provider.of<NewsFeedPostProvider>(context, listen: false)
                                                      .updateCommentDataCount(widget.index);
                                                }else if (widget.isPublicScreen) {
                                                  Provider.of<GroupDetailsProvider>(context, listen: false)
                                                      .updateCommentDataCount(widget.index);
                                                } else {
                                                  Provider.of<UserNewsfeedPostProvider>(context, listen: false)
                                                      .updateCommentDataCount(widget.index);
                                                }
                                              }
                                            });

                                            // timelineProvider.channel.sink.add(
                                            //   jsonEncode({
                                            //     "data": {
                                            //       "comment": commentController.text,
                                            //       "full_name":
                                            //           "${userProfileProvider.userprofileData.firstName!} ${userProfileProvider.userprofileData.lastName!}",
                                            //       "profile_image": userProfileProvider.userprofileData.profileImage!
                                            //     }
                                            //   }),
                                            // );
                                            // timelineProvider.userPostComments();
                                            commentController.text = "";
                                            // timelineProvider.channelDismiss();
                                            FocusScope.of(context).unfocus();
                                          },
                                          child: const Icon(FontAwesomeIcons.paperPlane)),
                                    ),
                                  );
                                }),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  )),
        ),
      ),
    );
  }

  @override
  void dispose() {
    commentController.dispose();
    // Provider.of<TimelinePostCommentProvider>(context, listen: false).channelDismiss();
    super.dispose();
  }
}
