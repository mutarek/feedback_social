import 'package:als_frontend/old_code/model/post/news_feed_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class PostPhotoContainer extends StatelessWidget {
  final NewsFeedData postImageUrl;

  const PostPhotoContainer({Key? key, required this.postImageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (postImageUrl.totalImage==1) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: CachedNetworkImage(
          imageUrl: postImageUrl.images![0].image!,
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: MasonryGridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 8,
        mainAxisSpacing: 10,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: postImageUrl.images!.length,
        // staggeredTileBuilder: (index) {
        //   return StaggeredTile.count(1, index.isOdd ? 0.9 : 1.02);
        // },
        itemBuilder: (context, index) {
                  return CachedNetworkImage(
                    imageUrl: postImageUrl.images![index].image!,
                    fit: BoxFit.cover,
                    width: double.infinity,
                  );
        },
      ),
    );
    // return Padding(
    //   padding: const EdgeInsets.symmetric(vertical: 8.0),
    //   child: Container(
    //     width: double.infinity,
    //     margin: const EdgeInsets.symmetric(horizontal: 10.0),
    //     child: CarouselSlider.builder(
    //       itemCount: postImageUrl.images!.length,
    //       options: CarouselOptions(
    //         enlargeCenterPage: true,
    //       ),
    //       itemBuilder: (context, index, realIndex) {
    //         return CachedNetworkImage(
    //           imageUrl: postImageUrl.images![index].image!,
    //           fit: BoxFit.cover,
    //           width: double.infinity,
    //         );
    //       },
    //     ),
    //   ),
    // );
  }
}
