import 'package:als_frontend/data/model/response/page/athour_pages_model.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class PagePhotoView extends StatefulWidget {
  const PagePhotoView(this.widget, this.isAdmin,{Key? key}) : super(key: key);
  final Widget widget;
  final bool isAdmin;
  
  @override
  State<PagePhotoView> createState() => _PagePhotoViewState();
}

class _PagePhotoViewState extends State<PagePhotoView> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          widget,
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18),
            child: Text(
              "All Photos",
              style: GoogleFonts.roboto(fontWeight: FontWeight.w700, fontSize: 15, color: AppColors.primaryColorLight),
            ),
          ),
          const SizedBox(height: 5,),
          Padding(
            padding: const EdgeInsets.only(left: 0),
            child: SizedBox(
              height: 250,
              width: double.infinity,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      margin: const EdgeInsets.only(right: 1),
                      height: 250,
                      color: AppColors.imageBGColorLight,
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child:Column(
                      children: [
                        Expanded(
                          flex: 1,
                          child: Container(
                            margin: const EdgeInsets.only(bottom: 1),
                            color: AppColors.imageBGColorLight,
                          ),
                        ),
                        Expanded(
                          flex: 1,
                          child: Container(
                            color: AppColors.imageBGColorLight,
                          ),
                        ),
                      ],
                    )
                  )
                ],
              ),
            )
          ),
          const SizedBox(height: 5,),
          Padding(
            padding: const EdgeInsets.only(left: 18),
            child: Text(
              "All Videos",
              style: GoogleFonts.roboto(fontWeight: FontWeight.w700, fontSize: 15, color: AppColors.primaryColorLight),
            ),
          ),
          const SizedBox(height: 5,),
          Padding(
              padding: const EdgeInsets.only(left: 0),
              child: SizedBox(
                height: 250,
                width: double.infinity,
                child: Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Stack(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(right: 1),
                            height: 250,
                            color: AppColors.imageBGColorLight,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: SvgPicture.asset(
                              "assets/svg/page_video_play_icon.svg",
                              height: 41,
                              width: 42,
                            ),
                          )
                        ],
                      )
                    ),
                    Expanded(
                        flex: 1,
                        child:Column(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Stack(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.only(bottom: 1),
                                    height: 250,
                                    color: AppColors.imageBGColorLight,
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: SvgPicture.asset(
                                      "assets/svg/page_video_play_icon.svg",
                                      height: 41,
                                      width: 42,
                                    ),
                                  )
                                ],
                              )
                            ),
                            Expanded(
                              flex: 1,
                              child: Stack(
                                children: [
                                  Container(
                                    height: 250,
                                    color: AppColors.imageBGColorLight,
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: SvgPicture.asset(
                                      "assets/svg/page_video_play_icon.svg",
                                      height: 41,
                                      width: 42,
                                    ),
                                  )
                                ],
                              )
                            ),
                          ],
                        )
                    )
                  ],
                ),
              )
          ),
        ],
      ),
    );
  }
}
