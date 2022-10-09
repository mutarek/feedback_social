import 'package:als_frontend/old_code/model/post/news_feed_model.dart';
import 'package:als_frontend/provider/newsfeed_provider.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class PostStats extends StatelessWidget {
  final NewsFeedData post;
  final int index;
  final NewsFeedProvider newsFeedProvider;

  const PostStats({Key? key, required this.post, required this.index, required this.newsFeedProvider}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<NewsFeedProvider>(
      builder: (context, state, child) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Column(
            children: [
              const SizedBox(height: 6.0),
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(4.0),
                    decoration: const BoxDecoration(color: Colors.grey, shape: BoxShape.circle),
                    child: const Icon(Icons.thumb_up_alt, size: 10.0, color: Colors.white),
                  ),
                  const SizedBox(width: 4.0),
                  Expanded(child: Text('${post.totalLike}', style: latoStyle500Medium.copyWith(color: Colors.grey[600]))),
                  Text('${post.totalComment} Comments', style: latoStyle500Medium.copyWith(color: Colors.grey[600], fontSize: 12)),
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
                    icon: Icon(
                      MdiIcons.thumbUp,
                      color: (newsFeedProvider.likesStatusAllData[index] == 1) ? colorPrimaryDark : Colors.grey,
                      size: 20.0,
                    ),
                    label: 'Like',
                    lableColor: Colors.black,
                    onTap: () {
                      newsFeedProvider.addLike(post.id!.toInt(), index);
                      // print('Like');
                    },
                  ),
                  _PostButton(
                    icon: Icon(MdiIcons.commentOutline, color: Colors.grey[600], size: 20.0),
                    label: 'Comment',
                    onTap: () {
                      print('Comment');
                    },
                  ),
                  post.isShare!
                      ? _PostButton(
                          icon: Icon(MdiIcons.shareOutline, color: Colors.grey[600], size: 25.0),
                          label: 'Share',
                          onTap: () => print('Share'),
                        )
                      : const SizedBox.shrink()
                ],
              )
            ],
          ),
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
