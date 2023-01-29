import 'package:als_frontend/util/image.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/custom_text.dart';
import 'package:als_frontend/widgets/network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GroupHeaderWidget extends StatelessWidget {
  const GroupHeaderWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Stack(
          children: [
            SizedBox(
              height: 200,
              width: double.infinity,
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
                child: customNetworkImage("https://porzoton.com/wp-content/uploads/2020/12/Sajek-Valley-Sun-rises-over-the-clouds.jpg",
                    boxFit: BoxFit.fitWidth),
              ),
            ),
            const Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.all(15),
                  child: Icon(Icons.arrow_back, color: Colors.white),
                ))
          ],
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                  title: "Exam Helping BD",
                  maxLines: 1,
                  textStyle: robotoStyle500Medium.copyWith(fontSize: 20, color: AppColors.primaryColorLight)),
              const SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SvgPicture.asset(ImagesModel.groupMemberIcon, height: 12, width: 20, color: AppColors.primaryColorLight),
                  const SizedBox(width: 5),
                  const Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(text: 'Members: '),
                        TextSpan(
                          text: '5M',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 10),
                  SvgPicture.asset(ImagesModel.publicGroupIcon, height: 12, width: 20, color: AppColors.primaryColorLight),
                  const SizedBox(width: 5),
                  Text("Public Group", style: robotoStyle400Regular.copyWith(fontSize: 10)),
                ],
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Expanded(
                    flex: 3,
                    child: SizedBox(
                      height: 48,
                      child: Card(
                        color: const Color(0xff080C2F),
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              "assets/svg/joined_svgs.svg",
                              height: 12,
                              width: 12,
                              color: Colors.white,
                            ),
                            const SizedBox(
                              width: 2,
                            ),
                            Text(
                              'Joined',
                              style: robotoStyle700Bold.copyWith(fontSize: 15, color: Colors.white),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xff080C2F)),
                        borderRadius: BorderRadius.circular(8),
                        color: const Color(0xffE7F3FF),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            "assets/svg/joined_svgs.svg",
                            height: 12,
                            width: 12,
                          ),
                          const SizedBox(
                            width: 2,
                          ),
                          Text(
                            'Invite',
                            style: robotoStyle700Bold.copyWith(fontSize: 15, color: AppColors.primaryColorLight),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 5),
                  Expanded(
                    flex: 1,
                    child: Container(
                      height: 40,
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xff080C2F)),
                        borderRadius: BorderRadius.circular(8),
                        color: const Color(0xffE7F3FF),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.more_horiz,
                            color: AppColors.primaryColorLight,
                            size: 12,
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(thickness: 1, color: Color(0xffE4E6EB))
            ],
          ),
        ),
      ],
    );
  }
}
