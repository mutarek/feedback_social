import 'dart:io';

import 'package:als_frontend/provider/provider.dart';
import 'package:als_frontend/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

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
    return const Scaffold(
      body: Center(
        child: SizedBox(
          height: 100,
          width: 100,
          child: CircleAvatar(
            backgroundImage: AssetImage("assets/logo/logo.jpeg"),
            radius: 60,
            backgroundColor: Colors.transparent,
          ),
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
      Future.delayed(const Duration(seconds: 1), () {
        DatabaseProvider().getToken().then((value) {
          if (value == '') {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginScreen()),
                (route) => false);
          } else {
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const GetTokenScreen()),
                (route) => false);
          }
        });
      });
    } else {
      Get.to(const NoInternetScreen());
    }
  }
}
