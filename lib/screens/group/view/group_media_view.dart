import 'package:als_frontend/screens/group/new_design/group_media_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../provider/group_provider.dart';
import '../../../util/helper.dart';
import '../../../util/image.dart';
import '../../../util/theme/text.styles.dart';
import '../../../widgets/network_image.dart';
import '../../../widgets/single_image_view.dart';
import '../../page/photo_video_view_screen.dart';
import '../../page/widget/group_header.dart';

class GroupMediaView extends StatefulWidget {
  final String groupID;
  final int index;
  const GroupMediaView(this.widget, this.groupID, {this.index = 0,Key? key}) : super(key: key);
  final Widget widget;

  @override
  State<GroupMediaView> createState() => _GroupMediaViewState();
}

class _GroupMediaViewState extends State<GroupMediaView> {
  ScrollController controller = ScrollController();
  @override
  void initState() {
      controller.addListener(() {
        if (controller.offset >= controller.position.maxScrollExtent &&
            !controller.position.outOfRange &&
            Provider.of<GroupProvider>(context, listen: false).hasNextData) {
          Provider.of<GroupProvider>(context, listen: false).updateGroupNo(widget.groupID.toString());
        }
      });
      super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GroupProvider>(
        builder: (context, groupProvider,child) {
          return ListView(
            physics: const BouncingScrollPhysics(),
            controller: controller,
            children: [
              GroupHeaderWidget(widget.index),
              widget.widget,
                SizedBox(height: groupProvider.isPhotosLoading ? 100 : 0),
                groupProvider.isPhotosLoading
                    ? const Center(child: CircularProgressIndicator())
                    : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 5),
                    Padding(
                        padding: const EdgeInsets.only(left: 7, right: 7),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("All Photos:", style: robotoStyle700Bold.copyWith(fontSize: 15)),
                            groupProvider.groupPhotosModel.length > 4
                                ? TextButton(
                                onPressed: () {
                                  Helper.toScreen(const PhotoVideoViewScreen(true));
                                },
                                child: Text('View More', style: robotoStyle500Medium))
                                : const SizedBox.shrink()
                          ],
                        )),
                    SizedBox(
                        height: groupProvider.groupPhotosModel.length > 4
                            ? 0
                            : groupProvider.groupPhotosModel.isEmpty
                            ? 70
                            : 10),
                    groupProvider.groupPhotosModel.isEmpty
                        ? Center(child: Text("There has no Photos", style: robotoStyle500Medium))
                        : Padding(
                      padding: const EdgeInsets.only(left: 7, right: 7),
                      child: MasonryGridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 10,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: groupProvider.groupPhotosModel.length > 4 ? 4 : groupProvider.groupPhotosModel.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              Helper.toScreen(SingleImageView(imageURL: groupProvider.groupPhotosModel[index].image!));
                            },
                            child: SizedBox(
                                height: 120,
                                child: ClipRRect(
                                    borderRadius: BorderRadius.circular(3),
                                    child: customNetworkImage(groupProvider.groupPhotosModel[index].image.toString()))),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 10),
                    Padding(
                        padding: const EdgeInsets.only(left: 7, right: 7),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("All Videos:", style: robotoStyle700Bold.copyWith(fontSize: 15)),
                            groupProvider.groupVideosModel.length > 4
                                ? TextButton(
                                onPressed: () {
                                  Helper.toScreen(const PhotoVideoViewScreen(false));
                                },
                                child: Text('View More', style: robotoStyle500Medium))
                                : const SizedBox.shrink()
                          ],
                        )),
                    SizedBox(
                        height: groupProvider.groupVideosModel.length > 4
                            ? 0
                            : groupProvider.groupVideosModel.isEmpty
                            ? 70
                            : 10),
                    groupProvider.groupVideosModel.isEmpty
                        ? Center(child: Text("There has no videos", style: robotoStyle500Medium))
                        : Padding(
                      padding: const EdgeInsets.only(left: 7, right: 7),
                      child: MasonryGridView.count(
                        crossAxisCount: 2,
                        crossAxisSpacing: 8,
                        mainAxisSpacing: 10,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: groupProvider.groupVideosModel.length > 4 ? 4 : groupProvider.groupVideosModel.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              //TODO: Please handle the issue shuvo bhai
                              // User user = User(
                              //     id: groupProvider.authorEachGroupModel.author!.id,
                              //     fullName: pageProvider.pageDetailsModel.author!.fullName,
                              //     profileImage: pageProvider.pageDetailsModel.author!.profileImage);
                              //
                              // WatchListModel watchListModel = WatchListModel(
                              //     thumbnail: groupProvider.groupVideosModel[index].thumbnail,
                              //     video: groupProvider.groupVideosModel[index].video,
                              //     user: user,
                              //     watchId: DateTime.now().microsecondsSinceEpoch,
                              //     postId: groupProvider.groupVideosModel[index].id,
                              //     headerText: '',
                              //     createdAt: DateTime.now().toString(),
                              //     totalComment: 0,
                              //     commentUrl: '',
                              //     isLiked: false,
                              //     likedByUrl: '',
                              //     sharedByUrl: '',
                              //     totalLiked: 0,
                              //     totalShared: 0);
                              // Navigator.of(context).push(MaterialPageRoute(builder: (_) => VideoScreen(watchListModel)));
                            },
                            child: SizedBox(
                              height: 170,
                              child: Stack(
                                children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(3),
                                      child: customNetworkImage(groupProvider.groupVideosModel[index].thumbnail.toString())),
                                  Positioned(
                                    top: 0,
                                    bottom: 0,
                                    left: 0,
                                    right: 0,
                                    child: Center(
                                      child: SvgPicture.asset(ImagesModel.videoPlayIcon, height: 41, width: 42),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
            ],
          );
        }
    );
  }
}
