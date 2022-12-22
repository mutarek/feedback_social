import 'package:als_frontend/data/model/response/image_video_detect_model.dart';
import 'package:als_frontend/data/model/response/news_feed_model.dart';
import 'package:als_frontend/data/model/response/watch_list_model.dart';
import 'package:als_frontend/provider/newsfeed_provider.dart';
import 'package:als_frontend/screens/home/widget/post_header.dart';
import 'package:als_frontend/screens/home/widget/post_stats.dart';
import 'package:als_frontend/screens/video/video_screen.dart';
import 'package:als_frontend/util/helper.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/single_image_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PhotoViewScreen extends StatelessWidget {
  final NewsFeedModel newsFeedData;
  final List<ImageVideoDetectModel> imageVideo;
  final int index;

  const PhotoViewScreen(this.newsFeedData, this.imageVideo, this.index, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<NewsFeedProvider>(
          builder: (context, newsFeedProvider, child) => ListView(
            padding: const EdgeInsets.symmetric(vertical: 10),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PostHeaderWidget(post: newsFeedData, index: index),
                    const SizedBox(height: 8.0),
                    Text(newsFeedData.description!, style: latoStyle400Regular)
                  ],
                ),
              ),
              PostStats(post: newsFeedData, index: index, feedProvider: newsFeedProvider, paddingHorizontal: 0, paddingVertical: 3),
              ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: imageVideo.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        if (!imageVideo[index].isImage) {
                          User user =  User(
                              id: newsFeedData.author!.id,
                              fullName: newsFeedData.author!.fullName,
                              profileImage: newsFeedData.author!.profileImage);

                          WatchListModel watchListModel = WatchListModel(
                              thumbnail: imageVideo[index].url,
                              video: imageVideo[index].url2,
                              user: user,
                              watchId: DateTime.now().microsecondsSinceEpoch,
                              postId: newsFeedData.id,
                              headerText: newsFeedData.description,
                              createdAt: newsFeedData.timestamp,
                              totalComment: newsFeedData.totalComment,
                              commentUrl: newsFeedData.commentUrl,
                              isLiked: newsFeedData.isLiked,
                              likedByUrl: newsFeedData.likedByUrl,
                              sharedByUrl: newsFeedData.sharedByUrl,
                              totalLiked: newsFeedData.totalLiked,
                              totalShared: newsFeedData.totalShared);


                          Navigator.of(context).push(MaterialPageRoute(builder: (_) => VideoScreen(watchListModel)));
                        } else {
                          Helper.toScreen(SingleImageView(imageURL: imageVideo[index].url));
                        }
                      },
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              CachedNetworkImage(
                                  imageUrl: imageVideo[index].url, width: MediaQuery.of(context).size.width, fit: BoxFit.fill),
                              !imageVideo[index].isImage
                                  ? Positioned(
                                      left: 0,
                                      right: 0,
                                      top: 0,
                                      bottom: 0,
                                      child: Container(
                                        width: double.infinity,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(color: Colors.white.withOpacity(.3)),
                                        child: IconButton(
                                            onPressed: () {
                                              User user = User(
                                                  id: newsFeedData.author!.id,
                                                  fullName: newsFeedData.author!.fullName,
                                                  profileImage: newsFeedData.author!.profileImage);
                                              WatchListModel watchListModel = WatchListModel(
                                                  thumbnail: imageVideo[index].url,
                                                  video: imageVideo[index].url2,
                                                  user: user,
                                                  watchId: DateTime.now().microsecondsSinceEpoch,
                                                  postId: newsFeedData.id,
                                                  headerText: newsFeedData.description,
                                                  createdAt: newsFeedData.timestamp,
                                                  totalComment: newsFeedData.totalComment,
                                                  commentUrl: newsFeedData.commentUrl,
                                                  isLiked: newsFeedData.isLiked,
                                                  likedByUrl: newsFeedData.likedByUrl,
                                                  sharedByUrl: newsFeedData.sharedByUrl,
                                                  totalLiked: newsFeedData.totalLiked,
                                                  totalShared: newsFeedData.totalShared);
                                              Navigator.of(context).push(MaterialPageRoute(builder: (_) => VideoScreen(watchListModel)));
                                            },
                                            icon: Icon(Icons.video_collection_rounded, color: Colors.grey.withOpacity(.7), size: 38)),
                                      ),
                                    )
                                  : const SizedBox.shrink()
                            ],
                          ),
                          Container(
                            margin: const EdgeInsets.only(bottom: 5),
                            width: MediaQuery.of(context).size.width,
                            height: 25,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(color: Colors.grey.withOpacity(.2), blurRadius: 9, spreadRadius: 10),
                              ],
                            ),
                          )
                        ],
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
