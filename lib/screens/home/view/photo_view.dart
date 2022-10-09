import 'package:als_frontend/old_code/model/post/news_feed_model.dart';
import 'package:als_frontend/widgets/custom_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class PostPhotoContainer extends StatelessWidget {
  final NewsFeedData postImageUrl;

  const PostPhotoContainer({Key? key, required this.postImageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (postImageUrl.totalImage == 1) {
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
        itemCount: postImageUrl.images!.length > 4 ? 4 : postImageUrl.images!.length,
        itemBuilder: (context, index) {
          return Stack(
            children: [
              CachedNetworkImage(imageUrl: postImageUrl.images![index].image!, fit: BoxFit.cover, width: double.infinity),
              index == 3
                  ? Container(
                      width: double.infinity,
                      height: 100,
                      alignment: Alignment.center,
                      child: SizedBox(
                        width: 100,
                        child: CustomButton(
                          onTap: () {},
                          btnTxt: 'View More+',
                          fontSize: 12,
                          backgroundColor: Colors.green.withOpacity(.7),
                          textWhiteColor: true,
                        ),
                      ),
                    )
                  : SizedBox.shrink()
            ],
          );
        },
      ),
    );
  }
}
