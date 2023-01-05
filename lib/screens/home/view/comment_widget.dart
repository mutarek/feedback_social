import 'package:als_frontend/data/model/response/comment_models.dart';
import 'package:als_frontend/helper/number_helper.dart';
import 'package:als_frontend/helper/open_call_url_map_sms_helper.dart';
import 'package:als_frontend/helper/url_checkig_helper.dart';
import 'package:als_frontend/provider/auth_provider.dart';
import 'package:als_frontend/provider/comment_provider.dart';
import 'package:als_frontend/screens/profile/profile_screen.dart';
import 'package:als_frontend/screens/profile/public_profile_screen.dart';
import 'package:als_frontend/translations/locale_keys.g.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/any_link_preview_global_widget.dart';
import 'package:als_frontend/widgets/custom_button.dart';
import 'package:als_frontend/widgets/custom_text.dart';
import 'package:als_frontend/widgets/network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CommentWidget extends StatelessWidget {
  const CommentWidget(
      {Key? key,
      required this.width,
      required this.height,
      required this.commentModels,
      required this.onTap,
      required this.index,
      required this.postIndex,
      required this.url,
      required this.postID,
      this.isHomeScreen = false,
      this.isProfileScreen = false,
      this.isFromGroup = false,
      this.isFromPage = false,
      this.replyController})
      : super(key: key);

  final double width;
  final double height;
  final CommentModels commentModels;
  final int index;
  final int postIndex;
  final int postID;
  final String url;
  final VoidCallback onTap;
  final TextEditingController? replyController;
  final bool isHomeScreen;
  final bool isProfileScreen;
  final bool isFromGroup;
  final bool isFromPage;

  @override
  Widget build(BuildContext context) {
    return Consumer<CommentProvider>(
        builder: (context, commentProvider, child) => Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                        onTap: () {
                          if (Provider.of<AuthProvider>(context, listen: false)
                                  .userID ==
                              commentModels.author!.id.toString()) {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => const ProfileScreen()));
                          } else {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => PublicProfileScreen(
                                    commentModels.author!.id.toString())));
                          }
                        },
                        child:  circularImage(commentModels.author!.profileImage!,40,40),
                        // CircleAvatar(
                        //     backgroundImage: NetworkImage(
                        //         commentModels.author!.profileImage!))
                               ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText(
                              title: commentModels.author!.fullName!,
                              fontSize: 13,
                              fontWeight: FontWeight.bold),
                          commentModels.comment!.contains("https")
                              ? Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    MarkdownBody(
                                      onTapLink: (text, href, title) {
                                        href != null ? openNewLink(href) : null;
                                      },
                                      selectable: true,
                                      data: commentModels.comment!,
                                      styleSheet: MarkdownStyleSheet(
                                          a: const TextStyle(fontSize: 17),
                                          p: latoStyle500Medium),
                                    ),
                                    const SizedBox(
                                      height: 5,
                                    ),
                                    AnyLinkPreviewGlobalWidget(
                                        extractdescription(
                                            commentModels.comment!),
                                        60.0,
                                        200.0,
                                        3),
                                  ],
                                )
                              : CustomText(
                                  title: commentModels.comment!,
                                  fontSize: 17,
                                  color: Colors.black.withOpacity(.8)),
                          Container(
                              width: 65,
                              height: 25,
                              margin: const EdgeInsets.only(top: 5),
                              child: CustomButton(
                                btnTxt: LocaleKeys.reply.tr(),
                                textWhiteColor: true,
                                isStroked: true,
                                onTap: () {
                                  commentProvider.addReplyUserNameAndIndex(
                                      commentModels.author!.fullName!,
                                      url,
                                      index);
                                  commentProvider.changeExpandedForOpen(
                                      index, postID, commentModels.id as int);
                                },
                                fontSize: 12,
                                radius: 4,
                                backgroundColor: Colors.grey,
                              ))
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(getDate(commentModels.timestamp!, context),
                        style: GoogleFonts.lato(
                            fontSize: 11, fontWeight: FontWeight.w500))
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  margin: const EdgeInsets.only(bottom: 10, left: 45),
                  decoration: BoxDecoration(
                      color: Colors.grey.withOpacity(.1),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      // Visibility(
                      //   visible: commentProvider.isOpenComment[index],
                      //   child: CustomTextField(
                      //     hintText: 'Reply',
                      //     fillColor: Colors.white,
                      //     borderRadius: 10,
                      //     controller: replyController,
                      //     isShowSuffixWidget: true,
                      //     inputAction: TextInputAction.done,
                      //     suffixWidget: commentProvider.isReplyButtonLoading
                      //         ? const SizedBox(height: 40, width: 40, child: Center(child: CircularProgressIndicator()))
                      //         : IconButton(
                      //             onPressed: () {
                      //               FocusScope.of(context).unfocus();
                      //               commentProvider.addReply(replyController!.text, url).then((value) {
                      //                 if (value) {
                      //                   replyController!.clear();
                      //                   Provider.of<NewsFeedProvider>(context, listen: false).updateSingleCommentDataCount();
                      //                   if (isHomeScreen) {
                      //                     Provider.of<NewsFeedProvider>(context, listen: false).updateCommentDataCount(postIndex);
                      //                   } else if (isProfileScreen) {
                      //                     Provider.of<ProfileProvider>(context, listen: false).updateCommentDataCount(postIndex);
                      //                   } else if (isFromGroup) {
                      //                     Provider.of<GroupProvider>(context, listen: false).updateCommentDataCount(postIndex);
                      //                   } else if (isFromPage) {
                      //                     Provider.of<PageProvider>(context, listen: false).updateCommentDataCount(postIndex);
                      //                   }
                      //                 }
                      //               });
                      //             },
                      //             icon: const Icon(FontAwesomeIcons.paperPlane, color: Palette.primary)),
                      //   ),
                      // ),
                      Visibility(
                        visible:
                            commentProvider.comments[index].replies!.isNotEmpty,
                        child: ListView.builder(
                            itemCount:
                                commentProvider.comments[index].replies!.length,
                            shrinkWrap: true,
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, i) {
                              return Column(
                                children: [
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      InkWell(
                                          onTap: () {
                                            if (Provider.of<AuthProvider>(
                                                        context,
                                                        listen: false)
                                                    .userID ==
                                                commentProvider.comments[index]
                                                    .replies![i].author!.id
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
                                                              commentProvider
                                                                  .comments[
                                                                      index]
                                                                  .replies![i]
                                                                  .author!
                                                                  .id
                                                                  .toString())));
                                            }
                                          },
                                          child: CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  commentProvider
                                                      .comments[index]
                                                      .replies![i]
                                                      .author!
                                                      .profileImage!))),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                                commentProvider
                                                    .comments[index]
                                                    .replies![i]
                                                    .author!
                                                    .fullName!,
                                                style: GoogleFonts.lato(
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold)),
                                            commentProvider.comments[index]
                                                    .replies![i].comment!
                                                    .contains("http")
                                                ? Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: [
                                                      MarkdownBody(
                                                        onTapLink: (text, href,
                                                            title) {
                                                          href != null
                                                              ? openNewLink(
                                                                  href)
                                                              : null;
                                                        },
                                                        selectable: true,
                                                        data: commentProvider
                                                            .comments[index]
                                                            .replies![i]
                                                            .comment!,
                                                        styleSheet:
                                                            MarkdownStyleSheet(
                                                                a: const TextStyle(
                                                                    fontSize:
                                                                        17),
                                                                p: latoStyle500Medium),
                                                      ),
                                                      const SizedBox(
                                                        height: 5,
                                                      ),
                                                      AnyLinkPreviewGlobalWidget(
                                                          extractdescription(
                                                              commentProvider
                                                                  .comments[
                                                                      index]
                                                                  .replies![i]
                                                                  .comment!),
                                                          55.0,
                                                          200.0,
                                                          3),
                                                    ],
                                                  )
                                                : Text(
                                                    commentProvider
                                                        .comments[index]
                                                        .replies![i]
                                                        .comment!,
                                                    style: GoogleFonts.lato(
                                                        fontSize: 16)),
                                            // Text(
                                            //     commentProvider.comments[index]
                                            //         .replies![i].comment!,
                                            //     style: GoogleFonts.lato(
                                            //         fontSize: 16))
                                            commentProvider.comments[index]
                                                    .replies![i].comment!
                                                    .contains('https')
                                                ? MarkdownBody(
                                                    onTapLink:
                                                        (text, href, title) {
                                                      href != null
                                                          ? openNewLink(href)
                                                          : null;
                                                    },
                                                    selectable: true,
                                                    data: commentProvider
                                                        .comments[index]
                                                        .replies![i]
                                                        .comment!,
                                                    styleSheet: MarkdownStyleSheet(
                                                        a: const TextStyle(
                                                            fontSize: 17,
                                                            color: Colors.blue),
                                                        p: latoStyle500Medium),
                                                  )
                                                : Text(
                                                    commentProvider
                                                        .comments[index]
                                                        .replies![i]
                                                        .comment!,
                                                    style: GoogleFonts.lato(
                                                        fontSize: 16))
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                      height: 1,
                                      color: Colors.white,
                                      margin: const EdgeInsets.only(
                                          top: 5, bottom: 5))
                                ],
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              ],
            ));
  }
}
