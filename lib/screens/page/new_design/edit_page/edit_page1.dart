import 'package:als_frontend/data/model/response/category_model.dart';
import 'package:als_frontend/data/model/response/page/page_details_model.dart';
import 'package:als_frontend/provider/other_provider.dart';
import 'package:als_frontend/provider/page_provider.dart';
import 'package:als_frontend/screens/page/widget/page_app_bar.dart';
import 'package:als_frontend/util/helper.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/custom_button.dart';
import 'package:als_frontend/widgets/custom_text.dart';
import 'package:als_frontend/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'edit_page2.dart';

class EditPage1 extends StatefulWidget {
  const EditPage1(this.pageId, {Key? key,required this.index}) : super(key: key);
  final String pageId;
  final int index;

  @override
  State<EditPage1> createState() => _EditPage1State();
}

class _EditPage1State extends State<EditPage1> {
  final TextEditingController pageNameController = TextEditingController();
  final TextEditingController pageBioController = TextEditingController();
  final TextEditingController pageDetailsController = TextEditingController();
  final FocusNode nameFocus = FocusNode();
  final FocusNode bioFocus = FocusNode();
  final FocusNode detailsFocus = FocusNode();

  @override
  void initState() {
    Provider.of<PageProvider>(context, listen: false).initializeCategory();
    Future.delayed(const Duration(seconds: 3)).then((value) {
      setOldValue(Provider.of<PageProvider>(context, listen: false).individualPageDetailsModel);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const PageAppBar(title: 'Update Page'),
      body: Consumer2<OtherProvider, PageProvider>(builder: (context, otherProvider, pageProvider, child) {
        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                    title: "Want to Choose a name for your page?", maxLines: 2, textStyle: robotoStyle500Medium.copyWith(fontSize: 17)),
                const SizedBox(height: 4),
                Text("Choose a unique name for your business, organization,shop or name that helps to explore your business .",
                    style: robotoStyle400Regular.copyWith(fontSize: 10)),
                const SizedBox(height: 10),
                CustomTextField(
                  hintText: pageProvider.individualPageDetailsModel!.name.toString(),
                  isShowBorder: true,
                  borderRadius: 11,
                  verticalSize: 14,
                  controller: pageNameController,
                  focusNode: nameFocus,
                  nextFocus: bioFocus,
                ),
                const SizedBox(height: 19),
                CustomText(
                    title: "Select A Best Page Category that describe your page.",
                    textStyle: robotoStyle500Medium.copyWith(fontSize: 17),
                    maxLines: 2),
                const SizedBox(height: 10),
                Text.rich(
                  TextSpan(children: [
                    TextSpan(text: "Old Page Category: ", style: robotoStyle500Medium.copyWith(fontSize: 15)),
                    TextSpan(text: pageProvider.individualPageDetailsModel!.category, style: robotoStyle700Bold.copyWith(fontSize: 17))
                  ]),
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15), border: Border.all(color: colorText), color: textFieldFillColor),
                  //decoration: BoxDecoration(color: const Color(0xFF656B87), borderRadius: BorderRadius.circular(15.0)),
                  child: DropdownButton<CategoryModel>(
                    dropdownColor: textFieldFillColor,
                    value: pageProvider.categoryValue,
                    isExpanded: true,
                    underline: const SizedBox.shrink(),
                    icon: const Icon(Icons.keyboard_arrow_down_rounded, color: AppColors.primaryColorLight),
                    items: pageProvider.items
                        .map((item) => DropdownMenuItem<CategoryModel>(
                            value: item,
                            child: Container(
                                padding: const EdgeInsets.only(left: 10),
                                child: CustomText(
                                    title: item.name,
                                    textStyle: robotoStyle400Regular.copyWith(fontSize: 18, color: AppColors.primaryColorLight)))))
                        .toList(),
                    onChanged: (item) {
                      pageProvider.changeGroupCategory(item!);
                    },
                  ),
                ),
                const SizedBox(height: 10),
                CustomText(
                    title: "Tell a little bit about your page .", textStyle: robotoStyle500Medium.copyWith(fontSize: 17), maxLines: 2),
                const SizedBox(height: 10),
                CustomTextField(
                  hintText: pageProvider.individualPageDetailsModel!.bio,
                  isShowBorder: true,
                  borderRadius: 11,
                  verticalSize: 14,
                  controller: pageBioController,
                  focusNode: bioFocus,
                  nextFocus: detailsFocus,
                ),
                const SizedBox(height: 10),
                CustomText(title: "Describe Your Page.", textStyle: robotoStyle500Medium.copyWith(fontSize: 17), maxLines: 1),
                const SizedBox(height: 10),
                CustomTextField(
                  hintText: pageProvider.individualPageDetailsModel!.description,
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
                      if (pageProvider.categoryValue.id.toString() != pageProvider.individualPageDetailsModel!.category) {
                        Helper.toScreen(EditPage2(pageNameController.text, pageBioController.text, pageDetailsController.text,
                            pageProvider.categoryValue.id.toString(), widget.pageId,widget.index));
                      } else {
                        Helper.toScreen(EditPage2(
                            pageNameController.text,
                            pageBioController.text,
                            pageDetailsController.text,
                            pageProvider.individualPageDetailsModel!.category.toString(),
                            widget.pageId,
                            widget.index));
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

  void setOldValue(PageDetailsModel? pageDetailsModel) {
    pageNameController.text = pageDetailsModel!.name.toString();
    pageBioController.text = pageDetailsModel.bio.toString();
    pageDetailsController.text = pageDetailsModel.description.toString();
  }
}
