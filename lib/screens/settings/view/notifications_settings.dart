import 'package:als_frontend/provider/settings_provider.dart';
import 'package:als_frontend/screens/settings/widget/notification_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class NotificationSettings extends StatefulWidget {
  const NotificationSettings({Key? key}) : super(key: key);

  @override
  State<NotificationSettings> createState() => _NotificationSettingsState();
}

class _NotificationSettingsState extends State<NotificationSettings> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Provider.of<SettingsProvider>(context, listen: false).initializeNotificationSettingsValue();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: const Color(0xffFFFFFF),
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: const Icon(FontAwesomeIcons.angleLeft, size: 20, color: Colors.black)),
        title: Text("Notifications", style: GoogleFonts.lato(fontSize: 20, fontWeight: FontWeight.w800, color: Colors.black)),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30),
          child: SingleChildScrollView(
            child: Consumer<SettingsProvider>(

              builder: (context,settingsProvider,child) {
                return settingsProvider.isLoading?const Center(child: CupertinoActivityIndicator()):Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 10),
                    NotificationWidget(buttunName: "Push notification", buttunValue: settingsProvider.notificationModel!.isPush!,
                        onChanged: (value) {
                          settingsProvider.changeNotificationSettingsStatus(value!, 0);
                        }),
                    const SizedBox(height: 30),
                    NotificationWidget(buttunName: "Friend notification", buttunValue: settingsProvider.notificationModel!.isFriend!, onChanged: (value) {
                      settingsProvider.changeNotificationSettingsStatus(value!, 1);
                    }),
                    const SizedBox(height: 30),
                    NotificationWidget(buttunName: "Follower notification", buttunValue: settingsProvider.notificationModel!.isFollower!, onChanged: (value) {
                      settingsProvider.changeNotificationSettingsStatus(value!, 2);
                    }),
                    const SizedBox(height: 30),
                    NotificationWidget(buttunName: "Following notification", buttunValue: settingsProvider.notificationModel!.isFollowing!, onChanged: (value) {
                      settingsProvider.changeNotificationSettingsStatus(value!, 3);
                    }),
                    const SizedBox(height: 30),
                    NotificationWidget(
                        buttunName: ""
                            "like notification",
                        buttunValue: settingsProvider.notificationModel!.isLike!,
                        onChanged: (value) {
                          settingsProvider.changeNotificationSettingsStatus(value!, 4);
                        }),
                    const SizedBox(height: 30),
                    NotificationWidget(buttunName: "Comment notification", buttunValue: settingsProvider.notificationModel!.isComment!, onChanged: (value) {
                      settingsProvider.changeNotificationSettingsStatus(value!, 5);
                    }),
                    const SizedBox(height: 30),
                    NotificationWidget(buttunName: "Share notification", buttunValue: settingsProvider.notificationModel!.isShare!, onChanged: (value) {
                      settingsProvider.changeNotificationSettingsStatus(value!, 6);
                    }),
                    const SizedBox(height: 30),
                  ],
                );
              }
            ),
          ),
        ),
      ),
    );
  }
}
