import 'package:als_frontend/data/model/response/news_feed_model.dart';
import 'package:als_frontend/screens/home/widget/photo_widget.dart';
import 'package:als_frontend/screens/home/widget/post_header.dart';
import 'package:als_frontend/screens/home/widget/post_stats.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:flutter/material.dart';

class TimeLineWidget extends StatelessWidget {
  final NewsFeedData newsFeedData;
  final int index;
  final feedProvider;
  final bool isHomeScreen;
  final bool isProfileScreen;

  const TimeLineWidget(this.newsFeedData, this.index, this.feedProvider,
      {this.isHomeScreen = false, this.isProfileScreen = false, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [BoxShadow(color: Colors.grey.withOpacity(.2), blurRadius: 10.0, spreadRadius: 3.3, offset: Offset(0.0, 0.0))],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PostHeaderWidget(post: newsFeedData),
                const SizedBox(height: 8.0),
                Text(newsFeedData.description!, style: latoStyle400Regular),
                if (newsFeedData.totalImage != 0) const SizedBox(height: 10.0),
              ],
            ),
          ),
          if ((newsFeedData.totalImage! + newsFeedData.totalVideo!) != 0) PostPhotoContainer(index, postImageUrl: newsFeedData),
          PostStats(
              post: newsFeedData,
              index: index,
              feedProvider: feedProvider,
              isHomeNewsFeedProvider: isHomeScreen,
              isFromProfile: isProfileScreen),
        ],
      ),
    );
  }
}
