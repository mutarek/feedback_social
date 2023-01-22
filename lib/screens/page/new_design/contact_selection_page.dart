import 'package:als_frontend/provider/page_provider.dart';
import 'package:als_frontend/screens/page/new_design/page_profile_cover.dart';
import 'package:als_frontend/screens/page/widget/page_app_bar.dart';
import 'package:als_frontend/util/helper.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/custom_button.dart';
import 'package:als_frontend/widgets/custom_text.dart';
import 'package:als_frontend/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../provider/other_provider.dart';
import '../../../util/theme/app_colors.dart';

class ContactSelectionPage extends StatefulWidget {
  const ContactSelectionPage({Key? key}) : super(key: key);

  @override
  State<ContactSelectionPage> createState() => _ContactSelectionPageState();
}

class _ContactSelectionPageState extends State<ContactSelectionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PageAppBar(title: 'Create Feedback Page'),
      body: Consumer2<OtherProvider, PageProvider>(builder: (context, otherProvider, pageProvider, child) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(title: "Contact Selection", maxLines: 2, textStyle: robotoStyle500Medium.copyWith(fontSize: 17)),
                const SizedBox(height: 4),
                Text("Please enter your valid contact information so people can reach with you easily.",
                    style: robotoStyle400Regular.copyWith(fontSize: 10)),
                const SizedBox(height: 20),
                const CustomTextField(hintText: 'Enter Contact Number', isShowBorder: true, borderRadius: 11, verticalSize: 14),
                const SizedBox(height: 15),
                const CustomTextField(hintText: 'Enter Email', isShowBorder: true, borderRadius: 11, verticalSize: 14),
                const SizedBox(height: 15),
                const CustomTextField(hintText: 'Enter Your Website Link', isShowBorder: true, borderRadius: 11, verticalSize: 14),
                const SizedBox(height: 15),
                CustomText(title: "Location Selection", maxLines: 2, textStyle: robotoStyle500Medium.copyWith(fontSize: 17)),
                const SizedBox(height: 4),
                Text("Please enter your valid location place so people can visit your place.",
                    style: robotoStyle400Regular.copyWith(fontSize: 10)),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15), border: Border.all(color: colorText), color: textFieldFillColor),
                  child: InkWell(
                    onTap: () {
                      pageProvider.pickupCountry(context);
                    },
                    child: Row(
                      children: [
                        Expanded(child: Text(pageProvider.countryName, style: robotoStyle400Regular.copyWith(fontSize: 17))),
                        const CircleAvatar(
                          backgroundColor: AppColors.primaryColorLight,
                          radius: 20,
                          child: Center(child: Icon(Icons.arrow_drop_down, color: Colors.white, size: 20)),
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const CustomTextField(hintText: 'Enter Your Address', isShowBorder: true, borderRadius: 11, verticalSize: 14, maxLines: 3),
                const SizedBox(height: 30),

                CustomButton(
                    btnTxt: 'Next Page',
                    onTap: () {
                      otherProvider.clearCoverProfile();
                      Helper.toScreen(const PageProfileCover());
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
