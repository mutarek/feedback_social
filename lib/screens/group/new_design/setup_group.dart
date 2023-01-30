import 'package:als_frontend/provider/group_provider.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/custom_button.dart';
import 'package:als_frontend/widgets/custom_text.dart';
import 'package:als_frontend/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SetupGroup extends StatefulWidget {
  const SetupGroup({Key? key}) : super(key: key);

  @override
  State<SetupGroup> createState() => _SetupGroupState();
}

class _SetupGroupState extends State<SetupGroup> {
  final TextEditingController pageNameController = TextEditingController();
  final TextEditingController pageBioController = TextEditingController();
  final TextEditingController pageDetailsController = TextEditingController();
  final FocusNode nameFocus = FocusNode();
  final FocusNode bioFocus = FocusNode();
  final FocusNode detailsFocus = FocusNode();
  List<String> privacyModel = ["Public", "Private"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const CustomText(title: "Group Setup", color: AppColors.primaryColorLight, fontWeight: FontWeight.bold, fontSize: 24),
        backgroundColor: Colors.white,
        elevation: 0.3,
        centerTitle: true,
        leading: const BackButton(color: Colors.black),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, right: 10),
        child: Consumer<GroupProvider>(builder: (context, pageProvider, child) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  CustomText(title: "Change your group name.", maxLines: 2, textStyle: robotoStyle500Medium.copyWith(fontSize: 17)),
                  const SizedBox(height: 10),
                  CustomTextField(
                    hintText: 'Exam helping group BD',
                    isShowBorder: true,
                    borderRadius: 11,
                    verticalSize: 14,
                    controller: pageNameController,
                    focusNode: nameFocus,
                    nextFocus: bioFocus,
                  ),
                  const SizedBox(height: 10),
                  CustomText(title: "Change Privacy", maxLines: 2, textStyle: robotoStyle500Medium.copyWith(fontSize: 17)),
                  const SizedBox(height: 5),
                  Container(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15), border: Border.all(color: colorText), color: textFieldFillColor),
                    //decoration: BoxDecoration(color: const Color(0xFF656B87), borderRadius: BorderRadius.circular(15.0)),
                    child: DropdownButton<String>(
                      dropdownColor: textFieldFillColor,
                      hint: Text('Select Privacy', style: robotoStyle400Regular.copyWith(fontSize: 18, color: Colors.grey)),
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
                  const SizedBox(height: 10),
                  CustomText(title: "Change descriptions", maxLines: 2, textStyle: robotoStyle500Medium.copyWith(fontSize: 17)),
                  const SizedBox(height: 5),
                  CustomTextField(
                    hintText: 'Exam helping group BD',
                    isShowBorder: true,
                    borderRadius: 11,
                    verticalSize: 14,
                    controller: pageNameController,
                    focusNode: nameFocus,
                    nextFocus: bioFocus,
                    maxLines: 5,
                  ),
                  const SizedBox(height: 10),
                  CustomText(title: "Change intro of your group", maxLines: 2, textStyle: robotoStyle500Medium.copyWith(fontSize: 17)),
                  const SizedBox(height: 5),
                  CustomTextField(
                    hintText: 'Enter short intro',
                    isShowBorder: true,
                    borderRadius: 11,
                    verticalSize: 14,
                    controller: pageNameController,
                    focusNode: nameFocus,
                    nextFocus: bioFocus,
                  ),
                  const SizedBox(height: 10),
                  CustomText(title: "Change addesss", maxLines: 2, textStyle: robotoStyle500Medium.copyWith(fontSize: 17)),
                  const SizedBox(height: 5),
                  CustomTextField(
                    hintText: 'Dhaka Bangladesh',
                    isShowBorder: true,
                    borderRadius: 11,
                    verticalSize: 14,
                    controller: pageNameController,
                    focusNode: nameFocus,
                    nextFocus: bioFocus,
                  ),
                  const SizedBox(height: 20),
                  CustomButton(btnTxt: 'Save', onTap: () {}, radius: 100, height: 48),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
