import 'package:als_frontend/old_code/const/palette.dart';
import 'package:als_frontend/provider/auth_provider.dart';
import 'package:als_frontend/screens/animal/my_animal_screen.dart';
import 'package:als_frontend/screens/auth/login_screen.dart';
import 'package:als_frontend/screens/group/my_group_screen.dart';
import 'package:als_frontend/screens/more/view/terms_and_condition.dart';
import 'package:als_frontend/screens/more/widget/custom_menu_card.dart';
import 'package:als_frontend/screens/profile/profile_screen.dart';
import 'package:als_frontend/screens/profile/send_friend_request_screen.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../settings/settings_screen.dart';


class MoreScreen extends StatelessWidget {
  const MoreScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double h = MediaQuery.of(context).size.height;
    final double w = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: AppColors.scaffold,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 1,
        title: const Text(
          "FeedBack",
          style: TextStyle(color: Palette.primary, fontSize: 28, fontWeight: FontWeight.bold, letterSpacing: -1.2)
        ),
      ),
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 15,right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: h*0.01,),
                  Center(
                    child: Material(
                      color: Colors.white,
                      shadowColor: Colors.white,
                      borderRadius: BorderRadius.circular(65),
                      elevation: 6,
                      child: CircleAvatar(
                          radius: h * 0.086,
                          backgroundColor: Palette.scaffold,
                          backgroundImage: NetworkImage(authProvider.profileImage)),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(child: Text(authProvider.name, style: latoStyle800ExtraBold.copyWith(fontSize: 20))),
                  const SizedBox(height: 10),
                  Center(
                    child: SizedBox(
                      height: h*0.04,
                      width: w*0.4,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),),
                          onPressed: (){
                        Get.to(() => const ProfileScreen());},
                          child: Text("View profile",style: button)),
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
                              Get.to(() => const SettingsScreen());
                            }),
                      ),
                      Expanded(
                        child: CustomMenuCard(
                            h: h,
                            svgName: "assets/svg/tarmscondition.svg",
                            iconColor: Palette.primary,
                            iconName: "Terms & Conditions",
                            navigetion: () {
                              Get.to(() => const SettingsScreen());
                            }),
                      ),

                      const Expanded(child: SizedBox.shrink()),
                    ],
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
          );
        },
      ),
    );
  }
}
