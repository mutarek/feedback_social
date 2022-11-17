import 'package:als_frontend/data/model/response/news_feed_model.dart';
import 'package:als_frontend/localization/language_constrants.dart';
import 'package:als_frontend/provider/auth_provider.dart';
import 'package:als_frontend/screens/home/widget/profile_avatar.dart';
import 'package:als_frontend/screens/profile/profile_screen.dart';
import 'package:als_frontend/screens/profile/public_profile_screen.dart';
import 'package:als_frontend/util/size.util.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

void likeModalBottomView(BuildContext context, NewsFeedData post) {
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
              child: Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Stack(
                          clipBehavior: Clip.none,
                          children: const [
                            SizedBox(width: 45),
                            Icon(FontAwesomeIcons.solidHeart, size: 20, color: kPrimaryColor),
                            Positioned(left: 21, top: -2, child: Icon(FontAwesomeIcons.thumbsUp, size: 20, color: kPrimaryColor)),
                          ],
                        ),
                        CustomText(
                            title: ' ${post.totalLike.toString()} ${post.totalLike == 0 || post.totalLike == 1 ? "Like" : "Likes"}',
                            fontSize: 14,
                            color: kPrimaryColor.withOpacity(.8)),
                      ],
                    ),
                    Container(
                      color: Colors.grey.withOpacity(.3),
                      height: 1,
                      margin: EdgeInsets.only(top: 10, bottom: 5),
                    ),
                    Expanded(
                      child: ListView.builder(
                          itemCount: post.likedBy!.length,
                          physics: const BouncingScrollPhysics(),
                          itemBuilder: (context, index) {
                            LikedBy likedBy = post.likedBy![index];
                            bool isMe = Provider.of<AuthProvider>(context, listen: false).userID == likedBy.id.toString();
                            return Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                              margin: const EdgeInsets.only(bottom: 10),
                              decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), boxShadow: const [
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
                                              builder: (_) =>
                                                  PublicProfileScreen(likedBy.id.toString(), index: index, isFromFriendScreen: true)));
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
                                                Text('${isMe ? getTranslated('You',context) : likedBy.name}', style: latoStyle600SemiBold.copyWith(fontSize: 12)),
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
            );
          },
        );
      });
}
