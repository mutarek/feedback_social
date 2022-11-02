import 'package:als_frontend/data/model/response/news_feed_model.dart';
import 'package:als_frontend/helper/number_helper.dart';
import 'package:als_frontend/provider/auth_provider.dart';
import 'package:als_frontend/screens/home/widget/photo_widget.dart';
import 'package:als_frontend/screens/home/widget/post_header.dart';
import 'package:als_frontend/screens/home/widget/post_stats.dart';
import 'package:als_frontend/screens/home/widget/profile_avatar.dart';
import 'package:als_frontend/screens/profile/profile_screen.dart';
import 'package:als_frontend/screens/profile/public_profile_screen.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TimeLineWidget extends StatelessWidget {
  final NewsFeedData newsFeedData;
  final int index;
  final feedProvider;
  final bool isHomeScreen;
  final bool isProfileScreen;
  final int groupPageID;
  final bool isGroup;
  final bool isPage;

  const TimeLineWidget(this.newsFeedData, this.index, this.feedProvider,
      {this.isHomeScreen = false, this.isProfileScreen = false, this.isGroup = false, this.isPage = false, this.groupPageID = 0, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 13),
      padding: const EdgeInsets.only(top: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(.2), blurRadius: 10.0, spreadRadius: 3.3, offset: const Offset(0.0, 0.0))],
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
                SizedBox(height: newsFeedData.description != null ? 8.0 : 0),
                Visibility(visible: newsFeedData.description != null, child: Text(newsFeedData.description!, style: latoStyle400Regular)),
                SizedBox(height: newsFeedData.totalImage != 0 && newsFeedData.description != null ? 10.0 : 0),
                !newsFeedData.isShare!
                    ? const SizedBox()
                    : Container(
                        padding: const EdgeInsets.all(5),
                        margin: const EdgeInsets.only(top: 10),
                        decoration:
                            BoxDecoration(border: Border.all(color: Colors.grey.withOpacity(.1)), borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                if (Provider.of<AuthProvider>(context, listen: false).userID ==
                                    newsFeedData.sharePost!.post!.author!.id.toString()) {
                                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => const ProfileScreen()));
                                } else {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => PublicProfileScreen(newsFeedData.sharePost!.post!.author!.id.toString())));
                                }
                              },
                              child: Row(
                                children: [
                                  ProfileAvatar(profileImageUrl: newsFeedData.sharePost!.post!.author!.profileImage!),
                                  const SizedBox(width: 8.0),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(newsFeedData.sharePost!.post!.author!.fullName!,
                                            style: latoStyle500Medium.copyWith(fontWeight: FontWeight.w600)),
                                        Row(
                                          children: [
                                            Text(getDate(newsFeedData.sharePost!.timestamp!, context),
                                                style: latoStyle400Regular.copyWith(color: Colors.grey[600], fontSize: 12.0)),
                                            Icon(Icons.public, color: Colors.grey[600], size: 12.0)
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: newsFeedData.sharePost!.post!.description!.isNotEmpty ? 8.0 : 0),
                            newsFeedData.sharePost!.post!.description!.isNotEmpty
                                ? Text(newsFeedData.sharePost!.post!.description!, style: latoStyle400Regular)
                                : const SizedBox(),
                            SizedBox(
                                height: newsFeedData.sharePost!.post!.totalImage != 0 && newsFeedData.sharePost!.post!.description != null
                                    ? 10.0
                                    : 0),
                            if ((newsFeedData.sharePost!.post!.totalImage! + newsFeedData.sharePost!.post!.totalVideo!) != 0)
                              PostPhotoContainer(index,
                                  newsfeedModel: NewsFeedData(
                                      totalImage: newsFeedData.sharePost!.post!.totalImage!,
                                      images: newsFeedData.sharePost!.post!.images!,
                                      totalVideo: newsFeedData.sharePost!.post!.totalVideo,
                                      videos: newsFeedData.sharePost!.post!.videos)),
                            SizedBox(height: ((newsFeedData.totalImage! + newsFeedData.totalVideo!) != 0) ? 10.0 : 15.0),
                          ],
                        ),
                      )
              ],
            ),
          ),
          if ((newsFeedData.totalImage! + newsFeedData.totalVideo!) != 0) PostPhotoContainer(index, newsfeedModel: newsFeedData),
          SizedBox(height: ((newsFeedData.totalImage! + newsFeedData.totalVideo!) != 0) ? 10.0 : 15.0),
          PostStats(
            post: newsFeedData,
            index: index,
            feedProvider: feedProvider,
            isHomeNewsFeedProvider: isHomeScreen,
            isFromProfile: isProfileScreen,
            groupPageID: groupPageID,
            postID: newsFeedData.id as int,
            isPage: isPage,
          ),
        ],
      ),
    );
  }
}
