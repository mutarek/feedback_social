import 'package:als_frontend/provider/other_provider.dart';
import 'package:als_frontend/provider/settings_provider.dart';
import 'package:als_frontend/translations/locale_keys.g.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/widgets/custom_button.dart';
import 'package:als_frontend/widgets/custom_text.dart';
import 'package:als_frontend/widgets/custom_text_field.dart';
import 'package:als_frontend/widgets/snackbar_message.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';

class HelpChatScreen extends StatefulWidget {
  const HelpChatScreen({Key? key}) : super(key: key);

  @override
  State<HelpChatScreen> createState() => _HelpChatScreenState();
}

class _HelpChatScreenState extends State<HelpChatScreen> {
  TextEditingController problemsController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Consumer2<OtherProvider, SettingsProvider>(
        builder: (context, otherProvider, settingsProvider, child) => ModalProgressHUD(
              inAsyncCall: settingsProvider.isLoading,
              child: Scaffold(
                backgroundColor: Colors.white,
                appBar: AppBar(
                    leading: IconButton(
                        icon: const Icon(Icons.arrow_back, color: AppColors.feedback),
                        onPressed: () {
                          Navigator.of(context).pop();
                        }),
                    title: CustomText(title: LocaleKeys.type_your_problem.tr(), color: AppColors.feedback, fontWeight: FontWeight.bold, fontSize: 16),
                    backgroundColor: Colors.white,
                    elevation: 0),
                bottomNavigationBar: SizedBox(
                  height: 50,
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          btnTxt: LocaleKeys.cancel.tr(),
                          onTap: () {
                            Navigator.of(context).pop();
                          },
                          textWhiteColor: true,
                          backgroundColor: Colors.green,
                          radius: 0,
                        ),
                      ),
                      Expanded(
                        child: CustomButton(
                          btnTxt: LocaleKeys.send.tr(),
                          onTap: () {
                            if (problemsController.text.isEmpty) {
                              showMessage(message: LocaleKeys.please_Write_your_problems_here.tr(), context: context);
                            } else if (problemsController.text.length < 10) {
                              showMessage(message: LocaleKeys.please_write_your_problems_at_least_10_characters.tr(), context: context);
                            } else if (otherProvider.selectedFile == null) {
                              showMessage(message: LocaleKeys.please_Insert_problems_screenshots.tr(), context: context);
                            } else {
                              settingsProvider.addMessageOnHelpDesk(problemsController.text, otherProvider.selectedFile!).then((value) {
                                if (value) {
                                  showMessage(
                                      message: LocaleKeys.we_received_your_request.tr(),
                                      isError: false,
                                      context: context);
                                  problemsController.clear();
                                  Navigator.of(context).pop();
                                } else {
                                  showMessage(message: LocaleKeys.failed.tr(), context: context);
                                }
                              });
                            }
                          },
                          textWhiteColor: true,
                          backgroundColor: AppColors.feedback,
                          radius: 0,
                        ),
                      ),
                    ],
                  ),
                ),
                body: ListView(
                  children: [
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 15, right: 10),
                            child: CustomButton(
                              btnTxt: LocaleKeys.add_screenshot.tr(),
                              onTap: () {
                                otherProvider.getImageWithOutCroup(ImageSource.gallery)!;
                              },
                              textWhiteColor: true,
                              backgroundColor: AppColors.feedback,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Container(
                            alignment: Alignment.center,
                            child: otherProvider.selectedFile != null
                                ? Stack(
                                    clipBehavior: Clip.none,
                                    children: [
                                      Image.file(otherProvider.selectedFile!, width: 80, height: 80),
                                      Positioned(
                                        right: 2,
                                        top: -10,
                                        child: InkWell(
                                          onTap: () {
                                            otherProvider.clearImage();
                                          },
                                          child: const CircleAvatar(
                                            backgroundColor: AppColors.feedback,
                                            radius: 13,
                                            child: Icon(Icons.close, color: Colors.white, size: 18),
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                : CustomText(title: LocaleKeys.no_Image_Selected.tr(), color: AppColors.feedback),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 15),
                    CustomTextField(
                      maxLines: null,
                      fillColor: Colors.white,
                      borderRadius: 0,
                      isCancelShadow: true,
                      hintText: LocaleKeys.please_write_your_problems_here.tr(),
                      controller: problemsController,
                      inputAction: TextInputAction.done,
                    ),
                  ],
                ),
              ),
            ));
  }
}
