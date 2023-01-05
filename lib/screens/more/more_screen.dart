import 'package:als_frontend/provider/auth_provider.dart';
import 'package:als_frontend/provider/dashboard_provider.dart';
import 'package:als_frontend/provider/notication_provider.dart';
import 'package:als_frontend/provider/splash_provider.dart';
import 'package:als_frontend/screens/animal/my_animal_screen.dart';
import 'package:als_frontend/screens/auth/login_screen.dart';
import 'package:als_frontend/screens/group/liked_group_suggested_group.dart';
import 'package:als_frontend/screens/page/liked_page_suggested_page.dart';
import 'package:als_frontend/screens/profile/profile_screen.dart';
import 'package:als_frontend/screens/settings/widget/Settings_widget.dart';
import 'package:als_frontend/translations/locale_keys.g.dart';
import 'package:als_frontend/util/helper.dart';
import 'package:als_frontend/util/palette.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:als_frontend/widgets/network_image.dart';
import 'package:als_frontend/widgets/snackbar_message.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
      backgroundColor: Palette.scaffold,
      body: Consumer<AuthProvider>(
        builder: (context, authProvider, child) {
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(left: 15, right: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: h * 0.01),
                  Center(child: circularImage(authProvider.profileImage, 130, 130)),
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
                              Helper.toScreen(const ProfileScreen());
                            } else {
                              showMessage(context: context, message: 'Please Update apps first');
                            }
                          },
                          child: Text(LocaleKeys.view_profile.tr(), style: button)),
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
                      Helper.toScreen(const LikedGroupSuggestedGroup());
                    },
                  ),

                  SettingsWidget(
                    image: 'assets/menu/page.svg',
                    name: "Page",
                    subName: "",
                    isShowIconsColor: false,
                    goingScreen: () {
                      Helper.toScreen(const LikedPageSuggestedPage());
                    },
                  ),

                  SettingsWidget(
                    image: 'assets/menu/animal.svg',
                    name: "Animal",
                    subName: "",
                    isShowIconsColor: false,
                    goingScreen: () {
                      Provider.of<AuthProvider>(context, listen: false).getUserInfo();
                      Helper.toScreen(const MyAnimalScreen());
                    },
                  ),

                  SettingsWidget(
                    image: 'assets/menu/settings.svg',
                    name: "Settings",
                    subName: "",
                    isShowIconsColor: false,
                    goingScreen: () {
                      Helper.toScreen(const SettingsScreen());
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

                              Navigator.of(context).pushAndRemoveUntil(
                                  MaterialPageRoute(
                                    builder: (_) => const LoginScreen(),
                                  ),
                                  (route) => false);
                            }
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(FontAwesomeIcons.arrowRightFromBracket),
                            Text(LocaleKeys.logout.tr(), style: GoogleFonts.lato(fontSize: h * 0.03)),
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
