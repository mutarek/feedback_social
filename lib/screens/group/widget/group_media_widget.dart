import 'package:als_frontend/provider/group_provider.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

import '../../../util/theme/text.styles.dart';

class GroupMediaWidget extends StatelessWidget {
  const GroupMediaWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<GroupProvider>(builder: (context, groupProvider, child) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 18),
            child: Text(
              "All Photos",
              style: robotoStyle700Bold.copyWith(fontSize: 15,color: AppColors.primaryColorLight)
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
              style: robotoStyle700Bold.copyWith(fontSize: 15,color: AppColors.primaryColorLight),
            ),
          ),
          const SizedBox(height: 10),
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
      );
    });
  }
}
