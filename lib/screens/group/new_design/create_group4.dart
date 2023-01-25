import 'package:als_frontend/provider/group_provider.dart';
import 'package:als_frontend/provider/other_provider.dart';
import 'package:als_frontend/screens/other/choose_image_and_crop_image_view.dart';
import 'package:als_frontend/screens/page/widget/page_app_bar.dart';
import 'package:als_frontend/util/helper.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/custom_button.dart';
import 'package:als_frontend/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateGroup4 extends StatefulWidget {
  const CreateGroup4({Key? key}) : super(key: key);

  @override
  State<CreateGroup4> createState() => _CreateGroup4State();
}

class _CreateGroup4State extends State<CreateGroup4> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PageAppBar(title: 'Create Feedback Group'),
      body: Consumer2<OtherProvider, GroupProvider>(builder: (context, otherProvider, groupProvider, child) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                    title: "Want to make your page more attractive?", maxLines: 2, textStyle: robotoStyle500Medium.copyWith(fontSize: 17)),
                Text("You must select a cover photo that describe your page perfectly.",
                    style: robotoStyle400Regular.copyWith(fontSize: 10)),
                SizedBox(height: 10),
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
                                  borderRadius:
                                  const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10)),
                                  child: Image.file(otherProvider.pageCoverFile!,
                                      width: MediaQuery.of(context).size.width, height: 200, fit: BoxFit.fill),
                                )
                                    : ClipRRect(
                                  borderRadius:
                                  const BorderRadius.only(topLeft: Radius.circular(11), topRight: Radius.circular(11)),
                                  child: Image.asset("assets/background/profile_placeholder.jpg",
                                      width: MediaQuery.of(context).size.width, height: 200, fit: BoxFit.fitWidth),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  otherProvider.clearImage();
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (_) => const ChooseImageAndCropImageView(16, 9, 640, 260, isCover: true)));
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
                        CustomText(title: 'Exam helping group bd', maxLines: 2, textStyle: robotoStyle500Medium.copyWith(fontSize: 18)),
                        const SizedBox(height: 450),
                      ],
                    ),

                  ],
                ),
                CustomButton(
                    btnTxt: 'Next Page',
                    onTap: () {
                      // if (pageNameController.text.isEmpty || pageBioController.text.isEmpty || pageDetailsController.text.isEmpty) {
                      //   showMessage(message: 'Please write all the information');
                      // } else if (pageBioController.text.length > 90) {
                      //   showMessage(message: 'please insert BIO at Most 90 characters');
                      // } else {
                      //   //Helper.toScreen(const CreatePageScreen2());
                      // }
                      Helper.toScreen(const CreateGroup4());
                    },
                    radius: 100,
                    height: 48),
              ],
            ),
          ),
        );
      }),
    );
  }
}
