import 'package:als_frontend/provider/settings_provider.dart';
import 'package:als_frontend/translations/locale_keys.g.dart';
import 'package:als_frontend/util/helper.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EmailUpdateSettings extends StatelessWidget {
  EmailUpdateSettings({Key? key}) : super(key: key);
  final TextEditingController currentMailController = TextEditingController();
  final TextEditingController newMailController = TextEditingController();
  final TextEditingController currentPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
        title: Text(LocaleKeys.email_Update.tr(), style: GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.w800, color: Colors.black)),
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
                Text(LocaleKeys.enter_your_current_Email.tr(), style: latoStyle500Medium),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: currentMailController,
                  fillColor: const Color(0xfff1d3f2),
                  hintText: LocaleKeys.input_your_old_Email.tr(),
                ),
                const SizedBox(height: 20),
                Text(LocaleKeys.enter_new_Email.tr(), style: latoStyle500Medium),
                const SizedBox(height: 10),
                CustomTextField(controller: newMailController, fillColor: const Color(0xffd7f2d3), hintText: "input your new Email"),
                const SizedBox(height: 20),
                Text(LocaleKeys.enter_current_password.tr(), style: latoStyle500Medium),
                const SizedBox(height: 10),
                CustomTextField(
                  controller: currentPasswordController,
                  fillColor: const Color(0xffd7f2d3),
                  hintText: LocaleKeys.input_your_new_password_again.tr(),
                ),
                const SizedBox(height: 20),
                Center(
                  child: SizedBox(
                    height: 38,
                    width: 200,
                    child: Consumer<SettingsProvider>(builder: (context, emailProvider, child) {
                      return ElevatedButton(
                          style: ElevatedButton.styleFrom(elevation: 7, backgroundColor: Colors.green),
                          onPressed: () {
                            if (currentMailController.text.isNotEmpty &&
                                newMailController.text.isNotEmpty &&
                                currentPasswordController.text.isNotEmpty) {
                              emailProvider.emailUpdate(currentMailController.text, newMailController.text, currentPasswordController.text);
                            } else {
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
