import 'package:als_frontend/data/model/response/news_feed_model.dart';
import 'package:als_frontend/helper/number_helper.dart';
import 'package:als_frontend/helper/open_call_url_map_sms_helper.dart';
import 'package:als_frontend/helper/url_checkig_helper.dart';
import 'package:als_frontend/provider/auth_provider.dart';
import 'package:als_frontend/screens/group/public_group_screen.dart';
import 'package:als_frontend/screens/home/widget/photo_widget.dart';
import 'package:als_frontend/screens/home/widget/post_header.dart';
import 'package:als_frontend/screens/home/widget/post_stats.dart';
import 'package:als_frontend/screens/home/widget/profile_avatar.dart';
import 'package:als_frontend/screens/profile/profile_screen.dart';
import 'package:als_frontend/screens/profile/public_profile_screen.dart';
import 'package:als_frontend/translations/locale_keys.g.dart';
import 'package:als_frontend/util/helper.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/any_link_preview_global_widget.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:provider/provider.dart';

class TimeLineWidget extends StatelessWidget {
  final NewsFeedModel newsFeedData;
  final int index;
  final feedProvider;
  final bool isHomeScreen;
  final bool isProfileScreen;
  final int groupPageID;
  final bool isGroup;
  final bool isPage;

  const TimeLineWidget(this.newsFeedData, this.index, this.feedProvider,
      {this.isHomeScreen = false,
      this.isProfileScreen = false,
      this.isGroup = false,
      this.isPage = false,
      this.groupPageID = 0,
      Key? key})
      : super(key: key);

  void route(BuildContext context, int code) {
    if (newsFeedData.sharePost!.shareFrom == 'group' && code == 0) {
      Helper.toScreen(PublicGroupScreen(
          newsFeedData.sharePost!.post!.groupModel!.id.toString(),
          index: index));
    } else {
      if (Provider.of<AuthProvider>(context, listen: false).userID ==
          newsFeedData.sharePost!.post!.author!.id.toString()) {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (_) => const ProfileScreen()));
      } else {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => PublicProfileScreen(
                newsFeedData.sharePost!.post!.author!.id.toString())));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
              color: Colors.grey.withOpacity(.1),
              blurRadius: 10.0,
              spreadRadius: 3.3,
              offset: const Offset(0.0, 0.0))
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PostHeaderWidget(
                    post: newsFeedData,
                    index: index,
                    isGroup: isGroup,
                    isHomeScreen: isHomeScreen,
                    isPage: isPage,
                    groupPageID: groupPageID,
                    isProfileScreen: isProfileScreen),
                SizedBox(
                    height: newsFeedData.description != null &&
                            newsFeedData.description!.isNotEmpty
                        ? 8.0
                        : 0),
                newsFeedData.description != null &&
                        newsFeedData.description!.isNotEmpty &&
                        newsFeedData.description!.contains("http")
                    ? MarkdownBody(
                        onTapLink: (text, href, title) {
                          href != null ? openNewLink(href) : null;
                        },
                        selectable: true,
                        data: newsFeedData.description!,
                        styleSheet: MarkdownStyleSheet(
                            a: const TextStyle(fontSize: 17),
                            p: latoStyle500Medium),
                      )
                    : const SizedBox(),
                SizedBox(
                    height: newsFeedData.description != null &&
                            newsFeedData.description!.isNotEmpty
                        ? 1.0
                        : 0),
                newsFeedData.description != null &&
                        newsFeedData.description!.isNotEmpty &&
                        newsFeedData.totalImage == 0 &&
                        newsFeedData.description!.contains("http")
                    ? AnyLinkPreviewGlobalWidget(
                        extractdescription(newsFeedData.description!),
                        120.0,
                        double.infinity,
                        10.0)
                    : newsFeedData.description!.contains("http")
                        ? const SizedBox()
                        : Text(
                            newsFeedData.description!,
                            style: latoStyle700Bold,
                          ),
                SizedBox(
                    height: newsFeedData.totalImage != 0 &&
                            newsFeedData.description != null
                        ? 10.0
                        : 0),
                !newsFeedData.isShare!
                    ? const SizedBox()
                    : Container(
                        padding: const EdgeInsets.all(5),
                        margin: const EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                            border:
                                Border.all(color: Colors.grey.withOpacity(.1)),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    route(
                                        context,
                                        newsFeedData.sharePost!.shareFrom ==
                                                'group'
                                            ? 0
                                            : 1);
                                  },
                                  child: ProfileAvatar(
                                      profileImageUrl:
                                          newsFeedData.sharePost!.shareFrom ==
                                                  'group'
                                              ? newsFeedData.sharePost!.post!
                                                  .groupModel!.coverPhoto!
                                              : newsFeedData.sharePost!.post!
                                                  .author!.profileImage!),
                                ),
                                const SizedBox(width: 8.0),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          route(
                                              context,
                                              newsFeedData.sharePost!
                                                          .shareFrom ==
                                                      'group'
                                                  ? 0
                                                  : 1);
                                        },
                                        child: Text(
                                            newsFeedData.sharePost!.shareFrom ==
                                                    'group'
                                                ? newsFeedData.sharePost!.post!
                                                    .groupModel!.name!
                                                : newsFeedData.sharePost!.post!
                                                    .author!.fullName!,
                                            style: latoStyle500Medium.copyWith(
                                                fontWeight: FontWeight.w600)),
                                      ),
                                      SizedBox(
                                          height: newsFeedData
                                                      .sharePost!.shareFrom ==
                                                  'group'
                                              ? 4
                                              : 0),
                                      newsFeedData.sharePost!.shareFrom ==
                                              'group'
                                          ? InkWell(
                                              onTap: () {
                                                route(context, 1);
                                              },
                                              child: Text(
                                                  newsFeedData.sharePost!.post!
                                                          .author!.fullName! +
                                                      LocaleKeys.posted_Here
                                                          .tr(),
                                                  style: latoStyle500Medium
                                                      .copyWith(
                                                          fontWeight:
                                                              FontWeight.w400)),
                                            )
                                          : const SizedBox(),
                                      Row(
                                        children: [
                                          Text(
                                              getDate(
                                                  newsFeedData
                                                      .sharePost!.timestamp!,
                                                  context),
                                              style:
                                                  latoStyle400Regular.copyWith(
                                                      color: Colors.grey[600],
                                                      fontSize: 12.0)),
                                          Icon(Icons.public,
                                              color: Colors.grey[600],
                                              size: 12.0)
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                                height: newsFeedData.sharePost!.post!
                                        .description!.isNotEmpty
                                    ? 8.0
                                    : 0),
                            newsFeedData
                                    .sharePost!.post!.description!.isNotEmpty
                                ? Text(
                                    newsFeedData.sharePost!.post!.description!,
                                    style: latoStyle400Regular)
                                : const SizedBox(),
                            SizedBox(
                                height:
                                    newsFeedData.sharePost!.post!.totalImage !=
                                                0 &&
                                            newsFeedData.sharePost!.post!
                                                    .description !=
                                                null
                                        ? 10.0
                                        : 0),
                            if ((newsFeedData.sharePost!.post!.totalImage! +
                                    newsFeedData
                                        .sharePost!.post!.totalVideo!) !=
                                0)
                              PostPhotoContainer(index,
                                  newsfeedModel: NewsFeedModel(
                                      totalImage: newsFeedData
                                          .sharePost!.post!.totalImage!,
                                      images:
                                          newsFeedData.sharePost!.post!.images!,
                                      totalVideo: newsFeedData
                                          .sharePost!.post!.totalVideo,
                                      videos: newsFeedData
                                          .sharePost!.post!.videos)),
                            SizedBox(
                                height: ((newsFeedData.totalImage! +
                                            newsFeedData.totalVideo!) !=
                                        0)
                                    ? 10.0
                                    : 15.0),
                          ],
                        ),
                      )
              ],
            ),
          ),
          if ((newsFeedData.totalImage! + newsFeedData.totalVideo!) != 0)
            PostPhotoContainer(index, newsfeedModel: newsFeedData),
          SizedBox(
              height:
                  ((newsFeedData.totalImage! + newsFeedData.totalVideo!) != 0)
                      ? 10.0
                      : 15.0),
          PostStats(
              post: newsFeedData,
              index: index,
              feedProvider: feedProvider,
              isHomeScreen: isHomeScreen,
              isFromProfile: isProfileScreen,
              groupPageID: groupPageID,
              postID: newsFeedData.id as int),
        ],
      ),
    );
  }
}
