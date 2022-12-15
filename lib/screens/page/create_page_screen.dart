import 'package:als_frontend/data/model/response/category_model.dart';
import 'package:als_frontend/data/model/response/page/author_page_details_model.dart';
import 'package:als_frontend/provider/other_provider.dart';
import 'package:als_frontend/provider/page_provider.dart';
import 'package:als_frontend/screens/other/choose_image_and_crop_image_view.dart';
import 'package:als_frontend/translations/locale_keys.g.dart';
import 'package:als_frontend/util/helper.dart';
import 'package:als_frontend/util/palette.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/custom_button.dart';
import 'package:als_frontend/widgets/custom_text.dart';
import 'package:als_frontend/widgets/custom_text_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class CreatePageScreen extends StatefulWidget {
  final bool isUpdatePage;
  final AuthorPageDetailsModel? authorPage;
  final int index;

  const CreatePageScreen({this.authorPage, this.isUpdatePage = false, this.index = 0, Key? key}) : super(key: key);

  @override
  State<CreatePageScreen> createState() => _CreatePageScreenState();
}

class _CreatePageScreenState extends State<CreatePageScreen> {
  TextEditingController pageNameController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageNameController = TextEditingController();
    Provider.of<PageProvider>(context, listen: false).initializeCategory();
    if (widget.isUpdatePage) {
      pageNameController.text = widget.authorPage!.name!;
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Consumer2<OtherProvider, PageProvider>(
        builder: (context, otherProvider, pageProvider, child) => SafeArea(
          child: ModalProgressHUD(
            inAsyncCall: pageProvider.isLoading,
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
                              : widget.isUpdatePage
                                  ? Image.network(widget.authorPage!.coverPhoto!,
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
                        CustomText(title: LocaleKeys.enter_Page_name.tr(), textStyle: latoStyle500Medium.copyWith(fontSize: 17)),
                        const SizedBox(height: 13),
                        CustomTextField(
                          hintText: LocaleKeys.write_here.tr(),
                          fillColor: Colors.white,
                          borderRadius: 10,
                          controller: pageNameController,
                          verticalSize: 13,
                          inputAction: TextInputAction.done,
                        ),
                        const SizedBox(height: 13),
                        CustomText(title: LocaleKeys.select_Page_Category_Type.tr(), textStyle: latoStyle500Medium.copyWith(fontSize: 17)),
                        const SizedBox(height: 13),
                        Container(
                          width: width,
                          decoration: BoxDecoration(color: const Color(0xFF656B87), borderRadius: BorderRadius.circular(15.0)),
                          child: DropdownButton<CategoryModel>(
                            dropdownColor: Palette.primary,
                            value: pageProvider.categoryValue,
                            isExpanded: true,
                            underline: const SizedBox.shrink(),
                            icon: const Icon(Icons.keyboard_arrow_down_rounded, color: Colors.white),
                            items: pageProvider.items
                                .map((item) => DropdownMenuItem<CategoryModel>(
                                    value: item,
                                    child: Container(
                                        padding: const EdgeInsets.only(left: 10),
                                        child: CustomText(
                                            title: item.name, textStyle: latoStyle500Medium.copyWith(fontSize: 17, color: Colors.white)))))
                                .toList(),
                            onChanged: (item) {
                              pageProvider.changeGroupCategory(item!);
                            },
                          ),
                        ),
                        const SizedBox(height: 20),
                        CustomButton(
                          btnTxt: widget.isUpdatePage ? LocaleKeys.update.tr() : LocaleKeys.add.tr(),
                          onTap: () {
                            if (pageNameController.text.isNotEmpty) {
                              if (widget.isUpdatePage) {
                                pageProvider
                                    .updatePage(pageNameController.text, otherProvider.selectedFile, widget.authorPage!.id as int, widget.index)
                                    .then((value) {
                                  if (value) {
                                    pageNameController.clear();
                                    Helper.back();
                                  }
                                });
                              } else {
                                pageProvider.createPage(pageNameController.text, otherProvider.selectedFile, (bool status) {
                                  if (status) {
                                    pageNameController.clear();
                                    Helper.back();
                                  }
                                });
                              }
                            } else {
                              Fluttertoast.showToast(msg: LocaleKeys.please_Write_Page_Name);
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
