import 'package:als_frontend/localization/language_constrants.dart';
import 'package:als_frontend/provider/splash_provider.dart';
import 'package:als_frontend/screens/page/liked_page_suggested_page.dart';
import 'package:als_frontend/util/palette.dart';
import 'package:als_frontend/provider/auth_provider.dart';
import 'package:als_frontend/provider/dashboard_provider.dart';
import 'package:als_frontend/provider/notication_provider.dart';
import 'package:als_frontend/screens/animal/my_animal_screen.dart';
import 'package:als_frontend/screens/auth/login_screen.dart';
import 'package:als_frontend/screens/group/my_group_screen.dart';
import 'package:als_frontend/screens/profile/profile_screen.dart';
import 'package:als_frontend/screens/settings/widget/Settings_widget.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/snackbar_message.dart';
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
      backgroundColor: Colors.white,
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: h * 0.01),
                  Center(
                    child: Material(
                      color: Colors.white,
                      shadowColor: Colors.white,
                      borderRadius: BorderRadius.circular(65),
                      elevation: 6,
                      child: CircleAvatar(
                          radius: h * 0.086, backgroundColor: Palette.scaffold, backgroundImage: NetworkImage(authProvider.profileImage)),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Center(child: Text(authProvider.name, style: latoStyle800ExtraBold.copyWith(fontSize: 20))),
                  const SizedBox(height: 10),
                  Center(
                    child: SizedBox(
                      height: h * 0.04,
                      width: w * 0.4,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                          ),
                          onPressed: () {
                            if (Provider.of<SplashProvider>(context, listen: false).value == 1) {
                              Get.to(() => const ProfileScreen());
                            } else {
                              showMessage(context: context, message: 'Please Update apps first');
                            }
                          },
                          child: Text(getTranslated('View profile', context), style: button)),
                    ),
                  ),
                  //
                  const SizedBox(height: 15),

                  SettingsWidget(
                    image: 'assets/menu/group.svg',
                    name: "Groups",
                    subName: "",
                    isShowIconsColor: false,
                    goingScreen: () {
                      Get.to(const MyGroupScreen());
                    },
                  ),

                  SettingsWidget(
                    image: 'assets/menu/page.svg',
                    name: "Page",
                    subName: "",
                    isShowIconsColor: false,
                    goingScreen: () {
                      Get.to(const LikedPageSuggestedPage());
                    },
                  ),

                  SettingsWidget(
                    image: 'assets/menu/animal.svg',
                    name: "Animal",
                    subName: "",
                    isShowIconsColor: false,
                    goingScreen: () {
                      Provider.of<AuthProvider>(context, listen: false).getUserInfo();
                      Get.to(const MyAnimalScreen());
                    },
                  ),

                  SettingsWidget(
                    image: 'assets/menu/settings.svg',
                    name: "Settings",
                    subName: "",
                    isShowIconsColor: false,
                    goingScreen: () {
                      Get.to(const SettingsScreen());
                    },
                  ),

                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: h * 0.1),
                      child: InkWell(
                        onTap: () {
                          Provider.of<AuthProvider>(context, listen: false).logout().then((value) {
                            if (value) {
                              Provider.of<DashboardProvider>(context, listen: false).changeSelectIndex(0);
                              Provider.of<NotificationProvider>(context, listen: false).channelDismiss();
                              Navigator.of(context)
                                  .pushAndRemoveUntil(MaterialPageRoute(builder: (_) => const LoginScreen()), (route) => false);
                            }
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(FontAwesomeIcons.arrowRightFromBracket),
                            Text(getTranslated('    logout', context), style: GoogleFonts.lato(fontSize: h * 0.03)),
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
