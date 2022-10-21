import 'package:als_frontend/old_code/const/palette.dart';
import 'package:als_frontend/old_code/screens/screens.dart';
import 'package:als_frontend/old_code/screens/settings/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../../provider/provider.dart';
import '../../widgets/widgets.dart';

class Menu extends StatefulWidget {
  const Menu({Key? key}) : super(key: key);

  @override
  State<Menu> createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  final bool togglevalue = false;

  @override
  void initState() {
    final value = Provider.of<ProfileDetailsProvider>(context, listen: false);
    value.getUserData();
    final notification = Provider.of<OldNotificationsProvider>(context, listen: false);
    notification.getData();
    notification.check();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async {
        final value = await showDialog<bool>(
            context: context,
            builder: (context) {
              return const NavScreen();
            });

        return value == true;
      },
      child: Scaffold(
          backgroundColor: Palette.scaffold,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            elevation: 0,
            title: const Text(
              "FeedBack",
              style: TextStyle(color: Palette.primary, fontSize: 28, fontWeight: FontWeight.bold, letterSpacing: -1.2),
            ),
          ),
          body: SafeArea(
            child: Consumer<ProfileDetailsProvider>(builder: (context, provider, child) {
              return SingleChildScrollView(
                  child: Container(
                height: h,
                width: w,
                color: Palette.scaffold,
                child: Stack(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: w * 0.43),
                      child: Text(
                        "Menu",
                        style: GoogleFonts.lato(fontSize: h * 0.03, fontWeight: FontWeight.w700),
                      ),
                    ),
                    Positioned(
                      top: h * 0.1,
                      right: w * 0.04,
                      child: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Container(
                          height: h * 0.64,
                          width: w * 0.9,
                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Center(
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      top: h * 0.05,
                                    ),
                                    child: Text(
                                      "${provider.userprofileData.firstName} ${provider.userprofileData.lastName}",
                                      style: GoogleFonts.lato(fontSize: h * 0.025, fontWeight: FontWeight.w500),
                                    ),
                                  ),
                                ),
                                Consumer2<UserProfileProvider, UserNewsfeedPostProvider>(
                                    builder: (context, provider, userNewsfeedProvider, child) {
                                  return Center(
                                    child: Padding(
                                      padding: EdgeInsets.only(
                                        top: h * 0.014,
                                      ),
                                      child: InkWell(
                                        onTap: () {
                                          userNewsfeedProvider.id = provider.userprofileData.id!;
                                          Get.to(() => const ProfileScreen());
                                        },
                                        child: Container(
                                            height: h * 0.037,
                                            width: w * 0.4,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(5),
                                              gradient: const LinearGradient(
                                                begin: Alignment.topRight,
                                                end: Alignment.bottomLeft,
                                                stops: [
                                                  0.1,
                                                  0.7,
                                                ],
                                                colors: [
                                                  Palette.primary,
                                                  Palette.notificationColor,
                                                ],
                                              ),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Palette.primary.withOpacity(0.4),
                                                  spreadRadius: 2,
                                                  blurRadius: 3,
                                                  offset: const Offset(0, 2), // changes position of shadow
                                                ),
                                              ],
                                            ),
                                            child: Center(
                                                child: Text("View profile",
                                                    style: GoogleFonts.lato(fontWeight: FontWeight.w400, color: Colors.white)))),
                                      ),
                                    ),
                                  );
                                }),
                                SizedBox(
                                  width: h * 0.02,
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: w * 0.01,
                                    ),
                                    CustomMenuCard(
                                        h: h,
                                        svgName: "assets/menu/group.svg",
                                        iconColor: Palette.primary,
                                        iconName: "group",
                                        navigetion: () {
                                          Get.to(const CommingSoonScreen());
                                        }),
                                    CustomMenuCard(
                                        h: h,
                                        svgName: "assets/menu/page.svg",
                                        iconColor: Palette.primary,
                                        iconName: "Page",
                                        navigetion: () {
                                          Get.to(const CommingSoonScreen());
                                        }),
                                    CustomMenuCard(
                                        h: h,
                                        svgName: "assets/menu/friend.svg",
                                        iconColor: Palette.primary,
                                        iconName: "Friends",
                                        navigetion: () {
                                          Get.to(() => const FriendListScreen());
                                        })
                                  ],
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: w * 0.01,
                                    ),
                                    CustomMenuCard(
                                        h: h,
                                        svgName: "assets/menu/animal.svg",
                                        iconColor: Palette.primary,
                                        iconName: "Animal",
                                        navigetion: () {
                                          Get.to(const YourAnimalScreen());
                                        }),
                                    CustomMenuCard(
                                        h: h,
                                        svgName: "assets/menu/settings.svg",
                                        iconColor: Palette.primary,
                                        iconName: "Settings",
                                        navigetion: () {
                                          Get.to(() => const Settings());
                                        }),
                                  ],
                                ),
                                Padding(
                                  padding: EdgeInsets.only(left: w * 0.04),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        height: h * 0.03,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Get.to(() => const TermsAndConditionsScreen());
                                        },
                                        child: Text("Terms & Conditions",
                                            style: GoogleFonts.lato(
                                              fontSize: h * 0.02,
                                            )),
                                      ),
                                      SizedBox(
                                        height: h * 0.017,
                                      ),
                                      Text("User Agreement",
                                          style: GoogleFonts.lato(
                                            fontSize: h * 0.02,
                                          )),
                                      SizedBox(
                                        height: h * 0.017,
                                      ),
                                      InkWell(
                                        onTap: () {
                                          Get.to(() => const PrivacyPolicyScreen());
                                        },
                                        child: Text("Privacy policy",
                                            style: GoogleFonts.lato(
                                              fontSize: h * 0.02,
                                            )),
                                      ),
                                      SizedBox(
                                        height: h * 0.017,
                                      ),
                                      Text("Content  policy",
                                          style: GoogleFonts.lato(
                                            fontSize: h * 0.02,
                                          )),
                                    ],
                                  ),
                                ),
                                Center(
                                  child: Padding(
                                    padding: EdgeInsets.only(top: h * 0.1),
                                    child: InkWell(
                                      onTap: () => DatabaseProvider().logout(context),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          const Icon(FontAwesomeIcons.arrowRightFromBracket),
                                          Text("    logout",
                                              style: GoogleFonts.lato(
                                                fontSize: h * 0.03,
                                              )),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: h * 0.05,
                      left: w * 0.42,
                      child: CircleAvatar(
                        radius: h * 0.05,
                        backgroundColor: Palette.notificationColor,
                        child: CircleAvatar(
                            radius: h * 0.048,
                            backgroundColor: Palette.scaffold,
                            backgroundImage: NetworkImage("${provider.userprofileData.profileImage}")),
                      ),
                    )
                  ],
                ),
              ));
            }),
          )),
    );
  }
}
