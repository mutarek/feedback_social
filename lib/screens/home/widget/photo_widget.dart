import 'package:als_frontend/old_code/model/post/news_feed_model.dart';
import 'package:als_frontend/screens/home/view/photo_view_screen.dart';
import 'package:als_frontend/widgets/custom_button.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../data/model/response/image_video_detect_model.dart';

class PostPhotoContainer extends StatefulWidget {
  final NewsFeedData postImageUrl;
  final int index;
  const PostPhotoContainer(this.index,{Key? key, required this.postImageUrl}) : super(key: key);

  @override
  State<PostPhotoContainer> createState() => _PostPhotoContainerState();
}

class _PostPhotoContainerState extends State<PostPhotoContainer> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    imageVideoLists.clear();
    imageVideoLists = [];
    initializeAllImageVideo();
  }

  List<ImageVideoDetectModel> imageVideoLists = [];

  void initializeAllImageVideo() {
    if (widget.postImageUrl.totalImage! >= 4) {
      for (int i = 0; i <= 3; i++) {
        imageVideoLists
            .add(ImageVideoDetectModel(true, widget.postImageUrl.images![i].image!, widget.postImageUrl.images![i].id!.toString()));
      }
    } else {
      for (int i = 0; i < widget.postImageUrl.totalImage!; i++) {
        imageVideoLists
            .add(ImageVideoDetectModel(true, widget.postImageUrl.images![i].image!, widget.postImageUrl.images![i].id!.toString()));
      }

      int j = 0;

      for (int i = widget.postImageUrl.totalImage!; i < widget.postImageUrl.totalImage! + widget.postImageUrl.totalVideo!; i++) {
        imageVideoLists
            .add(ImageVideoDetectModel(false, widget.postImageUrl.videos![j].thumbnail!, widget.postImageUrl.videos![j].id!.toString()));

        j++;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (imageVideoLists.length == 1) {
      return imageVideoLists[0].isImage
          ? Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: ClipRRect(
                  borderRadius:BorderRadius.circular(6),
                  child: CachedNetworkImage(imageUrl: imageVideoLists[0].url)),
            )
          : Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Stack(
                children: [
                  ClipRRect(
                      borderRadius:BorderRadius.circular(6),
                      child: CachedNetworkImage(imageUrl: imageVideoLists[0].url)),
                  Positioned(
                    left: 0,
                    right: 0,
                    top: 0,
                    bottom: 0,
                    child: Container(
                      width: double.infinity,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(color: Colors.white.withOpacity(.3)),
                      child: IconButton(
                          onPressed: () {}, icon: Icon(Icons.video_collection_rounded, color: Colors.grey.withOpacity(.7), size: 38)),
                    ),
                  )
                ],
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
        itemCount: imageVideoLists.length > 4 ? 4 : imageVideoLists.length,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(builder: (_) => PhotoViewScreen(widget.postImageUrl, imageVideoLists,widget.index)));
            },
            child: Stack(
              children: [
                ClipRRect(
                    borderRadius:BorderRadius.circular(4),
                    child: CachedNetworkImage(imageUrl: imageVideoLists[index].url, fit: BoxFit.cover, width: double.infinity)),
                imageVideoLists[index].isImage == false
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
                              onPressed: () {}, icon: Icon(Icons.video_collection_rounded, color: Colors.grey.withOpacity(.7), size: 38)),
                        ),
                      )
                    : SizedBox.shrink(),
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
            ),
          );
        },
      ),
    );
  }
}
