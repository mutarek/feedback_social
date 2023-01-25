import 'package:als_frontend/util/image.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/custom_text.dart';
import 'package:als_frontend/widgets/network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InvidivualGroupPage extends StatefulWidget {
  const InvidivualGroupPage({Key? key}) : super(key: key);

  @override
  State<InvidivualGroupPage> createState() => _InvidualGroupPageState();
}

class _InvidualGroupPageState extends State<InvidivualGroupPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: 200,
                    width: double.infinity,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25),
                        topRight: Radius.circular(25),
                      ),
                      child: customNetworkImage(
                          context, "https://porzoton.com/wp-content/uploads/2020/12/Sajek-Valley-Sun-rises-over-the-clouds.jpg",
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
                        Text("Public Group",
                            style: robotoStyle400Regular.copyWith(fontSize: 10)),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          flex: 3,
                          child: Card(
                            color: Colors.white,
                            elevation: 4,
                            shape:
                            const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10.0))),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                SvgPicture.asset(
                                  "assets/svg/joined_svgs.svg",
                                  height: 12,
                                  width: 12,
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  'Joined',
                                  style:
                                  robotoStyle700Bold.copyWith(fontSize: 15, color: AppColors.primaryColorLight),
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                SvgPicture.asset(
                                  "assets/svg/up_arrow.svg",
                                  height: 5,
                                  width: 10,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
