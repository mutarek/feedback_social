import 'package:als_frontend/provider/settings_provider.dart';
import 'package:als_frontend/translations/locale_keys.g.dart';
import 'package:als_frontend/util/helper.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class PasswordUpdateSettings extends StatelessWidget {
  const PasswordUpdateSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController newPasswordContorller = TextEditingController();
    TextEditingController currentPasswordContorller = TextEditingController();
    TextEditingController repeatPasswordContorller = TextEditingController();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xffFFFFFF),
        leading: InkWell(
            onTap: () {
              Helper.back();
            },
            child: const Icon(FontAwesomeIcons.angleLeft, size: 20, color: Colors.black)),
        title: Text(LocaleKeys.password_security.tr(), style: GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.w800, color: Colors.black)),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 30, right: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                Text(LocaleKeys.enter_your_current_password.tr(), style: latoStyle500Medium),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: currentPasswordContorller,
                  fillColor: const Color(0xfff1d3f2),
                  hintText: LocaleKeys.input_your_old_password.tr(),
                ),
                const SizedBox(height: 20),
                Text(LocaleKeys.new_Password.tr(), style: latoStyle500Medium),
                const SizedBox(height: 10),
                CustomTextField(controller: newPasswordContorller, fillColor: const Color(0xffd7f2d3), hintText: "input your new password"),
                const SizedBox(height: 20),
                Text(LocaleKeys.repeat_new_password.tr(), style: latoStyle500Medium),
                const SizedBox(height: 10),
                CustomTextField(
                  validation: (value) {
                    if (value == null || value.isEmpty) {
                      return LocaleKeys.please_enter_some_text.tr();
                    }
                    return null;
                  },
                  controller: repeatPasswordContorller,
                  fillColor: const Color(0xffd7f2d3),
                  hintText: LocaleKeys.input_your_new_password_again.tr(),
                ),
                const SizedBox(height: 20),
                Center(
                  child: SizedBox(
                    height: 38,
                    width: 200,
                    child: Consumer<SettingsProvider>(builder: (context, provider, child) {
                      return ElevatedButton(
                          style: ElevatedButton.styleFrom(elevation: 7, backgroundColor: Colors.green),
                          onPressed: () {
                            if (newPasswordContorller.text == repeatPasswordContorller.text) {
                              provider.passwordUpdate(
                                  currentPasswordContorller.text, newPasswordContorller.text, repeatPasswordContorller.text);
                              if (provider.success) {
                                Fluttertoast.showToast(
                                    msg: LocaleKeys.successfully_update.tr(),
                                    toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                    timeInSecForIosWeb: 1,
                                    backgroundColor: Colors.red,
                                    textColor: Colors.white,
                                    fontSize: 16.0
                                );
                                Helper.back();
                              }
                            } else {
                              Fluttertoast.showToast(
                                  msg: LocaleKeys.please_enter_correct_old_password.tr(),
                                  toastLength: Toast.LENGTH_SHORT,
                                  gravity: ToastGravity.CENTER,
                                  timeInSecForIosWeb: 1,
                                  backgroundColor: Colors.red,
                                  textColor: Colors.white,
                                  fontSize: 16.0
                              );
                            }
                          },
                          child:  Text(LocaleKeys.update.tr()));
                    }),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
