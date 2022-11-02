import 'dart:io';

import 'package:als_frontend/old_code/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

import 'no_internet_screen.dart';

class UpdateScreen extends StatefulWidget {
  const UpdateScreen({Key? key}) : super(key: key);

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  bool connection = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("A new version has arrived. Please update you app."),
          ElevatedButton(
                  onPressed: () {
                    const appId = 'com.als.feedback';
                    final url = Uri.parse(
                        "https://play.google.com/store/apps/details?id=$appId");
                    launchUrl(
                      url,
                      mode: LaunchMode.externalApplication,
                    );
                  },
                  child: const Text("Update")
              ),
        ],
      )
        
      
    ));
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
      Future.delayed(const Duration(milliseconds: 100), () {
        Get.to(()=> const NavScreen());
        });
      
    } else {
      Get.to(const NoInternetScreen());
    }
  }
}