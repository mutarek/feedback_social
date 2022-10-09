import 'package:als_frontend/old_code/model/post/news_feed_model.dart';
import 'package:als_frontend/provider/newsfeed_provider.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class PostStats extends StatelessWidget {
  final NewsFeedData post;

  const PostStats({required this.post});

  @override
  Widget build(BuildContext context) {
    return Consumer<NewsFeedProvider>(
      builder: (context, state,child) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            children: [
              const SizedBox(height: 6.0),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(4.0),
                    decoration: const BoxDecoration(
                      color: colorPrimaryDark,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.thumb_up_alt,
                      size: 10.0,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 4.0),
                  Expanded(
                    child: Text(
                      '${post.totalLike}',
                      style: TextStyle(
                        color: Colors.grey[600],
                      ),
                    ),
                  ),
                  Text(
                    '${post.totalComment} Comments',
                    style: TextStyle(
                      color: Colors.grey[600],
                    ),
                  ),
                  const SizedBox(width: 8.0),
                  // Text(
                  //   'Share',
                  //   style: TextStyle(
                  //     color: Colors.grey[600],
                  //   ),
                  // )
                ],
              ),
              const Divider(),
              Row(
                children: [
                  _PostButton(
                    icon: const Icon(
                      MdiIcons.thumbUp,
                      color: AppColors.primaryColorDark,
                      size: 20.0,
                    ),
                    label: 'Like',
                    lableColor:  Colors.black,
                    onTap: () {
                      print('Like');
                    },
                  ),
                  _PostButton(
                    icon: Icon(
                      MdiIcons.commentOutline,
                      color: Colors.grey[600],
                      size: 20.0,
                    ),
                    label: 'Comment',
                    onTap: () {
                      _commentBox(context);
                      print('Comment');
                    },
                  ),
                  _PostButton(
                    icon: Icon(
                      MdiIcons.shareOutline,
                      color: Colors.grey[600],
                      size: 25.0,
                    ),
                    label: 'Share',
                    onTap: () => print('Share'),
                  )
                ],
              )
            ],
          ),
        );
      },
    );
  }

  void _commentBox(BuildContext context) {
    bool notDesktop = true;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          insetAnimationCurve: Curves.easeInOut,
          insetAnimationDuration: const Duration(milliseconds: 200),
          child: Container(
              height: notDesktop ? MediaQuery.of(context).size.height * 0.98 : MediaQuery.of(context).size.height * 0.45,
              width: notDesktop ? MediaQuery.of(context).size.width * 0.98 : MediaQuery.of(context).size.width * 0.45,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  children: [
                    const Spacer(),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'Write your comment ...',
                        suffixIcon: IconButton(
                          icon: const Icon(Icons.send),
                          onPressed: () {},
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: const BorderSide(
                            color: Colors.blue,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20.0),
                          borderSide: const BorderSide(
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )),
        );
      },
    );
  }
}
class _PostButton extends StatelessWidget {
  final Icon icon;
  final String label;
  final Function onTap;
  final Color lableColor;

  const _PostButton({
    Key? key,
    required this.icon,
    required this.label,
    required this.onTap,
    this.lableColor = Colors.black,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: Colors.white,
        child: InkWell(
          onTap: onTap as void Function()?,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            height: 25.0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon,
                const SizedBox(width: 4.0),
                Text(
                  label,
                  style: TextStyle(color: lableColor),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
