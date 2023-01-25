import 'package:als_frontend/provider/group_provider.dart';
import 'package:als_frontend/provider/other_provider.dart';
import 'package:als_frontend/provider/page_provider.dart';
import 'package:als_frontend/screens/group/new_design/create_group3.dart';
import 'package:als_frontend/screens/page/widget/page_app_bar.dart';
import 'package:als_frontend/util/helper.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/custom_button.dart';
import 'package:als_frontend/widgets/custom_text.dart';
import 'package:als_frontend/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateGroup2 extends StatefulWidget {
  const CreateGroup2({Key? key}) : super(key: key);

  @override
  State<CreateGroup2> createState() => _CreateGroup2State();
}

class _CreateGroup2State extends State<CreateGroup2> {
  final TextEditingController pageNameController = TextEditingController();
  final TextEditingController pageBioController = TextEditingController();
  final TextEditingController pageDetailsController = TextEditingController();
  final FocusNode nameFocus = FocusNode();
  final FocusNode bioFocus = FocusNode();
  final FocusNode detailsFocus = FocusNode();
  List<String> privacyModel = ["Public","Private"];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PageAppBar(title: 'Create Feedback Group'),
      body: Consumer3<OtherProvider, GroupProvider,PageProvider>(builder: (context, otherProvider, groupProvider,pageProvider, child) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                    title: "Select a privacy type for your group.", maxLines: 2, textStyle: robotoStyle500Medium.copyWith(fontSize: 17)),
                const SizedBox(height: 14),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15), border: Border.all(color: colorText), color: textFieldFillColor),
                  //decoration: BoxDecoration(color: const Color(0xFF656B87), borderRadius: BorderRadius.circular(15.0)),
                  child: DropdownButton<String>(
                    dropdownColor: textFieldFillColor,
                    hint:  Text('Select Privacy',style: robotoStyle400Regular.copyWith(fontSize: 18,color: Colors.grey)),
                    isExpanded: true,
                    underline: const SizedBox.shrink(),
                    icon: const Icon(Icons.arrow_drop_down_circle, color: AppColors.primaryColorLight),
                    items: privacyModel
                        .map((item) => DropdownMenuItem<String>(
                        value: item,
                        child: Container(
                            padding: const EdgeInsets.only(left: 10),
                            child: CustomText(
                                title: item,
                                textStyle: robotoStyle400Regular.copyWith(fontSize: 18, color: AppColors.primaryColorLight)))))
                        .toList(),
                    onChanged: (item) {
                      //pageProvider.changeGroupCategory(item!);
                    },
                  ),
                ),
                const SizedBox(height: 100),
                CustomText(
                    title: "Location Section", textStyle: robotoStyle500Medium.copyWith(fontSize: 17), maxLines: 2),
                Text("Please enter your valid location information so people can visit your place.",
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
                CustomTextField(
                  hintText: 'Enter your address',
                  isShowBorder: true,
                  borderRadius: 11,
                  verticalSize: 14,
                  maxLines: 4,
                  controller: pageDetailsController,
                  focusNode: detailsFocus,
                  inputAction: TextInputAction.done,
                ),
                const SizedBox(height: 30),
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
                      Helper.toScreen(const CreateGroup3());
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
