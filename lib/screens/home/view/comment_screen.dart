// ignore_for_file: unnecessary_null_comparison

import 'package:als_frontend/provider/auth_provider.dart';
import 'package:als_frontend/provider/comment_provider.dart';
import 'package:als_frontend/provider/group_provider.dart';
import 'package:als_frontend/provider/newsfeed_provider.dart';
import 'package:als_frontend/provider/profile_provider.dart';
import 'package:als_frontend/screens/home/view/comment_widget.dart';
import 'package:als_frontend/translations/locale_keys.g.dart';
import 'package:als_frontend/util/helper.dart';
import 'package:als_frontend/util/palette.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/custom_text_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class CommentsScreen extends StatefulWidget {
  final int index;
  final String url;
  final int postID;
  final int groupID;
  final bool isHomeScreen;
  final bool isProfileScreen;
  final bool isGroupScreen;

  const CommentsScreen(
      {this.index = 0,
      this.url = '',
      this.isHomeScreen = false,
      this.postID = 0,
      this.isProfileScreen = false,
      this.isGroupScreen = false,
      this.groupID = 0,
      Key? key})
      : super(key: key);

  @override
  State<CommentsScreen> createState() => _CommentsScreenState();
}

class _CommentsScreenState extends State<CommentsScreen> {
  @override
  void initState() {
    if (widget.isGroupScreen) {
      // Provider.of<CommentProvider>(context, listen: false).initializeGroupCommentData(widget.postID, widget.groupID);

    } else {
      Provider.of<CommentProvider>(context, listen: false).initializeCommentData(widget.url);
    }
    Provider.of<CommentProvider>(context, listen: false).initializeSinglePostSocket(widget.url);
    Provider.of<AuthProvider>(context, listen: false).getUserInfo();

    super.initState();
  }

  TextEditingController commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // Provider.of<TimelinePostCommentProvider>(context, listen: false).userPostComments();
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () {
        Provider.of<CommentProvider>(context, listen: false).channelDismiss();
        Helper.back();

        return Future.value(true);
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Palette.scaffold,
          centerTitle: true,
          elevation: 0,
          leading: IconButton(
            onPressed: () {
              Provider.of<CommentProvider>(context, listen: false).channelDismiss();
              Helper.back();
            },
            icon: const Icon(FontAwesomeIcons.arrowLeft, color: Palette.primary),
          ),
        ),
        backgroundColor: Palette.scaffold,
        body: Consumer2<CommentProvider, AuthProvider>(
            builder: (context, commentProvider, authProvider, child) => GestureDetector(
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  child: commentProvider.isLoading
                      ? const Center(child: CircularProgressIndicator())
                      : Column(
                          children: [
                            Expanded(
                              child: Align(
                                alignment: Alignment.topCenter,
                                child: commentProvider.comments.isEmpty
                                    ? Center(child: Text(LocaleKeys.no_Comment_Found.tr(),style: latoStyle800ExtraBold.copyWith()))
                                    : ListView.builder(
                                        itemCount: commentProvider.comments.length,
                                        itemBuilder: (context, index) {
                                          return CommentWidget(
                                              width: width,
                                              height: height,
                                              postIndex: widget.index,
                                              onTap: () {},
                                              commentModels: commentProvider.comments[index],
                                              index: index,
                                              url: widget.url,
                                              postID: 171);
                                        }),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 3, left: 10, right: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: Align(
                                      alignment: Alignment.bottomLeft,
                                      child: CustomTextField(
                                          controller: commentController, borderRadius: 5, fillColor: Colors.white, verticalSize: 16),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 50,
                                    child: ElevatedButton(
                                        style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Palette.primary)),
                                        onPressed: () {
                                          commentProvider
                                              .addComment(commentController.text, authProvider.name, authProvider.profileImage,
                                                  widget.postID, int.parse(authProvider.userID), widget.url)
                                              .then((value) {
                                            if (value == true) {
                                              if (widget.isHomeScreen) {
                                                Provider.of<NewsFeedProvider>(context, listen: false).updateCommentDataCount(widget.index);
                                              } else if (widget.isProfileScreen) {
                                                Provider.of<ProfileProvider>(context, listen: false).updateCommentDataCount(widget.index);
                                              } else if (widget.isGroupScreen) {
                                                Provider.of<GroupProvider>(context, listen: false).updateCommentDataCount(widget.index);
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
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                )),
      ),
    );
  }

  Padding buildPadding(double width, double height) {
    return Padding(
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
            decoration:  InputDecoration.collapsed(hintText: LocaleKeys.comment_here.tr()),
          ),
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
