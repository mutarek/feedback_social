import 'package:als_frontend/provider/auth_provider.dart';
import 'package:als_frontend/provider/profile_provider.dart';
import 'package:als_frontend/screens/profile/edit_profile_screen.dart';
import 'package:als_frontend/screens/settings/view/block_list.dart';
import 'package:als_frontend/screens/settings/view/email_update.dart';
import 'package:als_frontend/screens/settings/view/password_update.dart';
import 'package:als_frontend/translations/locale_keys.g.dart';
import 'package:als_frontend/util/helper.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class AboutSettings extends StatefulWidget {
  const AboutSettings({Key? key}) : super(key: key);

  @override
  State<AboutSettings> createState() => _AboutSettingsState();
}

class _AboutSettingsState extends State<AboutSettings> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<ProfileProvider>(context, listen: false).initializeUserData();
  }

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
        title: Text(LocaleKeys.about.tr(),style: GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.w800, color: Colors.black)),
      ),
      body: Consumer2<ProfileProvider, AuthProvider>(
        builder: (context, profileProvider, authProvider, child) => SafeArea(
          child: profileProvider.isProfileLoading
              ? const Center(child: CircularProgressIndicator())
              : Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 10),
                        Center(
                          child: CircleAvatar(
                            radius: 62,
                            backgroundColor: Colors.green,
                            child: CircleAvatar(
                              radius: 60,
                              backgroundImage: CachedNetworkImageProvider(authProvider.profileImage)
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Center(child: Text(authProvider.name, style: GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.w800))),
                        const SizedBox(height: 30),
                        Row(
                          children: [
                            const CircleAvatar(
                              radius: 25,
                              backgroundColor: Color(0xffd7f2d3),
                              child: Center(child: Icon(FontAwesomeIcons.person, color: Colors.green)),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(LocaleKeys.personal_Information.tr(), style: GoogleFonts.lato(fontSize: 16)),
                                const SizedBox(height: 3),
                                Text(LocaleKeys.name_gender_profile_details.tr(), style: GoogleFonts.lato(color: const Color(0xff9C9EA2))),
                              ],
                            ),
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: InkWell(
                                onTap: () {
                                  Helper.toScreen(EditProfile(userprofileData: profileProvider.userprofileData));
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
                        const SizedBox(height: 30),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundColor: const Color(0xffd7f2d3),
                              child: Center(child: SvgPicture.asset('assets/svg/password.svg', height: 25)),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(LocaleKeys.password_security.tr(), style: GoogleFonts.lato(fontSize: 16)),
                                const SizedBox(height: 3),
                                Text(LocaleKeys.change_password.tr(), style: GoogleFonts.lato(color: const Color(0xff9C9EA2))),
                              ],
                            ),
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: InkWell(
                                onTap: () {
                                  Helper.toScreen(const PasswordUpdateSettings());
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
                        const SizedBox(height: 30),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundColor: const Color(0xfff1d3f2),
                              child: Center(child: SvgPicture.asset('assets/svg/mail.svg', height: 25, color: Colors.pink)),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(LocaleKeys.email_Security.tr(), style: GoogleFonts.lato(fontSize: 16)),
                                const SizedBox(height: 3),
                                Text(LocaleKeys.change_Email.tr(), style: GoogleFonts.lato(color: const Color(0xff9C9EA2))),
                              ],
                            ),
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: InkWell(
                                onTap: () {
                                  Helper.toScreen(EmailUpdateSettings());
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
                        const SizedBox(height: 30),
                        Row(
                          children: [
                            const CircleAvatar(
                              radius: 25,
                              backgroundColor: Color(0xfff1d3f2),
                              child: Center(child: Icon(FontAwesomeIcons.ban, color: Colors.pinkAccent)),
                            ),
                            const SizedBox(width: 10),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(LocaleKeys.block_list.tr(), style: GoogleFonts.lato(fontSize: 16)),
                                const SizedBox(height: 3),
                                Text(LocaleKeys.see_your_block_list.tr(), style: GoogleFonts.lato(color: const Color(0xff9C9EA2))),
                              ],
                            ),
                            const Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: InkWell(
                                onTap: () {
                                 Helper.toScreen(const BlockListUpdateSettings());
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
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
