import 'package:als_frontend/provider/auth_provider.dart';
import 'package:als_frontend/provider/settings_provider.dart';
import 'package:als_frontend/screens/more/view/terms_and_condition.dart';
import 'package:als_frontend/screens/settings/language_screen.dart';
import 'package:als_frontend/screens/settings/view/about_settings.dart';
import 'package:als_frontend/screens/settings/view/help_desk.dart';
import 'package:als_frontend/screens/settings/view/notifications_settings.dart';
import 'package:als_frontend/screens/settings/view/other_settings.dart';
import 'package:als_frontend/translations/locale_keys.g.dart';
import 'package:als_frontend/util/app_constant.dart';
import 'package:als_frontend/util/helper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'widget/Settings_widget.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xffFFFFFF),
        leading: InkWell(
            onTap: () {
              Helper.back();
            },
            child: const Icon(FontAwesomeIcons.angleLeft, size: 20, color: Colors.black)),
        title: Text(
          LocaleKeys.settings.tr(),
          style: GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.w800, color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 30, right: 30),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Consumer<AuthProvider>(builder: (context, provider, child) {
              return provider.isLoading
                  ? const Center(child: CupertinoActivityIndicator())
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Accounts",
                          style: GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.w400),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              radius: 38,
                              backgroundColor: Colors.blue,
                              child: CircleAvatar(
                                radius: 35,
                                backgroundImage: CachedNetworkImageProvider(
                                  provider.profileImage,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            Padding(
                              padding: const EdgeInsets.only(top: 9),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(provider.name, style: GoogleFonts.lato(fontSize: 16)),
                                  const SizedBox(height: 2),
                                  Text(LocaleKeys.personal_Information.tr(), style: GoogleFonts.lato(color: const Color(0xff9C9EA2)))
                                ],
                              ),
                            ),
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: InkWell(
                                onTap: () {
                                  Helper.toScreen(const AboutSettings());
                                },
                                child: Container(
                                  height: 35,
                                  width: 35,
                                  decoration: BoxDecoration(color: const Color(0xffF3F3F6), borderRadius: BorderRadius.circular(8)),
                                  child: const Icon(FontAwesomeIcons.angleRight, size: 15),
                                ),
                              ),
                            )
                          ],
                        ),
                        const SizedBox(height: 20),
                        Text(LocaleKeys.others.tr(), style: GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.w400)),
                        const SizedBox(height: 20),

                        /*...................language............*/
                        SettingsWidget(
                            image: 'assets/svg/lang.svg',
                            name: "Language",
                            subName: AppConstant.languagesList[0].languageName,
                            goingScreen: () {
                             Helper
                             .toScreen(const LanguageScreen());
                            }),
                        const SizedBox(height: 20),
                        SettingsWidget(
                          image: 'assets/svg/notifications.svg',
                          name: LocaleKeys.notifications.tr(),
                          subName: "",
                          goingScreen: () {
                            Helper.toScreen(const NotificationSettings());
                          },
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 19,
                              backgroundColor: const Color(0xffE1F6FE),
                              child: Center(
                                  child: SvgPicture.asset(
                                "assets/svg/darkmode.svg",
                                height: 15,
                                color: Colors.blue,
                              )),
                            ),
                            const SizedBox(width: 10),
                            Text(LocaleKeys.dark_Mode.tr(), style: GoogleFonts.lato(fontSize: 16)),
                            const Spacer(),
                            Consumer<SettingsProvider>(builder: (context, settingsProvider, child) {
                              return CupertinoSwitch(
                                value: settingsProvider.darkModeOff,
                                onChanged: (value) {
                                  settingsProvider.changeDarkModeStatus(value);
                                },
                              );
                            }),
                          ],
                        ),
                        const SizedBox(height: 20),
                        SettingsWidget(
                          image: 'assets/svg/help.svg',
                          name: LocaleKeys.help.tr(),
                          subName: "",
                          goingScreen: () {
                            Helper.toScreen(const HelpDesk());
                          },
                        ),
                        const SizedBox(height: 20),
                        SettingsWidget(
                          image: 'assets/svg/other.svg',
                          name: LocaleKeys.others.tr(),
                          subName: "",
                          goingScreen: () {
                            Helper.toScreen(const OtherSettings());
                          },
                        ),
                        const SizedBox(height: 20),
                        SettingsWidget(
                          image: 'assets/svg/tarmscondition.svg',
                          name: LocaleKeys.terms_and_Conditions.tr(),
                          subName: "",
                          goingScreen: () {
                            Helper.toScreen(const TermsAndConditionsScreen());
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
