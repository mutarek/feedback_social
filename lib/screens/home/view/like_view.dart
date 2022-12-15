import 'package:als_frontend/data/model/response/liked_by_model.dart';
import 'package:als_frontend/data/model/response/news_feed_model.dart';
import 'package:als_frontend/provider/auth_provider.dart';
import 'package:als_frontend/provider/newsfeed_provider.dart';
import 'package:als_frontend/screens/home/widget/profile_avatar.dart';
import 'package:als_frontend/screens/profile/profile_screen.dart';
import 'package:als_frontend/screens/profile/public_profile_screen.dart';
import 'package:als_frontend/translations/locale_keys.g.dart';
import 'package:als_frontend/util/size.util.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/custom_text.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

void likeModalBottomView(BuildContext context, NewsFeedModel post, bool isLike) {
  Provider.of<NewsFeedProvider>(context, listen: false).initializeLikedShareByAllUser(isLike ? post.likedByUrl! : post.sharedByUrl!);
  showModalBottomSheet(
      context: context,
      isDismissible: true,
      isScrollControlled: true,
      constraints: const BoxConstraints(),
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            return SizedBox(
              height: getAppSizeHeight(context) * 0.7,
              width: getAppSizeWidth(context),
              child: Consumer<NewsFeedProvider>(
                builder: (context, newsFeedProvider, child) => newsFeedProvider.isLoadingLiked
                    ? const Center(child: CircularProgressIndicator())
                    : Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
                        child: Column(
                          children: [
                            isLike
                                ? Row(
                                    children: [
                                      Stack(
                                        clipBehavior: Clip.none,
                                        children: const [
                                          SizedBox(width: 45),
                                          Icon(FontAwesomeIcons.solidHeart, size: 20, color: kPrimaryColor),
                                          Positioned(
                                              left: 21, top: -2, child: Icon(FontAwesomeIcons.thumbsUp, size: 20, color: kPrimaryColor)),
                                        ],
                                      ),
                                      CustomText(
                                          title:
                                              ' ${post.totalLiked.toString()} ${post.totalLiked == 0 || post.totalLiked == 1 ? "Like" : "Likes"}',
                                          fontSize: 14,
                                          color: kPrimaryColor.withOpacity(.8)),
                                    ],
                                  )
                                : Row(
                                    children: [
                                      Stack(
                                        clipBehavior: Clip.none,
                                        children: const [
                                          SizedBox(width: 25),
                                          Icon(FontAwesomeIcons.share, size: 20, color: kPrimaryColor)
                                        ],
                                      ),
                                      CustomText(
                                          title:
                                              ' ${post.totalShared.toString()} ${post.totalShared == 0 || post.totalShared == 1 ? "Share" : "Shares"}',
                                          fontSize: 14,
                                          color: kPrimaryColor.withOpacity(.8)),
                                    ],
                                  ),
                            Container(
                              color: Colors.grey.withOpacity(.3),
                              height: 1,
                              margin: const EdgeInsets.only(top: 10, bottom: 5),
                            ),
                            Expanded(
                              child: ListView.builder(
                                  itemCount: newsFeedProvider.likedShareByModels.length,
                                  physics: const BouncingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    LikedByModel likedBy = newsFeedProvider.likedShareByModels[index];
                                    bool isMe = Provider.of<AuthProvider>(context, listen: false).userID == likedBy.id.toString();
                                    return Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                      margin: const EdgeInsets.only(bottom: 10),
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(10),
                                          boxShadow: const [
                                            BoxShadow(color: colorShadow, blurRadius: 10.0, spreadRadius: 3.0, offset: Offset(0.0, 0.0))
                                          ]),
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.of(context).pop();
                                                if (isMe) {
                                                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ProfileScreen()));
                                                } else {
                                                  Navigator.of(context).push(MaterialPageRoute(
                                                      builder: (_) => PublicProfileScreen(likedBy.id.toString(),
                                                          index: index, isFromFriendScreen: true)));
                                                }
                                              },
                                              child: Row(
                                                children: [
                                                  ProfileAvatar(profileImageUrl: likedBy.profileImage!),
                                                  const SizedBox(width: 8.0),
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text('${isMe ? LocaleKeys.you.tr() : likedBy.fullName}',
                                                            style: latoStyle600SemiBold.copyWith(fontSize: 12)),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }),
                            ),
                          ],
                        ),
                      ),
              ),
            );
          },
        );
      });
}
