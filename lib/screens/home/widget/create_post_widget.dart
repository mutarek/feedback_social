import 'package:als_frontend/provider/auth_provider.dart';
import 'package:als_frontend/provider/newsfeed_provider.dart';
import 'package:als_frontend/provider/post_provider.dart';
import 'package:als_frontend/screens/posts/add_post_screen.dart';
import 'package:als_frontend/screens/profile/profile_screen.dart';
import 'package:als_frontend/translations/locale_keys.g.dart';
import 'package:als_frontend/util/helper.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/custom_text.dart';
import 'package:als_frontend/widgets/network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Widget createPostWidget( {bool isForGroup = false, bool isForPage = false, int groupPageID = 0}) {
  return Consumer2<AuthProvider, NewsFeedProvider>(
      builder: (context, authProvider, newsFeedProvider, child) => InkWell(
            onTap: () async {
              Provider.of<PostProvider>(context, listen: false).clearImageVideo();
              Helper.toScreen(AddPostScreen(authProvider.profileImage,
                  isFromGroupScreen: isForGroup, groupPageID: groupPageID, isForPage: isForPage));

            },
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(color: Colors.grey.withOpacity(.1), blurRadius: 10.0, spreadRadius: 3.3, offset: const Offset(0.0, 0.0))
                ],
              ),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        InkWell(
                            onTap: () {
                              Helper.toScreen(const ProfileScreen());
                            },
                            child: circularImage(authProvider.profileImage, 30, 30)),
                        const SizedBox(width: 5),
                        CustomText(
                            title: LocaleKeys.write_Something.tr(),
                            textStyle: robotoStyle400Regular.copyWith(
                                fontWeight: FontWeight.w300, fontSize: 13, color: colorText.withOpacity(.5))),
                        const SizedBox(width: 5),
                        Icon(Icons.mode_edit_outline_outlined, size: 20, color: colorText.withOpacity(.5)),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    height: 35,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        color: colorText.withOpacity(.1),
                        borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(5), bottomRight: Radius.circular(5))),
                    child: Row(
                      children: [
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(Icons.add_photo_alternate_rounded, size: 20, color: colorText),
                                    const SizedBox(width: 5),
                                    CustomText(title: LocaleKeys.photos.tr(), textStyle: latoStyle700Bold.copyWith()),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(CupertinoIcons.videocam_fill, size: 28, color: colorText),
                                    const SizedBox(width: 5),
                                    CustomText(title: LocaleKeys.videos.tr(), textStyle: latoStyle700Bold.copyWith()),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: 50,
                          height: 50,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                              color: Colors.blue.withOpacity(.3), borderRadius: const BorderRadius.only(bottomRight: Radius.circular(10))),
                          child: const Icon(Icons.send, color: colorText),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ));
}
