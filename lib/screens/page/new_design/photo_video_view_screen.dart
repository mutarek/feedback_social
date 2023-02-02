import 'package:als_frontend/data/model/response/watch_list_model.dart';
import 'package:als_frontend/provider/page_provider.dart';
import 'package:als_frontend/screens/video/video_screen.dart';
import 'package:als_frontend/screens/video/widget/new_video_widgets.dart';
import 'package:als_frontend/util/helper.dart';
import 'package:als_frontend/util/image.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/network_image.dart';
import 'package:als_frontend/widgets/single_image_view.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class PhotoVideoViewScreen extends StatelessWidget {
  final bool isPhotoView;

  const PhotoVideoViewScreen(this.isPhotoView, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<PageProvider>(builder: (context, pageProvider, child) {
      return Scaffold(
        body: ListView(
          children: [
            isPhotoView
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Padding(
                          padding: const EdgeInsets.only(left: 7, right: 7),
                          child: Text("All Photos:", style: robotoStyle700Bold.copyWith(fontSize: 16))),
                      const Divider(color: colorText, thickness: 2),
                      Padding(
                        padding: const EdgeInsets.only(left: 7, right: 7),
                        child: MasonryGridView.count(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 10,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: pageProvider.pagePhotosModel.length > 4 ? 4 : pageProvider.pagePhotosModel.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Helper.toScreen(SingleImageView(imageURL: pageProvider.pagePhotosModel[index].image!));
                              },
                              child: SizedBox(
                                  height: 130,
                                  child: ClipRRect(
                                      borderRadius: BorderRadius.circular(3),
                                      child:
                                          customNetworkImage(pageProvider.pagePhotosModel[index].image.toString(), boxFit: BoxFit.cover))),
                            );
                          },
                        ),
                      ),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),
                      Padding(
                          padding: const EdgeInsets.only(left: 7, right: 7),
                          child: Text("All Videos:", style: robotoStyle700Bold.copyWith(fontSize: 16))),
                      const Divider(color: colorText, thickness: 2),
                      Padding(
                        padding: const EdgeInsets.only(left: 7, right: 7),
                        child: MasonryGridView.count(
                          crossAxisCount: 2,
                          crossAxisSpacing: 8,
                          mainAxisSpacing: 10,
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: pageProvider.videosLists.length > 4 ? 4 : pageProvider.videosLists.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                User user = User(
                                    id: pageProvider.pageDetailsModel.author!.id,
                                    fullName: pageProvider.pageDetailsModel.author!.fullName,
                                    profileImage: pageProvider.pageDetailsModel.author!.profileImage);

                                WatchListModel watchListModel = WatchListModel(
                                    thumbnail: pageProvider.videosLists[index].thumbnail,
                                    video: pageProvider.videosLists[index].video,
                                    user: user,
                                    watchId: DateTime.now().microsecondsSinceEpoch,
                                    postId: pageProvider.videosLists[index].id,
                                    headerText: '',
                                    createdAt: DateTime.now().toString(),
                                    totalComment: 0,
                                    commentUrl: '',
                                    isLiked: false,
                                    likedByUrl: '',
                                    sharedByUrl: '',
                                    totalLiked: 0,
                                    totalShared: 0);
                                Navigator.of(context).push(MaterialPageRoute(builder: (_) => VideoScreen(watchListModel)));
                              },
                              child: SizedBox(
                                height: 170,
                                child: Stack(
                                  children: [
                                    ClipRRect(
                                        borderRadius: BorderRadius.circular(3),
                                        child: customNetworkImage(pageProvider.videosLists[index].thumbnail.toString())),
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
                      )
                    ],
                  )
          ],
        ),
      );
    });
  }
}
