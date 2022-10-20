import 'package:als_frontend/old_code/const/palette.dart';
import 'package:als_frontend/provider/auth_provider.dart';
import 'package:als_frontend/screens/animal/my_animal_screen.dart';
import 'package:als_frontend/screens/auth/login_screen.dart';
import 'package:als_frontend/screens/group/my_group_screen.dart';
import 'package:als_frontend/screens/more/widget/custom_menu_card.dart';
import 'package:als_frontend/screens/profile/profile_screen.dart';
import 'package:als_frontend/screens/profile/send_friend_request_screen.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../settings/view/Settings_screen.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "FeedBack",
          style: TextStyle(color: Palette.primary, fontSize: 28, fontWeight: FontWeight.bold, letterSpacing: -1.2)
        ),
      ),
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          return SizedBox(
            width: w,
            height: h,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                    padding: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(10), boxShadow: [
                      BoxShadow(color: Colors.grey.withOpacity(.1), blurRadius: 20.0, spreadRadius: 3.0, offset: const Offset(0.0, 0.0))
                    ]),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: CircleAvatar(
                                radius: h * 0.05,
                                backgroundColor: Palette.notificationColor,
                                child: CircleAvatar(
                                    radius: h * 0.048,
                                    backgroundColor: Palette.scaffold,
                                    backgroundImage: NetworkImage(authProvider.profileImage))),
                          ),
                          const SizedBox(height: 15),
                          Center(child: Text(authProvider.name, style: latoStyle500Medium)),
                          Center(
                            child: Padding(
                              padding: EdgeInsets.only(top: h * 0.014),
                              child: InkWell(
                                onTap: () {
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
                                    child: Center(child: Text("View profile", style: latoStyle400Regular.copyWith(color: Colors.white)))),
                              ),
                            ),
                          ),
                          //
                          const SizedBox(height: 15),
                          Row(
                            children: [
                              Expanded(
                                child: CustomMenuCard(
                                    h: h,
                                    svgName: "assets/menu/group.svg",
                                    iconColor: Palette.primary,
                                    iconName: "group",
                                    navigetion: () {
                                      Get.to(const MyGroupScreen());
                                    }),
                              ),
                              Expanded(
                                child: CustomMenuCard(
                                    h: h,
                                    svgName: "assets/menu/page.svg",
                                    iconColor: Palette.primary,
                                    iconName: "Page",
                                    navigetion: () {
                                      // Get.to(const CommingSoonScreen());
                                    }),
                              ),
                              Expanded(
                                child: CustomMenuCard(
                                    h: h,
                                    svgName: "assets/menu/friend.svg",
                                    iconColor: Palette.primary,
                                    iconName: "Friends",
                                    navigetion: () {
                                      Get.to(() => const SendFriendRequestScreen());
                                    }),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: CustomMenuCard(
                                    h: h,
                                    svgName: "assets/menu/animal.svg",
                                    iconColor: Palette.primary,
                                    iconName: "Animal",
                                    navigetion: () {
                                      Provider.of<AuthProvider>(context, listen: false).getUserInfo(isFirstTime: false);
                                      Get.to(const MyAnimalScreen());
                                    }),
                              ),
                              Expanded(
                                child: CustomMenuCard(
                                    h: h,
                                    svgName: "assets/menu/settings.svg",
                                    iconColor: Palette.primary,
                                    iconName: "Settings",
                                    navigetion: () {
                                      Get.to(() => const Settings());
                                    }),
                              ),
                              const Expanded(child: SizedBox.shrink()),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: w * 0.04),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: h * 0.03),
                                InkWell(
                                  onTap: () {
                                    // Get.to(() => const TermsAndConditionsScreen());
                                  },
                                  child: Text("Terms & Conditions", style: GoogleFonts.lato(fontSize: h * 0.02)),
                                ),
                                SizedBox(height: h * 0.017),
                                Text("User Agreement", style: GoogleFonts.lato(fontSize: h * 0.02)),
                                SizedBox(
                                  height: h * 0.017,
                                ),
                                InkWell(
                                  onTap: () {
                                    // Get.to(() => const PrivacyPolicyScreen());
                                  },
                                  child: Text("Privacy policy", style: GoogleFonts.lato(fontSize: h * 0.02)),
                                ),
                                SizedBox(height: h * 0.017),
                                Text("Content  policy", style: GoogleFonts.lato(fontSize: h * 0.02)),
                              ],
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding: EdgeInsets.only(top: h * 0.1),
                              child: InkWell(
                                onTap: () {
                                  Provider.of<AuthProvider>(context, listen: false).logout().then((value) {
                                    if (value) {
                                      Navigator.of(context)
                                          .pushAndRemoveUntil(MaterialPageRoute(builder: (_) => const LoginScreen()), (route) => false);
                                    }
                                  });
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(FontAwesomeIcons.arrowRightFromBracket),
                                    Text("    logout", style: GoogleFonts.lato(fontSize: h * 0.03)),
                                  ],
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
