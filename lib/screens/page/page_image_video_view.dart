import 'package:als_frontend/data/model/response/watch_list_model.dart';
import 'package:als_frontend/provider/page_provider.dart';
import 'package:als_frontend/screens/video/video_screen.dart';
import 'package:als_frontend/util/helper.dart';
import 'package:als_frontend/widgets/single_image_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PageImageVideoView extends StatefulWidget {
  final bool isForImage;

  const PageImageVideoView({this.isForImage = true, Key? key})
      : super(key: key);

  @override
  State<PageImageVideoView> createState() => _PageImageVideoViewState();
}

class _PageImageVideoViewState extends State<PageImageVideoView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // if (widget.isForImage) {
    //   Provider.of<GroupProvider>(context, listen: false).callForGetAllGroupImage(widget.groupID);
    // } else {
    //   Provider.of<GroupProvider>(context, listen: false).callForGetAllGroupVideo(widget.groupID);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PageProvider>(
        builder: (context, pageProvider, child) => GridView.builder(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 5),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3, crossAxisSpacing: 5.0, mainAxisSpacing: 5.0),
            itemCount: widget.isForImage
                ? pageProvider.pageDetailsModel!.photos!.length
                : pageProvider.pageDetailsModel!.videos!.length,
            itemBuilder: (context, index) {
              return InkWell(
                  onTap: () {
                    if (widget.isForImage) {
                      Helper.toScreen(SingleImageView(
                        imageURL: pageProvider
                            .pageDetailsModel!.photos![index].image!,
                      ));
                    } else {
                      User user =  User(
                          id: pageProvider.pageDetailsModel!.author!.id,
                          fullName: pageProvider.pageDetailsModel!.author!.fullName,
                          profileImage: pageProvider
                              .pageDetailsModel!.author!.profileImage);
                      WatchListModel watchListModel = WatchListModel(
                          watchId: 1,
                          postId: pageProvider.pageDetailsModel!.id,
                          headerText: "",
                          createdAt: "2022-12-19T13:45:20.855137",
                          thumbnail: "",
                          video: pageProvider
                              .pageDetailsModel!.videos![index].video,
                          user: user,
                          totalComment: 0,
                          commentUrl: "",
                          isLiked: false,
                          likedByUrl: "",
                          sharedByUrl: "",
                          totalLiked: 0,
                          totalShared: 0);
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (_) => VideoScreen(watchListModel)));
                    }
                  },
                  child: Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.white),
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey.withOpacity(.2),
                                  blurRadius: 10.0,
                                  spreadRadius: 3.0,
                                  offset: const Offset(0.0, 0.0))
                            ],
                            borderRadius: BorderRadius.circular(5)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: CachedNetworkImage(
                              imageUrl: widget.isForImage
                                  ? pageProvider
                                      .pageDetailsModel!.photos![index].image!
                                  : pageProvider
                                      .pageDetailsModel!.videos![index].video,
                              fit: BoxFit.cover,
                              height: 200,
                              width: MediaQuery.of(context).size.width,
                              placeholder: ((context, url) => Container(
                                    alignment: Alignment.center,
                                    child: Image.asset(
                                        "assets/background/loading.gif",
                                        height: 200),
                                  ))),
                        ),
                      ),
                      !widget.isForImage
                          ? Positioned(
                              left: 0,
                              right: 0,
                              top: -30,
                              bottom: 0,
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(.3)),
                                child: Icon(Icons.video_collection_rounded,
                                    color: Colors.grey.withOpacity(.7),
                                    size: 38),
                              ),
                            )
                          : const SizedBox.shrink()
                    ],
                  ));
            }));
  }
}
