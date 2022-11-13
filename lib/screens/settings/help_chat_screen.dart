import 'package:als_frontend/provider/other_provider.dart';
import 'package:als_frontend/provider/settings_provider.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/widgets/custom_button.dart';
import 'package:als_frontend/widgets/custom_text.dart';
import 'package:als_frontend/widgets/custom_text_field.dart';
import 'package:als_frontend/widgets/snackbar_message.dart';
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
                    title: CustomText(title: 'Type your problem', color: AppColors.feedback, fontWeight: FontWeight.bold, fontSize: 16),
                    backgroundColor: Colors.white,
                    elevation: 0),
                bottomNavigationBar: SizedBox(
                  height: 50,
                  child: Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          btnTxt: 'Cancel',
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
                          btnTxt: 'Send',
                          onTap: () {
                            if (problemsController.text.isEmpty) {
                              showMessage(message: 'Please write your problems here', context: context);
                            } else if (problemsController.text.length < 10) {
                              showMessage(message: 'Please write your problems at least 10 characters.', context: context);
                            } else if (otherProvider.selectedFile == null) {
                              showMessage(message: 'Please Insert problems screenshots', context: context);
                            } else {
                              settingsProvider.addMessageOnHelpDesk(problemsController.text, otherProvider.selectedFile!).then((value) {
                                if (value) {
                                  showMessage(
                                      message: 'We received your request , we will notify you as soon as possible . Feedback Support Team',
                                      isError: false,
                                      context: context);
                                  problemsController.clear();
                                  Navigator.of(context).pop();
                                } else {
                                  showMessage(message: 'Failed...', context: context);
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
                              btnTxt: 'Add screenshot',
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
                                            child: Icon(Icons.close, color: Colors.white, size: 18),
                                            backgroundColor: AppColors.feedback,
                                            radius: 13,
                                          ),
                                        ),
                                      )
                                    ],
                                  )
                                : CustomText(title: 'No Image Selected', color: AppColors.feedback),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15),
                    CustomTextField(
                      maxLines: null,
                      fillColor: Colors.white,
                      borderRadius: 0,
                      isCancelShadow: true,
                      hintText: 'Please Write your problems here...',
                      controller: problemsController,
                      inputAction: TextInputAction.done,
                    ),
                  ],
                ),
              ),
            ));
  }
}