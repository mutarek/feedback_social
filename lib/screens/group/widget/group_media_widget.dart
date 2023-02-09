import 'package:als_frontend/provider/group_provider.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../data/model/response/each_author_group_model.dart';
import '../../../util/theme/text.styles.dart';
import '../../../widgets/network_image.dart';

class GroupMediaWidget extends StatefulWidget {
  final AuthorEachGroupModel authorEachGroupModel;
  final int index;
  const GroupMediaWidget(this.authorEachGroupModel,this.index,{Key? key}) : super(key: key);

  @override
  State<GroupMediaWidget> createState() => _GroupMediaWidgetState();
}

class _GroupMediaWidgetState extends State<GroupMediaWidget> {
  @override
  void initState() {
    Provider.of<GroupProvider>(context, listen: false).getForGetAllPhotosVideos();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<GroupProvider>(builder: (context, groupProvider, child) {
      return Column(
       children: [
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
                           //Helper.toScreen(const PhotoVideoViewScreen(true));
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
                       //Helper.toScreen(SingleImageView(imageURL: pageProvider.pagePhotosModel[index].image!));
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
             // Padding(
             //     padding: const EdgeInsets.only(left: 7, right: 7),
             //     child: Row(
             //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
             //       children: [
             //         Text("All Videos:", style: robotoStyle700Bold.copyWith(fontSize: 15)),
             //         pageProvider.videosLists.length > 4
             //             ? TextButton(
             //             onPressed: () {
             //               Helper.toScreen(const PhotoVideoViewScreen(false));
             //             },
             //             child: Text('View More', style: robotoStyle500Medium))
             //             : const SizedBox.shrink()
             //       ],
             //     )),
             // SizedBox(
             //     height: pageProvider.videosLists.length > 4
             //         ? 0
             //         : pageProvider.videosLists.isEmpty
             //         ? 70
             //         : 10),
             // pageProvider.videosLists.isEmpty
             //     ? Center(child: Text("There has no videos", style: robotoStyle500Medium))
             //     : Padding(
             //   padding: const EdgeInsets.only(left: 7, right: 7),
             //   child: MasonryGridView.count(
             //     crossAxisCount: 2,
             //     crossAxisSpacing: 8,
             //     mainAxisSpacing: 10,
             //     shrinkWrap: true,
             //     physics: const NeverScrollableScrollPhysics(),
             //     itemCount: pageProvider.videosLists.length > 4 ? 4 : pageProvider.videosLists.length,
             //     itemBuilder: (context, index) {
             //       return InkWell(
             //         onTap: () {
             //           User user = User(
             //               id: pageProvider.pageDetailsModel.author!.id,
             //               fullName: pageProvider.pageDetailsModel.author!.fullName,
             //               profileImage: pageProvider.pageDetailsModel.author!.profileImage);
             //
             //           WatchListModel watchListModel = WatchListModel(
             //               thumbnail: pageProvider.videosLists[index].thumbnail,
             //               video: pageProvider.videosLists[index].video,
             //               user: user,
             //               watchId: DateTime.now().microsecondsSinceEpoch,
             //               postId: pageProvider.videosLists[index].id,
             //               headerText: '',
             //               createdAt: DateTime.now().toString(),
             //               totalComment: 0,
             //               commentUrl: '',
             //               isLiked: false,
             //               likedByUrl: '',
             //               sharedByUrl: '',
             //               totalLiked: 0,
             //               totalShared: 0);
             //           Navigator.of(context).push(MaterialPageRoute(builder: (_) => VideoScreen(watchListModel)));
             //         },
             //         child: SizedBox(
             //           height: 170,
             //           child: Stack(
             //             children: [
             //               ClipRRect(
             //                   borderRadius: BorderRadius.circular(3),
             //                   child: customNetworkImage(pageProvider.videosLists[index].thumbnail.toString())),
             //               Positioned(
             //                 top: 0,
             //                 bottom: 0,
             //                 left: 0,
             //                 right: 0,
             //                 child: Center(
             //                   child: SvgPicture.asset(ImagesModel.videoPlayIcon, height: 41, width: 42),
             //                 ),
             //               )
             //             ],
             //           ),
             //         ),
             //       );
             //     },
             //   ),
             // ),
           ],
         ),
       ],
        // children: [
        //   // const SizedBox(
        //   //   height: 15,
        //   // ),
        //   // Padding(
        //   //   padding: const EdgeInsets.only(left: 18),
        //   //   child: Text(
        //   //     "All Photos",
        //   //     style: robotoStyle700Bold.copyWith(fontSize: 15,color: AppColors.primaryColorLight)
        //   //   ),
        //   // ),
        //   // const SizedBox(height: 5,),
        //   // Padding(
        //   //     padding: const EdgeInsets.only(left: 0),
        //   //     child: SizedBox(
        //   //       height: 250,
        //   //       width: double.infinity,
        //   //       child: Row(
        //   //         children: [
        //   //           Expanded(
        //   //             flex: 1,
        //   //             child: Container(
        //   //               margin: const EdgeInsets.only(right: 1),
        //   //               height: 250,
        //   //               color: AppColors.imageBGColorLight,
        //   //             ),
        //   //           ),
        //   //           Expanded(
        //   //               flex: 1,
        //   //               child:Column(
        //   //                 children: [
        //   //                   Expanded(
        //   //                     flex: 1,
        //   //                     child: Container(
        //   //                       margin: const EdgeInsets.only(bottom: 1),
        //   //                       color: AppColors.imageBGColorLight,
        //   //                     ),
        //   //                   ),
        //   //                   Expanded(
        //   //                     flex: 1,
        //   //                     child: Container(
        //   //                       color: AppColors.imageBGColorLight,
        //   //                     ),
        //   //                   ),
        //   //                 ],
        //   //               )
        //   //           )
        //   //         ],
        //   //       ),
        //   //     )
        //   // ),
        //   // const SizedBox(height: 5,),
        //   // Padding(
        //   //   padding: const EdgeInsets.only(left: 18),
        //   //   child: Text(
        //   //     "All Videos",
        //   //     style: robotoStyle700Bold.copyWith(fontSize: 15,color: AppColors.primaryColorLight),
        //   //   ),
        //   // ),
        //   // const SizedBox(height: 10),
        //   // Padding(
        //   //     padding: const EdgeInsets.only(left: 0),
        //   //     child: SizedBox(
        //   //       height: 250,
        //   //       width: double.infinity,
        //   //       child: Row(
        //   //         children: [
        //   //           Expanded(
        //   //               flex: 1,
        //   //               child: Stack(
        //   //                 children: [
        //   //                   Container(
        //   //                     margin: const EdgeInsets.only(right: 1),
        //   //                     height: 250,
        //   //                     color: AppColors.imageBGColorLight,
        //   //                   ),
        //   //                   Align(
        //   //                     alignment: Alignment.center,
        //   //                     child: SvgPicture.asset(
        //   //                       "assets/svg/page_video_play_icon.svg",
        //   //                       height: 41,
        //   //                       width: 42,
        //   //                     ),
        //   //                   )
        //   //                 ],
        //   //               )
        //   //           ),
        //   //           Expanded(
        //   //               flex: 1,
        //   //               child:Column(
        //   //                 children: [
        //   //                   Expanded(
        //   //                       flex: 1,
        //   //                       child: Stack(
        //   //                         children: [
        //   //                           Container(
        //   //                             margin: const EdgeInsets.only(bottom: 1),
        //   //                             height: 250,
        //   //                             color: AppColors.imageBGColorLight,
        //   //                           ),
        //   //                           Align(
        //   //                             alignment: Alignment.center,
        //   //                             child: SvgPicture.asset(
        //   //                               "assets/svg/page_video_play_icon.svg",
        //   //                               height: 41,
        //   //                               width: 42,
        //   //                             ),
        //   //                           )
        //   //                         ],
        //   //                       )
        //   //                   ),
        //   //                   Expanded(
        //   //                       flex: 1,
        //   //                       child: Stack(
        //   //                         children: [
        //   //                           Container(
        //   //                             height: 250,
        //   //                             color: AppColors.imageBGColorLight,
        //   //                           ),
        //   //                           Align(
        //   //                             alignment: Alignment.center,
        //   //                             child: SvgPicture.asset(
        //   //                               "assets/svg/page_video_play_icon.svg",
        //   //                               height: 41,
        //   //                               width: 42,
        //   //                             ),
        //   //                           )
        //   //                         ],
        //   //                       )
        //   //                   ),
        //   //                 ],
        //   //               )
        //   //           )
        //   //         ],
        //   //       ),
        //   //     )
        //   // ),
        // ],
      );
    });
  }
}
