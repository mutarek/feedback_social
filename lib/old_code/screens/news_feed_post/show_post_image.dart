import 'package:als_frontend/old_code/provider/post/news_feed_post_provider.dart';
import 'package:als_frontend/old_code/screens/screens.dart';
import 'package:als_frontend/old_code/widgets/Post%20Container/like_comment_share.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class ShowPostImage extends StatefulWidget {
  const ShowPostImage({Key? key}) : super(key: key);

  @override
  State<ShowPostImage> createState() => _ShowPostImageState();
}

class _ShowPostImageState extends State<ShowPostImage> {
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Consumer<NewsFeedPostProvider>(builder: (context, provider, child) {
              return ListView.builder(
                  itemCount: provider.results[provider.index].totalImage,
                  itemBuilder: (context, index) {
                    return SingleChildScrollView(
                      physics: const ScrollPhysics(),
                      child: (provider.results[provider.index].images![index].image ==
                              null)
                          ? (provider.results[provider.index].images!.length == 1)
                              ? Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          vertical: height*0.27
                                        ),
                                      child: Container(
                                        color: Colors.white,
                                        child: InkWell(
                                          onTap: () {
                                            provider.singleImageIndex = index;
                                            Get.to(const SinglePostImage());
                                          },
                                          child: Image.network(
                                            "${provider.results[provider.index].images![index].image}",
                                            height: 300,
                                            width: double.maxFinite,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              : Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 8.0),
                                  child: Container(
                                    color: Colors.white,
                                    child: InkWell(
                                      onTap: () {
                                        provider.singleImageIndex = index;
                                        Get.to(const SinglePostImage());
                                      },
                                      child: Image.network(
                                        "${provider.results[provider.index].images![index].image}",
                                        height: 300,
                                        width: double.maxFinite,
                                      ),
                                    ),
                                  ),
                                )
                          : Image.asset(
                              "assets/background/blank.jpg",
                              width: double.maxFinite,
                            ),
                    );
                  });
            }),
            Consumer<NewsFeedPostProvider>(
                builder: (context, provider, child) {
              return Positioned.fill(
                  child: Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        color: Colors.black45,
                        child: LikeCommentShare(
                          index: provider.index,
                          likeText: (provider.results[provider.index].like == true)?
                          "Liked": "Like",
                          like: (){},
                          comment: () {
                            Get.to(const CommentsScreen());
                          },
                          share: () {},
                          fontColor: Colors.white,
                          iconColor: Colors.white,
                          likeIconColor: (provider.results[provider.index].like == true)?
                                Colors.red:
                                Colors.grey,
                        ),
                      )));
            })
          ],
        ));
  }
}
