import 'package:als_frontend/data/model/response/CommentModels.dart';
import 'package:als_frontend/helper/number_helper.dart';
import 'package:als_frontend/old_code/const/palette.dart';
import 'package:als_frontend/provider/comment_provider.dart';
import 'package:als_frontend/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class CommentWidget extends StatelessWidget {
  CommentWidget(
      {Key? key,
      required this.width,
      required this.height,
      required this.commentModels,
      required this.onTap,
      required this.index,
      required this.url,
      required this.postID,
      this.replyController})
      : super(key: key);

  final double width;
  final double height;
  final CommentModels commentModels;
  final int index;
  final int postID;
  final String url;
  final VoidCallback onTap;
  final TextEditingController? replyController;

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
                    InkWell(onTap: onTap, child: CircleAvatar(backgroundImage: NetworkImage(commentModels.author!.profileImage!))),
                    const SizedBox(width: 10),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          replyController!.clear();
                          commentProvider.changeExpandedForOpen(index, postID, commentModels.id as int);
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(commentModels.author!.fullName!, style: GoogleFonts.lato(fontSize: 14, fontWeight: FontWeight.w500)),
                            Text(commentModels.comment!, style: GoogleFonts.lato())
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Text(getDate(commentModels.timestamp!, context), style: GoogleFonts.lato(fontSize: 11, fontWeight: FontWeight.w500))
                  ],
                ),
                const Divider(),
                commentProvider.isOpenComment[index]
                    ? Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        margin: EdgeInsets.only(bottom: 10),
                        decoration: BoxDecoration(color: Colors.grey.withOpacity(.1), borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [
                            SizedBox(height: 5),
                            CustomTextField(
                              hintText: 'Reply',
                              fillColor: Colors.white,
                              borderRadius: 10,
                              controller: replyController,
                              isShowSuffixWidget: true,
                              inputAction: TextInputAction.done,
                              suffixWidget: commentProvider.isReplyButtonLoading
                                  ? Container(height: 40, width: 40, child: Center(child: CircularProgressIndicator()))
                                  : IconButton(
                                      onPressed: () {
                                        FocusScope.of(context).unfocus();
                                        commentProvider.addReply(replyController!.text, url, index).then((value) {
                                          if (value) {
                                            replyController!.clear();
                                          }
                                        });
                                      },
                                      icon: const Icon(FontAwesomeIcons.paperPlane, color: Palette.primary)),
                            ),
                            ListView.builder(
                                itemCount: commentProvider.comments[index].replies!.length,
                                shrinkWrap: true,
                                padding: const EdgeInsets.symmetric(vertical: 13),
                                physics: const NeverScrollableScrollPhysics(),
                                itemBuilder: (context, i) {
                                  return Column(
                                    children: [
                                      Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          InkWell(
                                              onTap: onTap,
                                              child: CircleAvatar(
                                                  backgroundImage:
                                                      NetworkImage(commentProvider.comments[index].replies![i].author!.profileImage!))),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(commentProvider.comments[index].replies![i].author!.fullName!,
                                                    style: GoogleFonts.lato(fontSize: 14, fontWeight: FontWeight.w500)),
                                                Text(commentProvider.comments[index].replies![i].comment!, style: GoogleFonts.lato())
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                      Divider(color: Colors.white)
                                    ],
                                  );
                                }),
                          ],
                        ),
                      )
                    : const SizedBox()
              ],
            ));
  }
}
