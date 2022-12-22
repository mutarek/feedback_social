import 'package:als_frontend/data/model/response/news_feed_model.dart';
import 'package:als_frontend/data/model/response/watch_list_model.dart';
import 'package:als_frontend/screens/home/view/photo_view_screen.dart';
import 'package:als_frontend/screens/video/video_screen.dart';
import 'package:als_frontend/translations/locale_keys.g.dart';
import 'package:als_frontend/util/helper.dart';
import 'package:als_frontend/widgets/custom_button.dart';
import 'package:als_frontend/widgets/network_image.dart';
import 'package:als_frontend/widgets/single_image_view.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../data/model/response/image_video_detect_model.dart';

class PostPhotoContainer extends StatefulWidget {
  final NewsFeedModel newsfeedModel;
  final int index;

  const PostPhotoContainer(this.index, {Key? key, required this.newsfeedModel}) : super(key: key);

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
    if (widget.newsfeedModel.isShare != null && widget.newsfeedModel.isShare!) {
      if (widget.newsfeedModel.sharePost!.post!.totalImage! >= 4) {
        for (int i = 0; i <= 3; i++) {
          imageVideoLists.add(ImageVideoDetectModel(true, widget.newsfeedModel.sharePost!.post!.images![i].image!, '',
              widget.newsfeedModel.sharePost!.post!.images![i].id!.toString(), widget.newsfeedModel.description!));
        }
      } else {
        for (int i = 0; i < widget.newsfeedModel.sharePost!.post!.totalImage!; i++) {
          imageVideoLists.add(ImageVideoDetectModel(true, widget.newsfeedModel.sharePost!.post!.images![i].image!, '',
              widget.newsfeedModel.sharePost!.post!.images![i].id!.toString(), widget.newsfeedModel.description!));
        }

        int j = 0;

        for (int i = widget.newsfeedModel.sharePost!.post!.totalImage! as int;
            i < widget.newsfeedModel.sharePost!.post!.totalImage! + widget.newsfeedModel.sharePost!.post!.totalVideo!;
            i++) {
          imageVideoLists.add(ImageVideoDetectModel(
              false,
              widget.newsfeedModel.sharePost!.post!.videos![j].thumbnail!,
              widget.newsfeedModel.sharePost!.post!.videos![j].video!,
              widget.newsfeedModel.sharePost!.post!.videos![j].id!.toString(),
              widget.newsfeedModel.description!));
          j++;
        }
      }
    } else {
      if (widget.newsfeedModel.totalImage! >= 4) {
        for (int i = 0; i <= 3; i++) {
          imageVideoLists.add(ImageVideoDetectModel(true, widget.newsfeedModel.images![i].image!, '',
              widget.newsfeedModel.images![i].id!.toString(), widget.newsfeedModel.description!));
        }
      } else {
        for (int i = 0; i < widget.newsfeedModel.totalImage!; i++) {
          imageVideoLists.add(ImageVideoDetectModel(true, widget.newsfeedModel.images![i].image!, '',
              widget.newsfeedModel.images![i].id!.toString(), widget.newsfeedModel.description!));
        }

        int j = 0;

        for (int i = widget.newsfeedModel.totalImage! as int;
            i < widget.newsfeedModel.totalImage! + widget.newsfeedModel.totalVideo!;
            i++) {
          imageVideoLists.add(ImageVideoDetectModel(false, widget.newsfeedModel.videos![j].thumbnail!,
              widget.newsfeedModel.videos![j].video!, widget.newsfeedModel.videos![j].id!.toString(), widget.newsfeedModel.description!));
          j++;
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (imageVideoLists.length == 1) {
      return imageVideoLists[0].isImage
          ? InkWell(
              onTap: () {
                Helper.toScreen(SingleImageView(imageURL: imageVideoLists[0].url));
              },
              child: customNetworkImage(context, imageVideoLists[0].url))
          : InkWell(
              onTap: () {
                User user = User(
                    id: widget.newsfeedModel.author!.id,
                    fullName: widget.newsfeedModel.author!.fullName,
                    profileImage: widget.newsfeedModel.author!.profileImage);
                WatchListModel watchListModel = WatchListModel(
                    watchId: 1,
                    postId: widget.newsfeedModel.id,
                    headerText: imageVideoLists[0].title,
                    createdAt: "2022-12-19T13:45:20.855137",
                    thumbnail: imageVideoLists[0].url,
                    video: imageVideoLists[0].url2,
                    user: user,
                    totalComment: widget.newsfeedModel.totalComment,
                    commentUrl: widget.newsfeedModel.commentUrl,
                    isLiked: widget.newsfeedModel.isLiked,
                    likedByUrl: widget.newsfeedModel.likedByUrl,
                    sharedByUrl: widget.newsfeedModel.sharedByUrl,
                    totalLiked: widget.newsfeedModel.totalLiked,
                    totalShared: widget.newsfeedModel.totalShared);
                Navigator.of(context).push(MaterialPageRoute(builder: (_) => VideoScreen(watchListModel)));
              },
              child: Container(
                margin: const EdgeInsets.only(top: 8),
                child: Stack(
                  children: [
                    customNetworkImage(context, imageVideoLists[0].url),
                    SizedBox(height: 150, width: MediaQuery.of(context).size.width),
                    Positioned(
                      left: 0,
                      right: 0,
                      top: 0,
                      bottom: 0,
                      child: Center(
                        child: Container(
                          height: 75,
                          width: 75,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(50),
                            border: Border.all(width: 3, color: Colors.white),
                          ),
                          child: IconButton(
                              onPressed: () {
                                User user = User(
                                    id: widget.newsfeedModel.author!.id,
                                    fullName: widget.newsfeedModel.author!.fullName,
                                    profileImage: widget.newsfeedModel.author!.profileImage);
                                WatchListModel watchListModel = WatchListModel(
                                    watchId: 1,
                                    postId: widget.newsfeedModel.id,
                                    headerText: imageVideoLists[0].title,
                                    createdAt: "2022-12-19T13:45:20.855137",
                                    thumbnail: imageVideoLists[0].url,
                                    video: imageVideoLists[0].url2,
                                    user: user,
                                    totalComment: widget.newsfeedModel.totalComment,
                                    commentUrl: widget.newsfeedModel.commentUrl,
                                    isLiked: widget.newsfeedModel.isLiked,
                                    likedByUrl: widget.newsfeedModel.likedByUrl,
                                    sharedByUrl: widget.newsfeedModel.sharedByUrl,
                                    totalLiked: widget.newsfeedModel.totalLiked,
                                    totalShared: widget.newsfeedModel.totalShared);
                                Navigator.of(context).push(MaterialPageRoute(builder: (_) => VideoScreen(watchListModel)));
                              },
                              icon: const Icon(Icons.play_arrow, color: Colors.white, size: 38)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
    }

    return MasonryGridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 8,
      mainAxisSpacing: 10,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: imageVideoLists.length > 4 ? 4 : imageVideoLists.length,
      itemBuilder: (context, index) {
        return InkWell(
          onTap: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (_) => PhotoViewScreen(widget.newsfeedModel, imageVideoLists, widget.index)));
          },
          child: Stack(
            children: [
              // ClipRRect(
              //     borderRadius: BorderRadius.circular(4),
              //     child: CachedNetworkImage(imageUrl: imageVideoLists[index].url, fit: BoxFit.cover, width: double.infinity)),
              ClipRRect(borderRadius: BorderRadius.circular(4), child: customNetworkImage(context, imageVideoLists[index].url)),
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
                            onPressed: () {
                              User user = User(
                                  id: widget.newsfeedModel.author!.id,
                                  fullName: widget.newsfeedModel.author!.fullName,
                                  profileImage: widget.newsfeedModel.author!.profileImage);
                              WatchListModel watchListModel = WatchListModel(
                                  watchId: 1,
                                  postId: widget.newsfeedModel.id,
                                  headerText: imageVideoLists[0].title,
                                  createdAt: "2022-12-19T13:45:20.855137",
                                  thumbnail: imageVideoLists[0].url,
                                  video: imageVideoLists[0].url2,
                                  user: user,
                                  totalComment: widget.newsfeedModel.totalComment,
                                  commentUrl: widget.newsfeedModel.commentUrl,
                                  isLiked: widget.newsfeedModel.isLiked,
                                  likedByUrl: widget.newsfeedModel.likedByUrl,
                                  sharedByUrl: widget.newsfeedModel.sharedByUrl,
                                  totalLiked: widget.newsfeedModel.totalLiked,
                                  totalShared: widget.newsfeedModel.totalShared);

                              Navigator.of(context).push(MaterialPageRoute(builder: (_) => VideoScreen(watchListModel)));
                            },
                            icon: Icon(Icons.video_collection_rounded, color: Colors.grey.withOpacity(.7), size: 38)),
                      ),
                    )
                  : const SizedBox.shrink(),
              index == 3
                  ? Positioned(
                      bottom: 20,
                      right: 10,
                      left: 50,
                      child: CustomButton(
                        onTap: () {},
                        btnTxt: LocaleKeys.view_More.tr(),
                        fontSize: 12,
                        backgroundColor: Colors.green.withOpacity(.8),
                        textWhiteColor: true,
                      ),
                    )
                  : const SizedBox.shrink()
            ],
          ),
        );
      },
    );
  }
}
