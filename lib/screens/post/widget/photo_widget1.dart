import 'package:als_frontend/data/model/response/news_feed_model.dart';
import 'package:als_frontend/data/model/response/watch_list_model.dart';
import 'package:als_frontend/provider/other_provider.dart';
import 'package:als_frontend/screens/post/view/photo_view_screen1.dart';
import 'package:als_frontend/screens/video/video_screen.dart';
import 'package:als_frontend/translations/locale_keys.g.dart';
import 'package:als_frontend/util/image.dart';
import 'package:als_frontend/widgets/custom_button.dart';
import 'package:als_frontend/widgets/network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../data/model/response/image_video_detect_model.dart';

class PostPhotoWidget extends StatefulWidget {
  final NewsFeedModel newsfeedModel;
  final int index;

  const PostPhotoWidget(this.index, {Key? key, required this.newsfeedModel}) : super(key: key);

  @override
  State<PostPhotoWidget> createState() => _PostPhotoWidgetState();
}

class _PostPhotoWidgetState extends State<PostPhotoWidget> {
  int totalImage = 0;
  int totalVideo = 0;
  int totalImageVideo = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    totalImage = widget.newsfeedModel.totalImage! as int;
    totalVideo = widget.newsfeedModel.totalVideo! as int;
    totalImageVideo = totalImage + totalVideo;
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
    return totalImageVideo == 0
        ? const SizedBox.shrink()
        : MasonryGridView.count(
            crossAxisCount: totalImageVideo > 1 ? 2 : 1,
            crossAxisSpacing: 8,
            mainAxisSpacing: 10,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: totalImageVideo > 4 ? 4 : totalImageVideo,
            itemBuilder: (context, index) {
              bool isVideo = false;
              String url = '';
              if (index >= totalImage) {
                isVideo = true;
                url = widget.newsfeedModel.videos![index - totalImage].thumbnail!;
              } else {
                isVideo = false;
                url = widget.newsfeedModel.images![index].image!;
              }
//Shuvo 0  | 1  |1 |1 |2 |1
              return InkWell(
                onTap: () {
                  Provider.of<OtherProvider>(context, listen: false)
                      .changeImageVideoLists(widget.newsfeedModel.images!, widget.newsfeedModel.videos!);
                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => PhotoViewScreen1(widget.newsfeedModel, widget.index)));
                },
                child: Stack(
                  children: [
                    ClipRRect(borderRadius: BorderRadius.circular(4), child: customNetworkImage(url)),
                    isVideo == true
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
                                      isLiked: widget.newsfeedModel.reaction != -1,
                                      likedByUrl: widget.newsfeedModel.likeReactUrl,
                                      sharedByUrl: widget.newsfeedModel.sharedByUrl,
                                      totalLiked: widget.newsfeedModel.totalLiked,
                                      totalShared: widget.newsfeedModel.totalShared);

                                  Navigator.of(context).push(MaterialPageRoute(builder: (_) => VideoScreen(watchListModel)));
                                },
                                icon: SvgPicture.asset(ImagesModel.videoIcons),
                                // icon: Icon(Icons.video_collection_rounded, color: Colors.grey.withOpacity(.7), size: 38),
                              ),
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
