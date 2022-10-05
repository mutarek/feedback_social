


import 'package:als_frontend/old_code/const/palette.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../../provider/provider.dart';
import '../../../widgets/card container/snackbar_message.dart';
import '../../../widgets/settings widgets/setteings_widget.dart';
import '../../../widgets/settings widgets/update_textfiled_widget.dart';

class SecuritySettings extends StatefulWidget {
  const SecuritySettings({Key? key}) : super(key: key);

  @override
  State<SecuritySettings> createState() => _SecuritySettingsState();
}

class _SecuritySettingsState extends State<SecuritySettings> {
  @override
  void initState() {
    final value = Provider.of<SettingsSecurityProvider>(context, listen: false);
    value.getData();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextEditingController oldGmailContorller = TextEditingController();
    TextEditingController newGmailContorller = TextEditingController();
    TextEditingController passwordContorller = TextEditingController();

    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return ExpansionTile(
      title: SettingsWidget(
        width: width,
        height: height * 0.06,
        iconName: FontAwesomeIcons.lock,
        boxName: "Security and account access",
        boxDetails:
            " Manage your account”s security and keep track of your account”s usage including apps that you have connected to your account.",
      ),
      children: [
        Consumer2<SecurityUpdateProvider, SettingsSecurityProvider>(
            builder: (context, provider, securitySettings, child) {
          return ExpansionTile(
            title: SettingsWidget(
                width: width,
                height: height * 0.02,
                iconName: FontAwesomeIcons.shield,
                boxName: "Security",
                boxDetails: "Manage your account’s security."),
            children: [
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        provider.textMassegebool();
                      },
                      icon: Icon(
                        (provider.textMassege ==
                                securitySettings.security.isText)
                            ? FontAwesomeIcons.squareCheck
                            : FontAwesomeIcons.square,
                        color: (provider.textMassege ==
                                securitySettings.security.isText)
                            ? Colors.green
                            : Colors.red,
                        size: 15,
                      )),
                  SizedBox(
                    width: width * 0.7,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Text message",
                          style: GoogleFonts.lato(
                              fontSize: 16, fontWeight: FontWeight.w300),
                        ),
                        Text(
                          "Use your mobile phone to receive a text message with an authentication code to enter when you log in",
                          style: GoogleFonts.lato(
                            color: const Color.fromARGB(45, 45, 45, 65),
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        provider.authenticationbool();
                      },
                      icon: Icon(
                        (provider.authentication ==
                                securitySettings.security.isAuthentication)
                            ? FontAwesomeIcons.squareCheck
                            : FontAwesomeIcons.square,
                        color: (provider.authentication ==
                                securitySettings.security.isAuthentication)
                            ? Colors.green
                            : Colors.red,
                        size: 15,
                      )),
                  SizedBox(
                    width: width * 0.7,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Authentication app",
                          style: GoogleFonts.lato(
                              fontSize: 16, fontWeight: FontWeight.w300),
                        ),
                        Text(
                          "Use a mobile authentication app to get a verification code to enter every time you log in",
                          style: GoogleFonts.lato(
                            color: const Color.fromARGB(45, 45, 45, 65),
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Row(
                children: [
                  IconButton(
                      onPressed: () {
                        provider.securitybool();
                      },
                      icon: Icon(
                        (provider.security ==
                                securitySettings.security.isSecurityKey)
                            ? FontAwesomeIcons.squareCheck
                            : FontAwesomeIcons.square,
                        color: (provider.security ==
                                securitySettings.security.isSecurityKey)
                            ? Colors.green
                            : Colors.red,
                        size: 15,
                      )),
                  SizedBox(
                    width: width * 0.7,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Security key",
                          style: GoogleFonts.lato(
                              fontSize: 16, fontWeight: FontWeight.w300),
                        ),
                        Text(
                          "Use a security key that inserts into your computer or syncs to your mobile device when you log in",
                          style: GoogleFonts.lato(
                            color: const Color.fromARGB(45, 45, 45, 65),
                            fontSize: 10,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: height * 0.01,
                ),
                child: Consumer<SecurityUpdateProvider>(
                    builder: (context, provider, child) {
                  return ElevatedButton(
                      onPressed: () {
                        if (provider.success = false) {
                          showMessage(
                            message: "Something went wrong",
                            context: context,
                          );
                        } else {
                          provider.loading = true;
                          provider.updatesecurity(
                              provider.textMassege.toString(),
                              provider.authentication.toString(),
                              provider.security.toString());

                          if (provider.success == true) {
                            provider.message;
                          }
                        }
                      },
                      child: Text(
                        "Update & Save",
                        style: GoogleFonts.lato(fontSize: 10),
                      ));
                }),
              )
            ],
          );
        }),
        ExpansionTile(
          title: SettingsWidget(
              width: width,
              height: height * 0.02,
              iconName: FontAwesomeIcons.mobileScreen,
              boxName: "Apps and sessions",
              boxDetails:
                  "See information about when you logged into your account and the apps you connected to your account."),
          children: [
            Padding(
              padding: EdgeInsets.only(left: width * 0.1),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Device History",
                    style: GoogleFonts.lato(
                        fontSize: 16, fontWeight: FontWeight.w400),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Icon(
                          FontAwesomeIcons.mobileScreenButton,
                          color: Palette.notificationColor,
                        ),
                        SizedBox(
                          width: width * 0.02,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Android",
                              style: GoogleFonts.lato(
                                  fontSize: 14, fontWeight: FontWeight.w400),
                            ),
                            Text(
                              "Jessore,Bangladesh",
                              style: GoogleFonts.lato(
                                  fontSize: 10, fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Container(
                          height: height * 0.03,
                          width: width * 0.25,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: const Color(0xff22B07D)),
                          child: Center(
                              child: Text(
                            "Active",
                            style: GoogleFonts.lato(color: Colors.white),
                          )),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Icon(
                          FontAwesomeIcons.laptop,
                          color: Palette.primary,
                          size: 18,
                        ),
                        SizedBox(
                          width: width * 0.02,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Windows",
                              style: GoogleFonts.lato(
                                  fontSize: 14, fontWeight: FontWeight.w400),
                            ),
                            Text(
                              "Jessore,Bangladesh",
                              style: GoogleFonts.lato(
                                  fontSize: 10, fontWeight: FontWeight.w400),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
        Consumer<SecurityGmailUpdateProvider>(
            builder: (context, provider, child) {
          return ExpansionTile(
            title: SettingsWidget(
                width: width,
                height: height * 0.02,
                iconName: FontAwesomeIcons.shield,
                boxName: "Connected accounts",
                boxDetails: "Manage your account’s security."),
            children: [
              Padding(
                padding: EdgeInsets.only(left: width * 0.1),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(
                          FontAwesomeIcons.googlePlusSquare,
                          color: Colors.redAccent,
                        ),
                        SizedBox(
                          width: width * 0.03,
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Gmail",
                              style: GoogleFonts.lato(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.green),
                            ),
                            Text(
                              "Manage your Gmail account",
                              style: GoogleFonts.lato(
                                fontWeight: FontWeight.w600,
                                color: const Color.fromARGB(45, 45, 45, 65),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SettingTextField(
                          height: height,
                          controller: oldGmailContorller,
                          hintText: "Enter your current Gmail",
                          textFildName: "Gmail"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SettingTextField(
                          height: height,
                          controller: newGmailContorller,
                          hintText: "Enter your new Gmail",
                          textFildName: "New Gmail"),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SettingTextField(
                          height: height,
                          controller: passwordContorller,
                          hintText: "Enter your current password",
                          textFildName: "Enter password"),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: height * 0.01,
                      ),
                      child: ElevatedButton(
                          onPressed: () {
                            if (provider.success = false) {
                              showMessage(
                                message: "Something went wrong",
                                context: context,
                              );
                            } else {
                              provider.loading = true;
                              provider.updategmail(
                                  oldGmailContorller.text,
                                  newGmailContorller.text,
                                  passwordContorller.text);

                              if (provider.success == true) {
                                provider.message;
                              }
                            }
                          },
                          child: Text(
                            "Update & Save",
                            style: GoogleFonts.lato(fontSize: 10),
                          )),
                    )
                  ],
                ),
              )
            ],
          );
        })
      ],
    );
  }
}
