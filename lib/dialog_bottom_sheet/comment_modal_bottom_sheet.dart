import 'package:als_frontend/data/model/response/news_feed_model.dart';
import 'package:als_frontend/provider/comment_provider.dart';
import 'package:als_frontend/provider/newsfeed_provider.dart';
import 'package:als_frontend/translations/locale_keys.g.dart';
import 'package:als_frontend/util/helper.dart';
import 'package:als_frontend/util/palette.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

bool commentModalBottomSheet(NewsFeedModel newsfeedData, {bool isFromImage = false, bool isFromPage = false, int index = 0}) {

  final TextEditingController commentController = TextEditingController();
  final TextEditingController replyController = TextEditingController();
  double height = MediaQuery.of(Helper.navigatorKey.currentState!.context).size.height;
  double width = MediaQuery.of(Helper.navigatorKey.currentState!.context).size.width;
  showModalBottomSheet<void>(
    enableDrag: true,
    isScrollControlled: true,
    context: Helper.navigatorKey.currentState!.context,
    builder: (BuildContext context) {
      return Card(
        color: Colors.white,
        child: Consumer2<CommentProvider,NewsFeedProvider>(
          builder: (context, commentProvider,newsFeedProvider, child) => SizedBox(
            height: MediaQuery.of(context).size.height * 0.95 + MediaQuery.of(context).viewInsets.bottom,
            child: Column(
              children: [
                Expanded(
                  child: Align(
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
                          return Container(

                          );
                        }),
                  ),
                ),
                Container(
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
                              child: CustomText(title: LocaleKeys.cancel.tr(), color: Colors.grey, fontWeight: FontWeight.w700)),
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
                                // if (commentProvider.isShowCancelButton) {
                                //   FocusScope.of(context).unfocus();
                                //   commentProvider.addReply(commentController.text, widget.id).then((value) {
                                //     if (value) {
                                //       commentController.clear();
                                //       Provider.of<NewsFeedProvider>(context, listen: false).updateSingleCommentDataCount();
                                //       if (widget.isHomeScreen) {
                                //         Provider.of<NewsFeedProvider>(context, listen: false).updateCommentDataCount(widget.index);
                                //       } else if (widget.isProfileScreen) {
                                //         Provider.of<ProfileProvider>(context, listen: false).updateCommentDataCount(widget.index);
                                //       } else if (widget.isFromGroup) {
                                //         Provider.of<GroupProvider>(context, listen: false).updateCommentDataCount(widget.index);
                                //       } else if (widget.isFromPage) {
                                //         Provider.of<PageProvider>(context, listen: false).updateCommentDataCount(widget.index);
                                //       }
                                //     }
                                //   });
                                // } else {
                                //   commentProvider
                                //       .addComment(commentController.text, authProvider.name, authProvider.profileImage,
                                //       newsFeedProvider.singleNewsFeedModel.id! as int, int.parse(authProvider.userID), widget.id)
                                //       .then((value) {
                                //     if (value == true) {
                                //       newsFeedProvider.updateSingleCommentDataCount();
                                //       if (widget.isHomeScreen) {
                                //         Provider.of<NewsFeedProvider>(context, listen: false).updateCommentDataCount(widget.index);
                                //       } else if (widget.isProfileScreen) {
                                //         Provider.of<ProfileProvider>(context, listen: false).updateCommentDataCount(widget.index);
                                //       } else if (widget.isFromGroup) {
                                //         Provider.of<GroupProvider>(context, listen: false).updateCommentDataCount(widget.index);
                                //       } else if (widget.isFromPage) {
                                //         Provider.of<PageProvider>(context, listen: false).updateCommentDataCount(widget.index);
                                //       }
                                //     }
                                //   });
                                // }

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
                )
              ],
            ),
          ),
        ),
      );
    },
  );
  return true;
}
