import 'package:als_frontend/provider/group_provider.dart';
import 'package:als_frontend/provider/other_provider.dart';
import 'package:als_frontend/screens/group/new_design/create_group2.dart';
import 'package:als_frontend/screens/page/widget/page_app_bar.dart';
import 'package:als_frontend/util/helper.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/custom_button.dart';
import 'package:als_frontend/widgets/custom_text.dart';
import 'package:als_frontend/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../data/model/response/category_model.dart';
import '../../../widgets/snackbar_message.dart';

class CreateGroup1 extends StatefulWidget {
  const CreateGroup1({Key? key}) : super(key: key);

  @override
  State<CreateGroup1> createState() => _CreateGroup1State();
}

class _CreateGroup1State extends State<CreateGroup1> {

  @override
  void initState() {
    Provider.of<GroupProvider>(context,listen: false).initializeCategory();
    super.initState();
  }

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
      body: Consumer2<OtherProvider, GroupProvider>(builder: (context, otherProvider, groupProvider, child) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                    title: "Want to chose a name for your group?", maxLines: 2, textStyle: robotoStyle500Medium.copyWith(fontSize: 17)),
                const SizedBox(height: 4),
                Text("Chose a unique name for your business, organizations, shop, or a name that helps to explore your group.",
                    style: robotoStyle400Regular.copyWith(fontSize: 10)),
                const SizedBox(height: 10),
                CustomTextField(
                  hintText: 'Your Group name',
                  isShowBorder: true,
                  borderRadius: 11,
                  verticalSize: 14,
                  controller: pageNameController,
                  focusNode: nameFocus,
                  nextFocus: bioFocus,
                ),
                const SizedBox(height: 19),
                CustomText(
                    title: "Select a privacy type for your group.",
                    textStyle: robotoStyle500Medium.copyWith(fontSize: 17),
                    maxLines: 2),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15), border: Border.all(color: colorText), color: textFieldFillColor),
                  //decoration: BoxDecoration(color: const Color(0xFF656B87), borderRadius: BorderRadius.circular(15.0)),
                  child: DropdownButton<String>(
                    dropdownColor: textFieldFillColor,
                    hint:  Text(groupProvider.privacy,style: robotoStyle400Regular.copyWith(fontSize: 18,color: Colors.grey)),
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
                      groupProvider.changeGroupPrivacy(item!);
                    },
                  ),
                ),
                const SizedBox(height: 19),
                CustomText(
                    title: "Select a Group category",
                    textStyle: robotoStyle500Medium.copyWith(fontSize: 17),
                    maxLines: 2),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15), border: Border.all(color: colorText), color: textFieldFillColor),
                  //decoration: BoxDecoration(color: const Color(0xFF656B87), borderRadius: BorderRadius.circular(15.0)),
                  child: DropdownButton<CategoryModel>(
                    dropdownColor: textFieldFillColor,
                    value: groupProvider.categoryValue,
                    isExpanded: true,
                    underline: const SizedBox.shrink(),
                    icon: const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.primaryColorLight),
                    items: groupProvider.items
                        .map((item) => DropdownMenuItem<CategoryModel>(
                        value: item,
                        child: Container(
                            padding: const EdgeInsets.only(left: 10),
                            child: CustomText(
                                title: item.name,
                                textStyle: robotoStyle400Regular.copyWith(fontSize: 18, color: AppColors.primaryColorLight)))))
                        .toList(),
                    onChanged: (item) {
                      groupProvider.changeGroupCategory(item!);
                    },
                  ),
                ),
                const SizedBox(height: 10),
                CustomText(
                    title: "Tell a little bit about your group.", textStyle: robotoStyle500Medium.copyWith(fontSize: 17), maxLines: 2),
                const SizedBox(height: 10),
                CustomTextField(
                  hintText: 'Enter description',
                  isShowBorder: true,
                  borderRadius: 11,
                  verticalSize: 14,
                  maxLines: 4,
                  controller: pageDetailsController,
                  focusNode: detailsFocus,
                  inputAction: TextInputAction.done,
                ),
                const SizedBox(height: 10),
                CustomText(title: "Tell a a short intro about your group.", textStyle: robotoStyle500Medium.copyWith(fontSize: 17), maxLines: 1),
                Text("Intro is first expression that user can understand your goal.",
                    style: robotoStyle400Regular.copyWith(fontSize: 10)),
                const SizedBox(height: 10),
                CustomTextField(
                  hintText: 'Enter short intro',
                  isShowBorder: true,
                  borderRadius: 11,
                  verticalSize: 14,
                  controller: pageBioController,
                  focusNode: bioFocus,
                  nextFocus: detailsFocus,
                ),
                const SizedBox(height: 30),
                CustomButton(
                    btnTxt: 'Next Page',
                    onTap: () {
                      if (pageNameController.text.isEmpty || pageBioController.text.isEmpty || pageDetailsController.text.isEmpty) {
                        showMessage(message: 'Please write all the information');
                      } else if (pageBioController.text.length > 90) {
                        showMessage(message: 'please insert BIO at Most 90 characters');
                      }else if(groupProvider.privacy =="Select Privacy"){
                        showMessage(message: 'Please select privacy');
                      }
                      else {
                        groupProvider.updateInsertGroupInfo(0,
                            aGroupName: pageNameController.text,
                            aGroupBio: pageBioController.text,
                            aGroupDescription: pageDetailsController.text,
                          aGroupPrivacy:  groupProvider.privacy
                        );
                        Helper.toScreen(const CreateGroup2());
                      }
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
