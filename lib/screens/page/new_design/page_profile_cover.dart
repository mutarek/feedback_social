import 'package:als_frontend/provider/other_provider.dart';
import 'package:als_frontend/provider/page_provider.dart';
import 'package:als_frontend/screens/other/choose_image_and_crop_image_view.dart';
import 'package:als_frontend/screens/page/widget/page_app_bar.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/custom_button.dart';
import 'package:als_frontend/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PageProfileCover extends StatefulWidget {
  const PageProfileCover({Key? key}) : super(key: key);

  @override
  State<PageProfileCover> createState() => _PageProfileCoverState();
}

class _PageProfileCoverState extends State<PageProfileCover> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PageAppBar(title: 'Create Feedback Page'),
      bottomSheet: Container(
        height: 48,
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
        child: CustomButton(
            btnTxt: 'Create',
            onTap: () {
              // Helper.toScreen(const PageProfileCover());
            },
            radius: 100,
            height: 48),
      ),
      body: Consumer2<OtherProvider, PageProvider>(builder: (context, otherProvider, pageProvider, child) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 5),
                CustomText(
                    title: "Want to make your page more attractive ?", maxLines: 2, textStyle: robotoStyle500Medium.copyWith(fontSize: 17)),
                const SizedBox(height: 4),
                Text("you must select a profile picture and cover photo that describe your page perfectly.",
                    style: robotoStyle400Regular.copyWith(fontSize: 10)),
                const SizedBox(height: 20),
                Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 165,
                          decoration: BoxDecoration(
                              borderRadius: const BorderRadius.only(
                                topLeft: Radius.circular(10),
                                topRight: Radius.circular(10),
                              ),
                              border: Border.all(color: AppColors.primaryColorLight, width: 1)),
                          child: Stack(
                            children: [
                              Container(
                                child: otherProvider.pageCoverFile != null
                                    ? ClipRRect(
                                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                                        child: Image.file(otherProvider.pageCoverFile!,
                                            width: MediaQuery.of(context).size.width, height: 200, fit: BoxFit.fill),
                                      )
                                    : ClipRRect(
                                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(11), topRight: Radius.circular(11)),
                                        child: Image.asset("assets/background/profile_placeholder.jpg",
                                            width: MediaQuery.of(context).size.width, height: 200, fit: BoxFit.fitWidth),
                                      ),
                              ),
                              InkWell(
                                onTap: () {
                                  otherProvider.clearImage();
                                  Navigator.of(context).push(
                                      MaterialPageRoute(builder: (_) => const ChooseImageAndCropImageView(16, 9, 640, 260, isCover: true)));
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
                        const SizedBox(height: 50),
                        CustomText(title: "Page Name Goes Here", maxLines: 2, textStyle: robotoStyle500Medium.copyWith(fontSize: 18)),
                        const SizedBox(height: 250),
                      ],
                    ),
                    Positioned(
                      top: 100.0,
                      left: 7, // (background container size) - (circle height / 2)
                      child: Container(
                        height: 90.0,
                        width: 94.0,
                        decoration: BoxDecoration(
                          border: Border.all(color: AppColors.primaryColorLight),
                          borderRadius: const BorderRadius.only(topLeft: Radius.circular(15), topRight: Radius.circular(15)),
                        ),
                        child: InkWell(
                          onTap: () {
                            otherProvider.clearImage();
                            Navigator.of(context).push(
                                MaterialPageRoute(builder: (_) => const ChooseImageAndCropImageView(1, 1, 150, 150, isProfile: true)));
                          },
                          child: Stack(
                            children: [
                              Container(
                                child: otherProvider.pageProfileFile != null
                                    ? ClipRRect(
                                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(14), topRight: Radius.circular(14)),
                                        child: Image.file(otherProvider.pageProfileFile!,
                                            width: MediaQuery.of(context).size.width, height: 200, fit: BoxFit.fill),
                                      )
                                    : ClipRRect(
                                        borderRadius: const BorderRadius.only(topLeft: Radius.circular(14), topRight: Radius.circular(14)),
                                        child: Image.asset("assets/background/profile_placeholder.jpg",
                                            width: MediaQuery.of(context).size.width, height: 200, fit: BoxFit.fitWidth),
                                      ),
                              ),
                              Align(
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
                            ],
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
