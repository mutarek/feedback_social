import 'package:als_frontend/data/model/response/page/page_details_model.dart';
import 'package:als_frontend/provider/other_provider.dart';
import 'package:als_frontend/provider/page_provider.dart';
import 'package:als_frontend/screens/other/choose_image_and_crop_image_view.dart';
import 'package:als_frontend/screens/video/widget/new_video_widgets.dart';
import 'package:als_frontend/util/image.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/network_image.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class NewPageDetailsHeaderWidget extends StatelessWidget {
  final PageDetailsModel pageDetailsModel;
  final int index;
  final bool isAdmin;

  const NewPageDetailsHeaderWidget(this.pageDetailsModel, this.index, this.isAdmin, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer2<OtherProvider, PageProvider>(
        builder: (context, otherProvider, pageProvider, child) => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                avatarAndCoverWidget(otherProvider, context),
                Padding(
                    padding: const EdgeInsets.only(left: 18),
                    child: Text(pageDetailsModel.name!, style: robotoStyle500Medium.copyWith(fontSize: 22))),
                const SizedBox(height: 2),
                Padding(
                  padding: const EdgeInsets.only(left: 18),
                  child: Row(
                    children: [
                      Container(
                        height: 15,
                        width: 15,
                        padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.primaryColorLight),
                        child: SvgPicture.asset(ImagesModel.followersIcons, color: Colors.white, width: 9, height: 9),
                      ),
                      const SizedBox(width: 2),
                      Text("Followers:", style: robotoStyle400Regular.copyWith(fontSize: 11, color: AppColors.primaryColorLight)),
                      Text(" ${pageDetailsModel.totalFollower}",
                          style: robotoStyle700Bold.copyWith(fontSize: 11, color: AppColors.primaryColorLight)),
                      const SizedBox(width: 10),
                      Container(
                        height: 15,
                        width: 15,
                        padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.primaryColorLight),
                        child: SvgPicture.asset(ImagesModel.followingIcons, color: Colors.white, width: 9, height: 9),
                      ),
                      const SizedBox(width: 2),
                      Text("Likes:", style: robotoStyle400Regular.copyWith(fontSize: 11, color: AppColors.primaryColorLight)),
                      Text(" ${pageDetailsModel.totalLike}",
                          style: robotoStyle700Bold.copyWith(fontSize: 11, color: AppColors.primaryColorLight)),
                      const SizedBox(width: 10),
                    ],
                  ),
                ),
                const SizedBox(height: 13),
              ],
            ));
  }

  Widget avatarAndCoverWidget(OtherProvider otherProvider, BuildContext context) {
    return Stack(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 165,
              child: Stack(
                children: [
                  customNetworkImage(pageDetailsModel.coverPhoto!, boxFit: BoxFit.fill),
                  !isAdmin
                      ? SizedBox.shrink()
                      : InkWell(
                          onTap: () {
                            otherProvider.clearImage();
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (_) => ChooseImageAndCropImageView(
                                      16,
                                      9,
                                      640,
                                      260,
                                      isCover: true,
                                      isPage: true,
                                      pageID: pageDetailsModel.id! as int,
                                      index: index,
                                    )));
                          },
                          child: Align(
                              alignment: Alignment.bottomRight,
                              child: Padding(
                                padding: const EdgeInsets.all(5),
                                child: Container(
                                  padding: const EdgeInsets.all(5),
                                  height: 35,
                                  width: 35,
                                  decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.primaryColorLight),
                                  child: const Icon(Icons.camera_alt, color: Colors.white),
                                ),
                              )),
                        ),
                ],
              ),
            ),
            const SizedBox(height: 35),
          ],
        ),
        Positioned(
          top: 100.0,
          left: 7, // (background container size) - (circle height / 2)
          child: Container(
            height: 90.0,
            width: 94.0,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
            ),
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(topLeft: Radius.circular(14), topRight: Radius.circular(14)),
                  child: customNetworkImage(pageDetailsModel.avatar!, boxFit: BoxFit.fill),
                ),
                !isAdmin
                    ? SizedBox.shrink()
                    : InkWell(
                        onTap: () {
                          otherProvider.clearImage();
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => ChooseImageAndCropImageView(
                                    1,
                                    1,
                                    150,
                                    150,
                                    isProfile: true,
                                    isPage: true,
                                    pageID: pageDetailsModel.id! as int,
                                    index: index,
                                  )));
                        },
                        child: Align(
                            alignment: Alignment.bottomRight,
                            child: Padding(
                              padding: const EdgeInsets.all(3),
                              child: Container(
                                padding: const EdgeInsets.all(1),
                                height: 25,
                                width: 25,
                                decoration: const BoxDecoration(shape: BoxShape.circle, color: AppColors.primaryColorLight),
                                child: const Icon(Icons.camera_alt, color: Colors.white, size: 15),
                              ),
                            )),
                      ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
