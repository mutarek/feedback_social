import 'package:als_frontend/provider/settings_provider.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class OtherSettings extends StatefulWidget {
  const OtherSettings({Key? key}) : super(key: key);

  @override
  State<OtherSettings> createState() => _OtherSettingsState();
}

class _OtherSettingsState extends State<OtherSettings> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<SettingsProvider>(context, listen: false).initializeOtherSettingsValue();
  }

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    final double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: const Color(0xffFFFFFF),
      appBar: AppBar(
        elevation: 0.3,
        backgroundColor: const Color(0xffFFFFFF),
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: const Icon(FontAwesomeIcons.angleLeft, size: 20, color: Colors.black)),
        title: Text("Other", style: GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.w800, color: Colors.black)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: SingleChildScrollView(
            child: Consumer<SettingsProvider>(builder: (context, settingsProvider, child) {
              return settingsProvider.isLoading
                  ? SizedBox(width: width, height: height, child: const Center(child: CircularProgressIndicator()))
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 30),
                        Material(
                          elevation: 8,
                          shadowColor: const Color(0xff69D2FA),
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            width: width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: const LinearGradient(
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.topRight,
                                  colors: [
                                    Color(0xff2D87EB),
                                    Color(0xff69D2FA),
                                  ],
                                )),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 30, right: 30),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Who can tag you ?",
                                    style: latoStyle500Medium.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "*  anyone",
                                        style: latoStyle400Regular.copyWith(
                                          color: Colors.white,
                                        ),
                                      ),
                                      const Spacer(),
                                      CupertinoSwitch(
                                        trackColor: const Color(0xff69D2FA), // **INACTIVE STATE COLOR**
                                        activeColor: const Color(0xff2D87EB),
                                        value: settingsProvider.otherSettingsValue!.isAnyoneTag!,
                                        onChanged: (value) {
                                          settingsProvider.changeOtherSettingsStatus(value, 0);
                                        },
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "* Your follower",
                                        style: latoStyle400Regular.copyWith(
                                          color: Colors.white,
                                        ),
                                      ),
                                      const Spacer(),
                                      CupertinoSwitch(
                                        trackColor: const Color(0xff69D2FA), // **INACTIVE STATE COLOR**
                                        activeColor: const Color(0xff2D87EB),
                                        value: settingsProvider.otherSettingsValue!.isFollowerTag!,
                                        onChanged: (value) {
                                          settingsProvider.changeOtherSettingsStatus(value, 1);

                                        },
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "* Your following",
                                        style: latoStyle400Regular.copyWith(
                                          color: Colors.white,
                                        ),
                                      ),
                                      const Spacer(),
                                      CupertinoSwitch(
                                        trackColor: const Color(0xff69D2FA), // **INACTIVE STATE COLOR**
                                        activeColor: const Color(0xff2D87EB),
                                        value: settingsProvider.otherSettingsValue!.isFollowingTag!,
                                        onChanged: (value) {
                                          settingsProvider.changeOtherSettingsStatus(value, 2);

                                        },
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Material(
                          elevation: 8,
                          shadowColor: const Color(0xff69D2FA),
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            width: width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: const LinearGradient(
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.topRight,
                                  colors: [
                                    Color(0xff57C84D),
                                    Color(0xffC5E8B7),
                                  ],
                                )),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 30, right: 30),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Who can share Your post ?",
                                    style: latoStyle500Medium.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "* Anyone",
                                        style: latoStyle400Regular.copyWith(
                                          color: Colors.white,
                                        ),
                                      ),
                                      const Spacer(),
                                      CupertinoSwitch(
                                        trackColor: const Color(0xffC5E8B7), // **INACTIVE STATE COLOR**
                                        activeColor: const Color(0xff57C84D),
                                        value: settingsProvider.otherSettingsValue!.isAnyoneShare!,
                                        onChanged: (value) {},
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "* Your follower",
                                        style: latoStyle400Regular.copyWith(
                                          color: Colors.white,
                                        ),
                                      ),
                                      const Spacer(),
                                      CupertinoSwitch(
                                        trackColor: const Color(0xffC5E8B7), // **INACTIVE STATE COLOR**
                                        activeColor: const Color(0xff57C84D),
                                        value: settingsProvider.otherSettingsValue!.isFollowerShare!,
                                        onChanged: (value) {},
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "* Your following",
                                        style: latoStyle400Regular.copyWith(
                                          color: Colors.white,
                                        ),
                                      ),
                                      const Spacer(),
                                      CupertinoSwitch(
                                        trackColor: const Color(0xffC5E8B7), // **INACTIVE STATE COLOR**
                                        activeColor: const Color(0xff57C84D),
                                        value: settingsProvider.otherSettingsValue!.isFollowingShare!,
                                        onChanged: (value) {},
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Material(
                          elevation: 8,
                          shadowColor: const Color(0xff69D2FA),
                          borderRadius: BorderRadius.circular(20),
                          child: Container(
                            width: width,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                gradient: const LinearGradient(
                                  begin: Alignment.bottomLeft,
                                  end: Alignment.topRight,
                                  colors: [
                                    Color(0xffED30CD),
                                    Color(0xffFA86F2),
                                  ],
                                )),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 30, right: 30),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "Who can direct massage you ?",
                                    style: latoStyle500Medium.copyWith(color: Colors.white, fontWeight: FontWeight.bold),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "* Anyone",
                                        style: latoStyle400Regular.copyWith(
                                          color: Colors.white,
                                        ),
                                      ),
                                      const Spacer(),
                                      CupertinoSwitch(
                                        trackColor: const Color(0xffFA86F2), // **INACTIVE STATE COLOR**
                                        activeColor: const Color(0xffED30CD),
                                        value: settingsProvider.otherSettingsValue!.isAnyoneMessage!,
                                        onChanged: (value) {},
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "* Your follower",
                                        style: latoStyle400Regular.copyWith(
                                          color: Colors.white,
                                        ),
                                      ),
                                      const Spacer(),
                                      CupertinoSwitch(
                                        trackColor: const Color(0xffFA86F2), // **INACTIVE STATE COLOR**
                                        activeColor: const Color(0xffED30CD),
                                        value: settingsProvider.otherSettingsValue!.isFollowerMessage!,
                                        onChanged: (value) {},
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "* Your following",
                                        style: latoStyle400Regular.copyWith(
                                          color: Colors.white,
                                        ),
                                      ),
                                      const Spacer(),
                                      CupertinoSwitch(
                                        trackColor: const Color(0xffFA86F2), // **INACTIVE STATE COLOR**
                                        activeColor: const Color(0xffED30CD),
                                        value: settingsProvider.otherSettingsValue!.isFollowingMessage!,
                                        onChanged: (value) {},
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  )
                                ],
                              ),
                            ),
                          ),
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
