import 'package:als_frontend/data/model/response/category_model.dart';
import 'package:als_frontend/data/model/response/group/author_group_details_model.dart';
import 'package:als_frontend/provider/group_provider.dart';
import 'package:als_frontend/provider/other_provider.dart';
import 'package:als_frontend/screens/other/choose_image_and_crop_image_view.dart';
import 'package:als_frontend/translations/locale_keys.g.dart';
import 'package:als_frontend/util/helper.dart';
import 'package:als_frontend/util/palette.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/custom_button.dart';
import 'package:als_frontend/widgets/custom_text.dart';
import 'package:als_frontend/widgets/custom_text_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class CreateGroupScreen extends StatefulWidget {
  final bool isUpdateGroup;
  final AuthorGroupDetailsModel? authorGroup;
  final int index;

  const CreateGroupScreen({this.authorGroup, this.isUpdateGroup = false, this.index = 0, Key? key}) : super(key: key);

  @override
  State<CreateGroupScreen> createState() => _CreateGroupScreenState();
}

class _CreateGroupScreenState extends State<CreateGroupScreen> {
  TextEditingController groupNameController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    groupNameController = TextEditingController();
    Provider.of<GroupProvider>(context, listen: false).initializeCategory();
    if (widget.isUpdateGroup) {
      groupNameController.text = widget.authorGroup!.name!;
      Provider.of<GroupProvider>(context, listen: false).changeGroupPrivateStatus(widget.authorGroup!.isPrivate!, isFirstTime: true);
    }
  }

  @override
  Widget build(BuildContext context) {
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
                              : widget.isUpdateGroup
                                  ? Image.network(widget.authorGroup!.coverPhoto!,
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
                        CustomText(title: LocaleKeys.enter_Group_name.tr(), textStyle: latoStyle500Medium.copyWith(fontSize: 17)),
                        const SizedBox(height: 13),
                        CustomTextField(
                          hintText: LocaleKeys.write_here.tr(),
                          fillColor: Colors.white,
                          borderRadius: 10,
                          controller: groupNameController,
                          verticalSize: 13,
                          inputAction: TextInputAction.done,
                        ),
                        const SizedBox(height: 13),
                        Row(
                          children: [
                            CustomText(title: LocaleKeys.group_Is_Private.tr(), textStyle: latoStyle500Medium.copyWith(fontSize: 17)),
                            CupertinoSwitch(
                              value: groupProvider.groupISPrivate,
                              onChanged: (value) {
                                groupProvider.changeGroupPrivateStatus(value);
                              },
                            ),
                          ],
                        ),
                        const SizedBox(height: 13),
                        CustomText(title: LocaleKeys.select_Group_Category.tr(), textStyle: latoStyle500Medium.copyWith(fontSize: 17)),
                        const SizedBox(height: 13),
                        Container(
                          width: width,
                          decoration: BoxDecoration(color: const Color(0xFF656B87), borderRadius: BorderRadius.circular(15.0)),
                          child: DropdownButton<CategoryModel>(
                            dropdownColor: Palette.primary,
                            value: groupProvider.categoryValue,
                            isExpanded: true,
                            underline: const SizedBox.shrink(),
                            icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.white),
                            items: groupProvider.items
                                .map((item) => DropdownMenuItem<CategoryModel>(
                                    value: item,
                                    child: Container(
                                        padding: const EdgeInsets.only(left: 10),
                                        child: CustomText(
                                            title: item.name, textStyle: latoStyle500Medium.copyWith(fontSize: 17, color: Colors.white)))))
                                .toList(),
                            onChanged: (item) {
                              groupProvider.changeGroupCategory(item!);
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        CustomButton(
                          btnTxt: widget.isUpdateGroup ? LocaleKeys.update.tr() : LocaleKeys.add.tr(),
                          onTap: () {
                            if (groupNameController.text.isNotEmpty) {
                              if (widget.isUpdateGroup) {
                                groupProvider.updateGroup(groupNameController.text, otherProvider.selectedFile, (bool status) {
                                  if (status) {
                                    groupNameController.clear();
                                    Helper.back();
                                  }
                                }, widget.authorGroup!.id as int, widget.index);
                              } else {
                                groupProvider.createGroup(groupNameController.text, otherProvider.selectedFile, (bool status) {
                                  if (status) {
                                    groupNameController.clear();
                                    Helper.back();
                                  }
                                });
                              }
                            } else {
                              Fluttertoast.showToast(msg: LocaleKeys.please_Write_Group_Name.tr());
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
