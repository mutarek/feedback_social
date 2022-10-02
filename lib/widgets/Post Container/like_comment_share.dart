import 'package:als_frontend/provider/profile/user%20profile/user_newsfeed_post_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class LikeCommentShare extends StatelessWidget {
  final VoidCallback? like;
  final VoidCallback? comment;
  final VoidCallback? share;
  final Color fontColor;
  final Color iconColor;
  final Color likeIconColor;
  final String likeText;
  final int index;

  const LikeCommentShare(
      {required this.likeText,
      required this.like,
      required this.comment,
      required this.share,
      this.fontColor = Colors.black,
      this.iconColor = Colors.black,
      required this.likeIconColor,
      required this.index,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Consumer<UserNewsfeedPostProvider>(builder: (context,newsfeedProvider,child)=>SizedBox(
      height: height * 0.05,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(width: width * 0.01),
          TextButton(onPressed: like, child: Icon(FontAwesomeIcons.heart, color: likeIconColor)),
          SizedBox(width: width * 0.01),
          TextButton(onPressed: comment, child: const Icon(FontAwesomeIcons.comment, color: Colors.black87)),
          SizedBox(
            width: width * 0.01,
          ),
          InkWell(
              onTap: share,
              child: Icon(
                FontAwesomeIcons.paperPlane,
                color: iconColor,
              )),
        ],
      ),
    ));
  }
}
