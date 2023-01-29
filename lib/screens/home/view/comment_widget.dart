import 'package:als_frontend/data/model/response/comment_models.dart';
import 'package:als_frontend/helper/number_helper.dart';
import 'package:als_frontend/helper/open_call_url_map_sms_helper.dart';
import 'package:als_frontend/helper/url_checkig_helper.dart';
import 'package:als_frontend/provider/auth_provider.dart';
import 'package:als_frontend/provider/comment_provider.dart';
import 'package:als_frontend/screens/page/widget/popup_menu_widget.dart';
import 'package:als_frontend/screens/profile/profile_screen.dart';
import 'package:als_frontend/screens/profile/public_profile_screen.dart';
import 'package:als_frontend/util/helper.dart';
import 'package:als_frontend/util/image.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/any_link_preview_global_widget.dart';
import 'package:als_frontend/widgets/custom_text.dart';
import 'package:als_frontend/widgets/network_image.dart';
import 'package:als_frontend/widgets/snackbar_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_svg/flutter_svg.dart';
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
      this.callBack,
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
  final Function? callBack;

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
                        if (Provider.of<AuthProvider>(context, listen: false).userID == commentModels.author!.id.toString()) {
                          Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ProfileScreen()));
                        } else {
                          Navigator.of(context)
                              .push(MaterialPageRoute(builder: (_) => PublicProfileScreen(commentModels.author!.id.toString())));
                        }
                      },
                      child: Container(
                          decoration: BoxDecoration(border: Border.all(color: colorText), shape: BoxShape.circle),
                          child: circularImage(commentModels.author!.profileImage!, 40, 40)),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                            decoration: const BoxDecoration(
                                color: textFieldFillColor,
                                borderRadius: BorderRadius.only(bottomRight: Radius.circular(8), bottomLeft: Radius.circular(8))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                        child: CustomText(
                                            title: commentModels.author!.fullName!,
                                            textStyle: robotoStyle500Medium.copyWith(fontSize: 15))),
                                    PopupMenuButton(
                                      itemBuilder: (context) => [
                                        // PopupMenuItem 1
                                        PopupMenuItem(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              !isMe(commentModels.author!.id.toString())
                                                  ? const SizedBox.shrink()
                                                  : PopUpMenuWidget(ImagesModel.shareTimelinesIcons, 'Edit', () {
                                                      callBack!(commentModels.comment!);
                                                      commentProvider.changeUpdateButtonStatus(
                                                          true, commentModels.id as int, index, 0, false);
                                                      Navigator.of(context).pop();
                                                    }, size: 18),
                                              SizedBox(height: !isMe(commentModels.author!.id.toString()) ? 0 : 18),
                                              !isMe(commentModels.author!.id.toString())
                                                  ? const SizedBox.shrink()
                                                  : PopUpMenuWidget(ImagesModel.shareMessageIcons, 'Delete', () {
                                                      commentProvider.deleteComment(url, commentModels.id.toString(), index, 0, false);
                                                      Navigator.of(context).pop();
                                                    }, size: 18),
                                              SizedBox(height: !isMe(commentModels.author!.id.toString()) ? 0 : 18),
                                              PopUpMenuWidget(ImagesModel.copyIcons, 'Copy', () {
                                                showMessage(message: "Copy Successfully", isError: false);
                                                Clipboard.setData(ClipboardData(text: commentModels.comment));
                                                Navigator.of(context).pop();
                                              }, size: 16),
                                              const SizedBox(height: 10),
                                            ],
                                          ),
                                        ),
                                        // PopupMenuItem 2
                                      ],
                                      offset: const Offset(0, 58),
                                      color: Colors.white,
                                      elevation: 4,
                                      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                      child: Container(
                                          width: 26,
                                          height: 20,
                                          margin: const EdgeInsets.only(top: 2),
                                          alignment: Alignment.center,
                                          decoration:
                                              BoxDecoration(color: const Color(0xffE4E6EB), borderRadius: BorderRadius.circular(10)),
                                          child: const Icon(Icons.more_horiz, color: colorText, size: 19)),
                                    ),
                                  ],
                                ),
                                commentModels.comment!.contains("https")
                                    ? Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          MarkdownBody(
                                            onTapLink: (text, href, title) {
                                              href != null ? openNewLink(href) : null;
                                            },
                                            selectable: true,
                                            data: commentModels.comment!,
                                            styleSheet: MarkdownStyleSheet(
                                                a: const TextStyle(fontSize: 17), p: robotoStyle400Regular.copyWith(color: colorText)),
                                          ),
                                          const SizedBox(height: 5),
                                          AnyLinkPreviewGlobalWidget(extractdescription(commentModels.comment!), 60.0, 200.0, 3),
                                        ],
                                      )
                                    : CustomText(
                                        title: commentModels.comment!,
                                        textStyle: robotoStyle400Regular.copyWith(color: colorText, fontSize: 15)),
                              ],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  SvgPicture.asset(ImagesModel.timeIcons, width: 9, height: 12),
                                  const SizedBox(width: 3),
                                  Text(getDate(commentModels.timestamp!, context), style: robotoStyle500Medium.copyWith(fontSize: 11)),
                                ],
                              ),
                              InkWell(
                                onTap: () {
                                  commentProvider.addReplyUserNameAndIndex(commentModels.author!.fullName!, url, index);
                                  commentProvider.changeExpandedForOpen(index, postID, commentModels.id as int);
                                },
                                child: Row(
                                  children: [
                                    SvgPicture.asset(ImagesModel.replyIcons, width: 9, height: 12),
                                    const SizedBox(width: 3),
                                    Text('Replay', style: robotoStyle500Medium.copyWith(fontSize: 12)),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 10),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  margin: const EdgeInsets.only(bottom: 10, left: 45),
                  child: Column(
                    children: [
                      Visibility(
                        visible: commentProvider.comments[index].replies!.isNotEmpty,
                        child: ListView.builder(
                            itemCount: commentProvider.comments[index].replies!.length,
                            shrinkWrap: true,
                            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (context, i) {
                              return Column(
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          if (Provider.of<AuthProvider>(context, listen: false).userID ==
                                              commentProvider.comments[index].replies![i].author!.id.toString()) {
                                            Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ProfileScreen()));
                                          } else {
                                            Navigator.of(context).push(MaterialPageRoute(
                                                builder: (_) => PublicProfileScreen(
                                                    commentProvider.comments[index].replies![i].author!.id.toString())));
                                          }
                                        },
                                        child: Container(
                                            decoration: BoxDecoration(border: Border.all(color: colorText), shape: BoxShape.circle),
                                            child:
                                                circularImage(commentProvider.comments[index].replies![i].author!.profileImage!, 40, 40)),
                                      ),
                                      const SizedBox(width: 10),
                                      Expanded(
                                        child: Column(
                                          children: [
                                            Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
                                              decoration: const BoxDecoration(
                                                  color: textFieldFillColor,
                                                  borderRadius:
                                                      BorderRadius.only(bottomRight: Radius.circular(8), bottomLeft: Radius.circular(8))),
                                              child: Column(
                                                mainAxisAlignment: MainAxisAlignment.start,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Expanded(
                                                          child: CustomText(
                                                              title: commentProvider.comments[index].replies![i].author!.fullName!,
                                                              textStyle: robotoStyle500Medium.copyWith(fontSize: 15))),
                                                      PopupMenuButton(
                                                        itemBuilder: (context) => [
                                                          // PopupMenuItem 1
                                                          PopupMenuItem(
                                                            child: Column(
                                                              mainAxisAlignment: MainAxisAlignment.start,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: [
                                                                !isMe(commentProvider.comments[index].replies![i].author!.id.toString())
                                                                    ? const SizedBox.shrink()
                                                                    : PopUpMenuWidget(ImagesModel.shareTimelinesIcons, 'Edit', () {
                                                                        commentProvider.changeUpdateButtonStatus(
                                                                            true,
                                                                            commentProvider.comments[index].replies![i].id as int,
                                                                            index,
                                                                            i,
                                                                            true);
                                                                      }, size: 18),
                                                                SizedBox(
                                                                    height: !isMe(commentProvider.comments[index].replies![i].author!.id
                                                                            .toString())
                                                                        ? 0
                                                                        : 18),
                                                                !isMe(commentProvider.comments[index].replies![i].author!.id.toString())
                                                                    ? const SizedBox.shrink()
                                                                    : PopUpMenuWidget(ImagesModel.shareMessageIcons, 'Delete', () {
                                                                        commentProvider.deleteComment(
                                                                            url,
                                                                            commentProvider.comments[index].replies![i].id.toString(),
                                                                            index,
                                                                            i,
                                                                            true);
                                                                        Navigator.of(context).pop();
                                                                      }, size: 18),
                                                                SizedBox(
                                                                    height: !isMe(commentProvider.comments[index].replies![i].author!.id
                                                                            .toString())
                                                                        ? 0
                                                                        : 18),
                                                                PopUpMenuWidget(ImagesModel.copyIcons, 'Copy', () {
                                                                  showMessage(message: "Copy Successfully", isError: false);
                                                                  Clipboard.setData(ClipboardData(
                                                                      text: commentProvider.comments[index].replies![i].comment));
                                                                  Navigator.of(context).pop();
                                                                }, size: 16),
                                                                const SizedBox(height: 10),
                                                              ],
                                                            ),
                                                          ),
                                                          // PopupMenuItem 2
                                                        ],
                                                        offset: const Offset(0, 58),
                                                        color: Colors.white,
                                                        elevation: 4,
                                                        shape: const RoundedRectangleBorder(
                                                            borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                                        child: Container(
                                                            width: 26,
                                                            height: 20,
                                                            margin: const EdgeInsets.only(top: 2),
                                                            alignment: Alignment.center,
                                                            decoration: BoxDecoration(
                                                                color: const Color(0xffE4E6EB), borderRadius: BorderRadius.circular(10)),
                                                            child: const Icon(Icons.more_horiz, color: colorText, size: 19)),
                                                      ),
                                                    ],
                                                  ),
                                                  commentProvider.comments[index].replies![i].comment!.contains("https")
                                                      ? Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                          children: [
                                                            MarkdownBody(
                                                              onTapLink: (text, href, title) {
                                                                href != null ? openNewLink(href) : null;
                                                              },
                                                              selectable: true,
                                                              data: commentProvider.comments[index].replies![i].comment!,
                                                              styleSheet: MarkdownStyleSheet(
                                                                  a: const TextStyle(fontSize: 17),
                                                                  p: robotoStyle400Regular.copyWith(color: colorText)),
                                                            ),
                                                            const SizedBox(height: 5),
                                                            AnyLinkPreviewGlobalWidget(
                                                                extractdescription(commentProvider.comments[index].replies![i].comment!),
                                                                60.0,
                                                                200.0,
                                                                3),
                                                          ],
                                                        )
                                                      : CustomText(
                                                          title: commentProvider.comments[index].replies![i].comment!,
                                                          textStyle: robotoStyle400Regular.copyWith(color: colorText, fontSize: 15)),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 8),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
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
