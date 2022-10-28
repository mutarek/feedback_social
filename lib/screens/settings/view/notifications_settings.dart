import 'package:als_frontend/screens/settings/widget/notification_widget.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class NotificationSettings extends StatelessWidget {
  const NotificationSettings({Key? key}) : super(key: key);

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
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(height: 10),
                NotificationWidget(buttunName: "Push notification", buttunValue: true, onChanged: (value) {}),
                const SizedBox(height: 30),
                NotificationWidget(buttunName: "Friend notification", buttunValue: true, onChanged: (value) {}),
                const SizedBox(height: 30),
                NotificationWidget(buttunName: "Follower notification", buttunValue: true, onChanged: (value) {}),
                const SizedBox(height: 30),
                NotificationWidget(buttunName: "Following notification", buttunValue: true, onChanged: (value) {}),
                const SizedBox(height: 30),
                NotificationWidget(
                    buttunName: ""
                        "like notification",
                    buttunValue: true,
                    onChanged: (value) {}),
                const SizedBox(height: 30),
                NotificationWidget(buttunName: "Comment notification", buttunValue: true, onChanged: (value) {}),
                const SizedBox(height: 30),
                NotificationWidget(buttunName: "Share notification", buttunValue: true, onChanged: (value) {}),
                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
