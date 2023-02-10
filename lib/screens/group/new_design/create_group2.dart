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
import 'package:als_frontend/widgets/snackbar_message.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'create_group4.dart';

class CreateGroup2 extends StatefulWidget {
  const CreateGroup2({Key? key}) : super(key: key);

  @override
  State<CreateGroup2> createState() => _CreateGroup2State();
}

class _CreateGroup2State extends State<CreateGroup2> {
  final TextEditingController groupAddressController = TextEditingController();
  List<String> privacyModel = ["Public","Private"];
  @override
  Widget build(BuildContext context) {
    return Consumer2<GroupProvider,PageProvider>(
      builder: (context, groupProvider, pageProvider,child) {
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: const PageAppBar(title: 'Create Feedback Group'),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
                    controller: groupAddressController,
                    inputAction: TextInputAction.done,
                  ),
                ],
              ),
            ),
          ),
          bottomSheet: Container(
            height: 48,
            margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
            child: CustomButton(
                btnTxt: 'Next',
                onTap: () {
                  if(groupAddressController.text.isEmpty){
                    showMessage(message: "Please enter your address first");
                  }else if(groupProvider.privacy =="Select Privacy"){
                    showMessage(message: 'Please select privacy');
                  }
                  else{
                    groupProvider.updateInsertGroupInfo(1,
                      aGroupLocation: pageProvider.countryName,
                      aAddress: groupAddressController.text,
                    );
                    Helper.toScreen(const CreateGroup4());
                  }
                },
                radius: 100,
                height: 48),
          ),
        );
      }
    );
  }
}
