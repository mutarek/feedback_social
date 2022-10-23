import 'package:als_frontend/old_code/provider/settings/password_update_provider.dart';
import 'package:als_frontend/old_code/screens/settings/details/acces_display_language_settings.dart';
import 'package:als_frontend/old_code/screens/settings/details/data_uses_settings.dart';
import 'package:als_frontend/old_code/screens/settings/details/notification_settings.dart';
import 'package:als_frontend/old_code/screens/settings/details/privacy_settings.dart';
import 'package:als_frontend/old_code/screens/settings/details/security_settings.dart';
import 'package:als_frontend/old_code/widgets/settings%20widgets/user_account_update_settings.dart';
import 'package:als_frontend/provider/settings_provider.dart';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../widgets/snackbar_message.dart';
import '../widget/passowrd_update_widget.dart';



class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    TextEditingController newPasswordContorller = TextEditingController();
    TextEditingController currentPasswordContorller = TextEditingController();
    TextEditingController repeatPasswordContorller = TextEditingController();

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(top: height * 0.08, left: width * 0.03),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    FontAwesomeIcons.gear,
                    size: height * 0.04,
                    color: Colors.black,
                  ),
                  SizedBox(
                    width: width * 0.06,
                  ),
                  Text(
                    "Settings",
                    style: GoogleFonts.lato(
                        fontSize: 22, fontWeight: FontWeight.bold),
                  )
                ],
              ),
              SizedBox(
                height: height * 0.05,
              ),
              UserAccountSettings(
                width: width,
                height: height,
              ),

              /*.............pasword..................*/

              SizedBox(
                height: height * 0.02,
              ),
              Consumer<SettingsProvider>(

                  builder: (context, provider,child) {
                    return PasswordSettings(
                      width: width,
                      height: height,
                      newPasswordContorller: newPasswordContorller,
                      currentPasswordContorller: currentPasswordContorller,
                      repeatPasswordContorller: repeatPasswordContorller,
                      passwordSaveUpdate: () {
                        if (newPasswordContorller.text ==
                            repeatPasswordContorller.text) {
                          provider.passwordUpdate(
                              currentPasswordContorller.text,
                              newPasswordContorller.text ,
                              repeatPasswordContorller.text);
                        } else {
                          showMessage(
                            message: "New password & repeat Password don't match",
                            context: context,
                          );
                        }



                      },
                    );
                  }
              ),


              /*..................Notifications ............*/

              SizedBox(
                height: height * 0.05,
              ),
              const NotificationSettins(),
              /*..................Security and account access ............*/
              SizedBox(
                height: height * 0.05,
              ),
              const SecuritySettings(),
              /*..................Privacy and safety  ............*/

              SizedBox(
                height: height * 0.05,
              ),
              const PrivacySettings(),
              /*..................Accessibility, display, and languages  ............*/
              SizedBox(
                height: height * 0.05,
              ),
              const AccesDisplayLanguageSettings(),
              /*.................. Data Uses   ............*/

              SizedBox(
                height: height * 0.05,
              ),
              const DataUses(),
            ],
          ),
        ),
      ),
    );
  }
}
