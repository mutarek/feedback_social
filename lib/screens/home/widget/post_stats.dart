import 'package:als_frontend/data/model/response/news_feed_model.dart';
import 'package:als_frontend/provider/newsfeed_provider.dart';
import 'package:als_frontend/provider/profile_provider.dart';
import 'package:als_frontend/screens/home/view/comment_screen.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:provider/provider.dart';

class PostStats extends StatelessWidget {
  final NewsFeedData post;
  final int index;
  final feedProvider;
  final double paddingHorizontal;
  final double paddingVertical;
  final bool isHomeNewsFeedProvider;
  final bool isFromProfile;

  const PostStats(
      {Key? key,
      required this.post,
      required this.index,
      this.feedProvider,
      this.paddingHorizontal = 12,
      this.isFromProfile = false,
      this.isHomeNewsFeedProvider = false,
      this.paddingVertical = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<NewsFeedProvider>(
      builder: (context, state, child) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: paddingHorizontal),
          child: Column(
            children: [
              const SizedBox(height: 10.0),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            feedProvider.addLike(post.id!.toInt(), index);
                          },
                          child: SizedBox(
                            width: 40,
                            height: 40,
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Icon((feedProvider.likesStatusAllData[index] == 1) ? Icons.favorite : Icons.favorite_border,
                                    size: 30, color: (feedProvider.likesStatusAllData[index] == 1) ? Colors.red : Colors.black),
                                Positioned(
                                    top: -13,
                                    left: 20,
                                    child: post.totalLike == 0
                                        ? SizedBox.shrink()
                                        : Container(
                                            padding: EdgeInsets.all(7),
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.blue,
                                                border: Border.all(color: Colors.white),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.grey.withOpacity(.2),
                                                      blurRadius: 10.0,
                                                      spreadRadius: 3.0,
                                                      offset: Offset(0.0, 0.0))
                                                ]),
                                            child: CustomText(title: post.totalLike.toString(), fontSize: 10),
                                          ))
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 30.0),
                        InkWell(
                          onTap: () {
                            Get.to(CommentsScreen(index, post.id as int,
                                isHomeScreen: isHomeNewsFeedProvider, isProfileScreen: isFromProfile));
                          },
                          child: SizedBox(
                            width: 40,
                            height: 40,
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                Icon(CupertinoIcons.chat_bubble, size: 30, color: Colors.black),
                                Positioned(
                                    top: -13,
                                    left: 20,
                                    child: post.totalComment == 0
                                        ? SizedBox.shrink()
                                        : Container(
                                            padding: EdgeInsets.all(7),
                                            decoration: BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: Colors.blue,
                                                border: Border.all(color: Colors.white),
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.grey.withOpacity(.2),
                                                      blurRadius: 10.0,
                                                      spreadRadius: 3.0,
                                                      offset: Offset(0.0, 0.0))
                                                ]),
                                            child: CustomText(title: post.totalComment.toString(), fontSize: 10),
                                          ))
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(width: 1.0),
                        post.isShare!
                            ? InkWell(
                                onTap: () {
                                  //Get.to(CommentsScreen(index, post.id as int, isHomeScreen: true));
                                },
                                child: SizedBox(
                                  width: 35,
                                  height: 35,
                                  child: Icon(CupertinoIcons.paperplane, size: 30, color: Colors.black),
                                ),
                              )
                            : SizedBox.shrink()
                      ],
                    ),
                  ),
                  InkWell(onTap: () {}, child: Icon(CupertinoIcons.bookmark, size: 25, color: Colors.black)),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
