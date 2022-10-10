import 'package:als_frontend/data/model/response/image_video_detect_model.dart';
import 'package:als_frontend/old_code/model/model.dart';
import 'package:als_frontend/provider/newsfeed_provider.dart';
import 'package:als_frontend/screens/home/widget/post_header.dart';
import 'package:als_frontend/screens/home/widget/post_stats.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PhotoViewScreen extends StatelessWidget {
  final NewsFeedData newsFeedData;
  final List<ImageVideoDetectModel> imageVideo;
  final int index;

  const PhotoViewScreen(this.newsFeedData, this.imageVideo, this.index, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Consumer<NewsFeedProvider>(
          builder: (context, newsFeedProvider, child) => ListView(
            padding: EdgeInsets.symmetric(vertical: 10),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PostHeaderWidget(post: newsFeedData),
                    const SizedBox(height: 8.0),
                    Text(newsFeedData.description!, style: latoStyle400Regular)
                  ],
                ),
              ),
              PostStats(post: newsFeedData, index: index, newsFeedProvider: newsFeedProvider, paddingHorizontal: 0, paddingVertical: 3),
              ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: imageVideo.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Stack(
                          children: [
                            CachedNetworkImage(
                              imageUrl: imageVideo[index].url,
                              width: MediaQuery.of(context).size.width,
                              fit: BoxFit.fill,
                            ),
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
                                          onPressed: () {},
                                          icon: Icon(Icons.video_collection_rounded, color: Colors.grey.withOpacity(.7), size: 38)),
                                    ),
                                  )
                                : SizedBox.shrink()
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.only(bottom: 5),
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
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
