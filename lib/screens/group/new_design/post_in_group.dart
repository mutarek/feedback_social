import 'package:als_frontend/screens/group/widget/group_header.dart';
import 'package:als_frontend/util/image.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PostInGroupScreen extends StatelessWidget {
  const PostInGroupScreen(this.widget, {Key? key}) : super(key: key);
  final Widget widget;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const GroupHeaderWidget(),
            widget,
            const SizedBox(height: 9),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Row(
                children: [
                  Container(
                    height: 36,
                    width: 36,
                    decoration: const BoxDecoration(color: Colors.yellow, shape: BoxShape.circle),
                  ),
                  const SizedBox(width: 7),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Rafatul Islam", style: robotoStyle700Bold.copyWith(fontSize: 14)),
                      Container(
                        height: 20,
                        width: 71,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: AppColors.primaryColorLight)),
                        child: Padding(
                          padding: const EdgeInsets.all(3.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SvgPicture.asset(ImagesModel.earthIcons),
                              Text("Anyone", style: robotoStyle500Medium.copyWith(fontSize: 10)),
                              PopupMenuButton(
                                itemBuilder: (context) => [
                                  // PopupMenuItem 1
                                  PopupMenuItem(
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SvgPicture.asset(ImagesModel.earthIcons),
                                            const SizedBox(
                                              width: 7,
                                            ),
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Anyone",
                                                  style:
                                                      robotoStyle500Medium.copyWith(fontSize: 10),
                                                ),
                                                Text(
                                                  "Anyone on feedback",
                                                  style: robotoStyle500Medium.copyWith(
                                                      fontSize: 7,
                                                      color: AppColors.hintTextColorLight),
                                                )
                                              ],
                                            )
                                          ],
                                        ),
                                        const SizedBox(
                                          height: 7,
                                        ),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.start,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            SvgPicture.asset(ImagesModel.earthIcons),
                                            const SizedBox(
                                              width: 7,
                                            ),
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Members only",
                                                  style:
                                                      robotoStyle500Medium.copyWith(fontSize: 10),
                                                ),
                                                Text(
                                                  "Members of the group only",
                                                  style: robotoStyle500Medium.copyWith(
                                                      fontSize: 7,
                                                      color: AppColors.hintTextColorLight),
                                                )
                                              ],
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                  // PopupMenuItem 2
                                ],
                                offset: const Offset(-60, 20),
                                color: Colors.white,
                                elevation: 4,
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                child: Container(
                                  height: 10,
                                  width: 10,
                                  decoration: const BoxDecoration(
                                      shape: BoxShape.circle, color: AppColors.primaryColorLight),
                                  child: const Icon(
                                    Icons.arrow_drop_down,
                                    size: 10,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 15),
                child: Container(
                  height: 138,
                  width: width,
                  decoration: BoxDecoration(
                      border: Border.all(color: AppColors.primaryColorLight),
                      borderRadius: BorderRadius.circular(10)),
                  child: Column(
                    children: [
                      Expanded(
                        child: TextFormField(
                          maxLines: null,
                          decoration: InputDecoration(
                              hintText: "What do you want to discuss? Submit here for admin approval...",
                              hintStyle: robotoStyle400Regular.copyWith(
                                  fontSize: 16, color: AppColors.hintTextColorLight),
                          border: InputBorder.none),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left:10,bottom: 5),
                        child: Row(
                          children: [
                            SvgPicture.asset(ImagesModel.wowReaction),
                            const SizedBox(width:5),
                            SvgPicture.asset(ImagesModel.photoAdd),
                            const SizedBox(width:5),
                            SvgPicture.asset(ImagesModel.videoAdd)
                          ],
                        ),
                      )
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
