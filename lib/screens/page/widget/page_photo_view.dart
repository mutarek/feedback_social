import 'package:als_frontend/provider/page_provider.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PagePhotoView extends StatefulWidget {
  const PagePhotoView(this.widget, this.isAdmin,{Key? key}) : super(key: key);
  final Widget widget;
  final bool isAdmin;
  
  @override
  State<PagePhotoView> createState() => _PagePhotoViewState();
}

class _PagePhotoViewState extends State<PagePhotoView> {
  @override
  void initState() {
    Provider.of<PageProvider>(context, listen: false).pageAllPhotos(1);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Consumer<PageProvider>(

      builder: (context, pageProvider,child) {
        return ListView(

          physics: const BouncingScrollPhysics(),
          children: [
            SizedBox(
              height: 100,

                child: widget),
            // const SizedBox(
            //   height: 15,
            // ),
            // Padding(
            //   padding: const EdgeInsets.only(left: 18),
            //   child: Text(
            //     "All Photos",
            //     style: GoogleFonts.roboto(fontWeight: FontWeight.w700, fontSize: 15, color: AppColors.primaryColorLight),
            //   ),
            // ),
            // const SizedBox(height: 5,),
            // Padding(
            //   padding: const EdgeInsets.only(left: 0),
            //   child: MasonryGridView.count(
            //
            //     crossAxisCount: 2,
            //     crossAxisSpacing: 8,
            //     mainAxisSpacing: 10,
            //     shrinkWrap: true,
            //     physics: const NeverScrollableScrollPhysics(),
            //     itemCount: pageProvider.pagePhotosModel.length > 4 ? 4 :pageProvider.pagePhotosModel.length,
            //     itemBuilder: (context, index) {
            //       return Container(
            //         height: 30,
            //         width: 100,
            //         color: Colors.yellow,
            //       );
            //     },
            //   ),
            // ),
            const SizedBox(height: 5,),
            // Padding(
            //   padding: const EdgeInsets.only(left: 18),
            //   child: Text(
            //     "All Videos",
            //     style: GoogleFonts.roboto(fontWeight: FontWeight.w700, fontSize: 15, color: AppColors.primaryColorLight),
            //   ),
            // ),
            // const SizedBox(height: 5,),
            // Padding(
            //     padding: const EdgeInsets.only(left: 0),
            //     child: SizedBox(
            //       height: 250,
            //       width: double.infinity,
            //       child: Row(
            //         children: [
            //           Expanded(
            //             flex: 1,
            //             child: Stack(
            //               children: [
            //                 Container(
            //                   margin: const EdgeInsets.only(right: 1),
            //                   height: 250,
            //                   color: AppColors.imageBGColorLight,
            //                 ),
            //                 Align(
            //                   alignment: Alignment.center,
            //                   child: SvgPicture.asset(
            //                     "assets/svg/page_video_play_icon.svg",
            //                     height: 41,
            //                     width: 42,
            //                   ),
            //                 )
            //               ],
            //             )
            //           ),
            //           Expanded(
            //               flex: 1,
            //               child:Column(
            //                 children: [
            //                   Expanded(
            //                     flex: 1,
            //                     child: Stack(
            //                       children: [
            //                         Container(
            //                           margin: const EdgeInsets.only(bottom: 1),
            //                           height: 250,
            //                           color: AppColors.imageBGColorLight,
            //                         ),
            //                         Align(
            //                           alignment: Alignment.center,
            //                           child: SvgPicture.asset(
            //                             "assets/svg/page_video_play_icon.svg",
            //                             height: 41,
            //                             width: 42,
            //                           ),
            //                         )
            //                       ],
            //                     )
            //                   ),
            //                   Expanded(
            //                     flex: 1,
            //                     child: Stack(
            //                       children: [
            //                         Container(
            //                           height: 250,
            //                           color: AppColors.imageBGColorLight,
            //                         ),
            //                         Align(
            //                           alignment: Alignment.center,
            //                           child: SvgPicture.asset(
            //                             "assets/svg/page_video_play_icon.svg",
            //                             height: 41,
            //                             width: 42,
            //                           ),
            //                         )
            //                       ],
            //                     )
            //                   ),
            //                 ],
            //               )
            //           )
            //         ],
            //       ),
            //     )
            // ),
          ],
        );
      }
    );
  }
}
