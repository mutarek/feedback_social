import 'package:als_frontend/old_code/const/palette.dart';
import 'package:als_frontend/provider/group_provider.dart';
import 'package:als_frontend/provider/other_provider.dart';
import 'package:als_frontend/screens/other/choose_image_and_crop_image_view.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/custom_button.dart';
import 'package:als_frontend/widgets/custom_text.dart';
import 'package:als_frontend/widgets/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/route_manager.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class CreateGroupScreen extends StatelessWidget {
  CreateGroupScreen({Key? key}) : super(key: key);
  final TextEditingController groupNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Consumer2<OtherProvider, GroupProvider>(
        builder: (context, otherProvider, groupProvider, child) => SafeArea(
          child: ModalProgressHUD(
            inAsyncCall: groupProvider.isLoading,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Stack(
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          otherProvider.selectedFile != null
                              ? Image.file(otherProvider.selectedFile!,
                                  width: MediaQuery.of(context).size.width, height: 200, fit: BoxFit.scaleDown)
                              : Image.asset("assets/background/profile_placeholder.jpg",
                                  width: MediaQuery.of(context).size.width, height: 200, fit: BoxFit.fitWidth),
                        ],
                      ),
                      Positioned(
                          bottom: 10,
                          right: 10,
                          child: InkWell(
                              onTap: () {
                                Navigator.of(context)
                                    .push(MaterialPageRoute(builder: (_) => const ChooseImageAndCropImageView(16, 9, 640, 260)));
                              },
                              child: const CircleAvatar(
                                  backgroundColor: Palette.primary, child: Icon(Icons.camera_alt, color: Colors.white)))),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(title: 'Enter Group name ', textStyle: latoStyle500Medium.copyWith(fontSize: 17)),
                        const SizedBox(height: 13),
                        CustomTextField(
                          hintText: 'Write here....',
                          fillColor: Colors.white,
                          borderRadius: 10,
                          controller: groupNameController,
                          verticalSize: 13,
                          inputAction: TextInputAction.done,
                        ),
                        const SizedBox(height: 13),
                        Row(
                          children: [
                            CustomText(title: 'Group Is Private? ', textStyle: latoStyle500Medium.copyWith(fontSize: 17)),
                            CupertinoSwitch(
                              value: groupProvider.groupISPrivate,
                              onChanged: (value) {
                                groupProvider.changeGroupPrivateStatus(value);
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 13),
                        CustomText(title: 'Select Group Category ', textStyle: latoStyle500Medium.copyWith(fontSize: 17)),
                        const SizedBox(height: 13),
                        Container(
                          width: width,
                          decoration: BoxDecoration(color: const Color(0xFF656B87), borderRadius: BorderRadius.circular(15.0)),
                          child: DropdownButton<String>(
                            dropdownColor: Palette.primary,
                            value: groupProvider.categoryValue,
                            isExpanded: true,
                            underline: const SizedBox.shrink(),
                            icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.white),
                            items: groupProvider.items
                                .map((item) => DropdownMenuItem<String>(
                                    value: item,
                                    child: Container(
                                        padding: const EdgeInsets.only(left: 10),
                                        child: CustomText(
                                            title: item, textStyle: latoStyle500Medium.copyWith(fontSize: 17, color: Colors.white)))))
                                .toList(),
                            onChanged: (item) {
                              groupProvider.changeGroupCategory(item!);
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        CustomButton(
                          btnTxt: 'Add',
                          onTap: () {
                            if (groupNameController.text.isNotEmpty) {
                              groupProvider.createGroup(groupNameController.text, otherProvider.selectedFile, (bool status) {
                                if (status) {
                                  groupNameController.clear();
                                  Get.back();
                                }
                              });
                            } else {
                              Fluttertoast.showToast(msg: "Please Write Group Name");
                            }
                          },
                          fontSize: 18,
                          textWhiteColor: true,
                          backgroundColor: Palette.primary,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
