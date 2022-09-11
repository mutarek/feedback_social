import 'package:als_frontend/widgets/settings%20widgets/setteings_widget.dart';
import 'package:als_frontend/widgets/settings%20widgets/update_textfiled_widget.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

class PasswordSettings extends StatelessWidget {
  const PasswordSettings({
    Key? key,
    required this.width,
    required this.height,
    required this.currentPasswordContorller,
    required this.newPasswordContorller,
    required this.passwordSaveUpdate,
    required this.repeatPasswordContorller,
  }) : super(key: key);

  final double width;
  final double height;
  final TextEditingController currentPasswordContorller;
  final TextEditingController newPasswordContorller;
  final TextEditingController repeatPasswordContorller;
  final VoidCallback passwordSaveUpdate;

  @override
  Widget build(BuildContext context) {
    return ExpansionTile(
      title: SettingsWidget(
        width: width,
        height: height * 0.06,
        iconName: FontAwesomeIcons.key,
        boxName: "Password",
        boxDetails: "Use Strong paasword & Update password regular basis ",
      ),
      children: [
        SizedBox(
          height: height * 0.01,
        ),
        SettingTextField(
          height: height,
          textFildName: "Current password",
          controller: currentPasswordContorller,
          hintText: "password",
        ),
        SizedBox(
          height: height * 0.01,
        ),
        SettingTextField(
          height: height,
          textFildName: "New password",
          controller: newPasswordContorller,
          hintText: "Type New",
        ),
        SizedBox(
          height: height * 0.01,
        ),
        SettingTextField(
          height: height,
          textFildName: "Repeat new password",
          controller: repeatPasswordContorller,
          hintText: "Repeat the new",
        ),
        Padding(
          padding: EdgeInsets.only(top: height * 0.01, left: width * 0.3),
          child: ElevatedButton(
              onPressed: passwordSaveUpdate,
              child: Text(
                "Update & Save",
                style: GoogleFonts.lato(fontSize: 10),
              )),
        )
      ],
    );
  }
}
