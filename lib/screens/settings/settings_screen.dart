import 'package:als_frontend/provider/profile_provider.dart';
import 'package:als_frontend/provider/settings_provider.dart';
import 'package:als_frontend/screens/settings/view/about_settings.dart';
import 'package:als_frontend/screens/settings/view/help_desk.dart';
import 'package:als_frontend/screens/settings/view/notifications_settings.dart';
import 'package:als_frontend/screens/settings/view/other_settings.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'widget/Settings_widget.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  @override
  void initState() {
    Provider.of<ProfileProvider>(context, listen: false).initializeUserData();
    super.initState();
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xffFFFFFF),
        body: Padding(
          padding: EdgeInsets.only(left: 30, right: 30),
          child: SingleChildScrollView(
            child: Consumer<ProfileProvider>(builder: (context, provider, child) {
              return provider.isLoading
                  ? Center(child: CupertinoActivityIndicator())
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        InkWell(
                            onTap: () {
                              Get.back();
                            },
                            child: Icon(
                              FontAwesomeIcons.angleLeft,
                              size: 20,
                            )),
                        SizedBox(
                          height: 40,
                        ),
                        Text(
                          "Settings",
                          style: GoogleFonts.lato(fontSize: 40, fontWeight: FontWeight.w800),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Text(
                          "Accounts",
                          style: GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                                radius: 35,
                                backgroundImage: NetworkImage(
                                  provider.userprofileData.profileImage!,
                                )),
                            SizedBox(
                              width: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 9),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(provider.userprofileData.firstName! + provider.userprofileData.lastName!,
                                      style: GoogleFonts.lato(fontSize: 16)),
                                  SizedBox(
                                    height: 2,
                                  ),
                                  Text(
                                    "personal info",
                                    style: GoogleFonts.lato(color: Color(0xff9C9EA2)),
                                  )
                                ],
                              ),
                            ),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: InkWell(
                                onTap: () {
                                  Get.to(AboutSettings(
                                    image: provider.userprofileData.profileImage!,
                                    name: provider.userprofileData.firstName! + provider.userprofileData.lastName!,
                                    userprofileData: provider.userprofileData,
                                  ));
                                },
                                child: Container(
                                  height: 35,
                                  width: 35,
                                  decoration: BoxDecoration(color: Color(0xffF3F3F6), borderRadius: BorderRadius.circular(8)),
                                  child: Icon(
                                    FontAwesomeIcons.angleRight,
                                    size: 15,
                                  ),
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 40,
                        ),
                        Text(
                          "Settings",
                          style: GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(
                          height: 20,
                        ),

                        /*...................language............*/
                        SettingsWidget(
                          image: 'assets/svg/lang.svg',
                          name: "Language",
                          subname: "English",
                          goingScreen: () {},
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SettingsWidget(
                          image: 'assets/svg/notifications.svg',
                          name: "notifications",
                          subname: "",
                          goingScreen: () {
                            Get.to(NotificationSettings());
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 19,
                              backgroundColor: Color(0xffE1F6FE),
                              child: Center(
                                  child: SvgPicture.asset(
                                "assets/svg/darkmode.svg",
                                height: 15,
                                color: Colors.blue,
                              )),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Text("Dark Mode", style: GoogleFonts.lato(fontSize: 16)),
                            Spacer(),
                            Consumer<SettingsProvider>(builder: (context, settingsProvider, child) {
                              return CupertinoSwitch(
                                value: settingsProvider.darkModeOff,
                                onChanged: (value) {
                                  settingsProvider.changeDarkModestatus(value);
                                },
                              );
                            }),
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SettingsWidget(
                          image: 'assets/svg/help.svg',
                          name: "Help",
                          subname: "",
                          goingScreen: () {
                            Get.to(HelpDesk());
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        SettingsWidget(
                          image: 'assets/svg/other.svg',
                          name: "Other",
                          subname: "",
                          goingScreen: () {
                            Get.to(OtherSettings());
                          },
                        ),
                      ],
                    );
            }),
          ),
        ),
      ),
    );
  }
}
