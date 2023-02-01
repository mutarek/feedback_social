import 'package:als_frontend/data/model/response/page/athour_pages_model.dart';
import 'package:als_frontend/data/model/response/page/page_details_model.dart';
import 'package:als_frontend/provider/other_provider.dart';
import 'package:als_frontend/provider/page_provider.dart';
import 'package:als_frontend/screens/page/page_home_screen.dart';
import 'package:als_frontend/screens/page/widget/page_app_bar.dart';
import 'package:als_frontend/util/helper.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/custom_button.dart';
import 'package:als_frontend/widgets/custom_text.dart';
import 'package:als_frontend/widgets/custom_text_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditPage2 extends StatefulWidget {
  EditPage2(this.pageName, this.pageBio, this.pageDesc, this.pageCategory, this.pageId, this.index, {Key? key})
      : super(key: key);
  final String pageName;
  final String pageBio;
  final String pageDesc;
  final String pageCategory;
  final String pageId;
  final int index;

  @override
  State<EditPage2> createState() => _EditPage2State();
}

class _EditPage2State extends State<EditPage2> {
  final TextEditingController contactNumberController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController websiteController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final FocusNode contactFocus = FocusNode();
  final FocusNode emailFocus = FocusNode();
  final FocusNode websiteFocus = FocusNode();
  final FocusNode addressFocus = FocusNode();

  @override
  void initState() {
    Future.delayed(const Duration(seconds: 0)).then((value) {
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
                CustomText(title: "Contact Selection", maxLines: 2, textStyle: robotoStyle500Medium.copyWith(fontSize: 17)),
                const SizedBox(height: 4),
                Text("Please enter your valid contact information so people can reach with you easily.",
                    style: robotoStyle400Regular.copyWith(fontSize: 10)),
                const SizedBox(height: 20),
                CustomTextField(
                  hintText: 'Enter Contact Number',
                  isShowBorder: true,
                  borderRadius: 11,
                  verticalSize: 14,
                  controller: contactNumberController,
                  focusNode: contactFocus,
                  nextFocus: emailFocus,
                ),
                const SizedBox(height: 15),
                CustomTextField(
                  hintText: 'Enter Email',
                  isShowBorder: true,
                  borderRadius: 11,
                  verticalSize: 14,
                  controller: emailController,
                  focusNode: emailFocus,
                  nextFocus: websiteFocus,
                ),
                const SizedBox(height: 15),
                CustomTextField(
                  hintText: 'Enter Your Website Link',
                  isShowBorder: true,
                  borderRadius: 11,
                  verticalSize: 14,
                  controller: websiteController,
                  focusNode: websiteFocus,
                  nextFocus: addressFocus,
                ),
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
                CustomTextField(
                    hintText: 'Enter Your Address',
                    isShowBorder: true,
                    borderRadius: 11,
                    verticalSize: 14,
                    maxLines: 3,
                    controller: addressController,
                    focusNode: addressFocus,
                    inputAction: TextInputAction.done),
                const SizedBox(height: 30),
                pageProvider.isLoading
                    ? const Align(alignment: Alignment.center, child: CupertinoActivityIndicator())
                    : CustomButton(
                        btnTxt: "Update Page",
                        onTap: () {
                          pageProvider.editPage(
                              widget.pageName,
                              widget.pageBio,
                              widget.pageDesc,
                              widget.pageCategory,
                              contactNumberController.text,
                              emailController.text,
                              websiteController.text,
                              addressController.text,
                              widget.pageId,
                              widget.index, (status) {
                            if (status) {
                              Navigator.pop(context);
                              Navigator.pop(context);
                              Navigator.pop(context);
                              //Helper.toRemoveUntilScreen(const PageHomeScreen());
                            } else {}
                          });
                        },
                        radius: 100,
                        height: 48)
              ],
            ),
          ),
        );
      }),
    );
  }

  void setOldValue(PageDetailsModel? individualPageDetailsModel) {
    contactNumberController.text = individualPageDetailsModel!.contact.toString();
    emailController.text = individualPageDetailsModel.email.toString();
    websiteController.text = individualPageDetailsModel.website.toString();
    addressController.text = individualPageDetailsModel.address.toString();
  }
}
