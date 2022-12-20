import 'package:als_frontend/data/model/response/watch_list_model.dart';
import 'package:als_frontend/provider/group_provider.dart';
import 'package:als_frontend/screens/video/video_screen.dart';
import 'package:als_frontend/util/helper.dart';
import 'package:als_frontend/widgets/single_image_view.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GroupImageVideoView extends StatefulWidget {
  final int groupID;
  final bool isForImage;

  const GroupImageVideoView(this.groupID, {this.isForImage = true, Key? key}) : super(key: key);

  @override
  State<GroupImageVideoView> createState() => _GroupImageVideoViewState();
}

class _GroupImageVideoViewState extends State<GroupImageVideoView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (widget.isForImage) {
      Provider.of<GroupProvider>(context, listen: false).callForGetAllGroupImage(widget.groupID);
    } else {
      Provider.of<GroupProvider>(context, listen: false).callForGetAllGroupVideo(widget.groupID);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GroupProvider>(
        builder: (context, groupProvider, child) => groupProvider.isLoadingForGroupImageVideo
            ? const Center(child: CupertinoActivityIndicator())
            : GridView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 5),
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3, crossAxisSpacing: 5.0, mainAxisSpacing: 5.0),
                itemCount: widget.isForImage ? groupProvider.groupImagesLists.length : groupProvider.groupVideoLists.length,
                itemBuilder: (context, index) {
                  return InkWell(
                      onTap: () {
                        if (widget.isForImage) {
                          Helper.toScreen(SingleImageView(imageURL: groupProvider.groupImagesLists[index].image));
                        } else {
                          User user = User(id: 1, fullName: "", profileImage: "");
                          WatchListModel watchListModel = WatchListModel(
                              watchId: 1,
                              postId: groupProvider.groupAllPosts[index].id,
                              headerText: "",
                              createdAt: "2022-12-19T13:45:20.855137",
                              video: groupProvider.groupVideoLists[index].video,
                              thumbnail: groupProvider.groupVideoLists[index].video,
                              user: user,
                              totalComment: 1,
                              commentUrl: "",
                              isLiked: true,
                              likedByUrl: "",
                              sharedByUrl: "",
                              totalLiked: 1,
                              totalShared: 1);
                          Navigator.of(context).push(MaterialPageRoute(builder: (_) => VideoScreen(watchListModel)));
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
                                      ? groupProvider.groupImagesLists[index].image
                                      : groupProvider.groupVideoLists[index].thumbnail!,
                                  fit: BoxFit.cover,
                                  height: 200,
                                  width: MediaQuery.of(context).size.width,
                                  placeholder: ((context, url) => Container(
                                        alignment: Alignment.center,
                                        child: Image.asset("assets/background/loading.gif", height: 200),
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
                                    decoration: BoxDecoration(color: Colors.white.withOpacity(.3)),
                                    child: Icon(Icons.video_collection_rounded, color: Colors.grey.withOpacity(.7), size: 38),
                                  ),
                                )
                              : const SizedBox.shrink()
                        ],
                      ));
                }));
  }
}
