import 'dart:io';

import 'package:als_frontend/helper/open_call_url_map_sms_helper.dart';
import 'package:als_frontend/old_code/const/palette.dart';
import 'package:als_frontend/old_code/screens/screens.dart';
import 'package:als_frontend/provider/auth_provider.dart';
import 'package:als_frontend/provider/notication_provider.dart';
import 'package:als_frontend/provider/splash_provider.dart';
import 'package:als_frontend/screens/dashboard/dashboard_screen.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  String profileImage = "";
  bool connection = false;

  @override
  void initState() {
    navigate();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Consumer<SplashProvider>(
        builder: (context, splashProvider, child) => Column(
          children: [
            Expanded(child: Center(child: SizedBox(height: 100, width: 100, child: Image.asset('assets/logo/logo.jpeg')))),
            splashProvider.isLoading || splashProvider.isExistsVersion
                ? const SizedBox.shrink()
                : CustomButton(
                    btnTxt: 'You are using an old version Please Update these apps.',
                    onTap: () {
                      openFeedbackAppOnPlayStore();
                    },
                    backgroundColor: AppColors.feedback,
                    textWhiteColor: true,
                    radius: 0,
                    fontSize: 13,
                  ),
          ],
        ),
      ),
    );
  }

  void navigate() async {
    try {
      final result = await InternetAddress.lookup('www.google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        setState(() {
          connection = true;
        });
      }
    } on SocketException catch (_) {
      setState(() {
        connection = false;
      });
    }
    if (connection == true) {
      Provider.of<SplashProvider>(context, listen: false).initializeVersion().then((value) {
        if (value) {
          Future.delayed(const Duration(seconds: 1), () {
            if (Provider.of<AuthProvider>(context, listen: false).getUserToken().isEmpty) {
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const LoginScreen()), (route) => false);
            } else {
              Provider.of<NotificationProvider>(context, listen: false).check();
              Provider.of<AuthProvider>(context, listen: false).getUserInfo();
              Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const DashboardScreen()), (route) => false);
            }
          });
        }
      });
    } else {
      Get.to(const NoInternetScreen());
    }
  }
}
