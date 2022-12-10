import 'dart:io';

import 'package:als_frontend/provider/auth_provider.dart';
import 'package:als_frontend/provider/newsfeed_provider.dart';
import 'package:als_frontend/provider/notication_provider.dart';
import 'package:als_frontend/provider/profile_provider.dart';
import 'package:als_frontend/provider/splash_provider.dart';
import 'package:als_frontend/screens/auth/login_screen.dart';
import 'package:als_frontend/screens/dashboard/dashboard_screen.dart';
import 'package:als_frontend/screens/splash/no_internet_screen.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:lottie/lottie.dart';
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
    Provider.of<NewsFeedProvider>(context, listen: false).initializeAllFeedData(isFirstTime: true);
    Provider.of<ProfileProvider>(context, listen: false).initializeUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column( mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Center(child: Lottie.asset('assets/animations/splash2.json')),
          BounceInDown(child: SizedBox(height: 30, width: 30, child: Image.asset('assets/logo/logo.jpeg'))),

          BounceInDown(child: Text("Welcome to",style: latoStyle800ExtraBold.copyWith(color: AppColors.timeColor,fontSize: 22),)),
          Row(
           mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[

              BounceInDown(child: Text("F",style: latoStyle800ExtraBold.copyWith(color: AppColors.feedback,fontSize: 22)),duration:const Duration(seconds: 2) ),
              BounceInUp(child: Text("e",style: latoStyle800ExtraBold.copyWith(color: AppColors.feedback,fontSize: 22)),duration:const Duration(seconds: 2) ),
              BounceInDown(child: Text("e",style: latoStyle800ExtraBold.copyWith(color: AppColors.feedback,fontSize: 22)),duration:const Duration(seconds: 2) ),
              BounceInUp(child: Text("d",style: latoStyle800ExtraBold.copyWith(color: AppColors.feedback,fontSize: 22)),duration:const Duration(seconds: 2) ),
              BounceInDown(child: Text("b",style: latoStyle800ExtraBold.copyWith(color: AppColors.feedback,fontSize: 22)),duration:const Duration(seconds: 2) ),
              BounceInUp(child: Text("a",style: latoStyle800ExtraBold.copyWith(color: AppColors.feedback,fontSize: 22)),duration:const Duration(seconds: 2) ),
              BounceInDown(child: Text("c",style: latoStyle800ExtraBold.copyWith(color: AppColors.feedback,fontSize: 22)),duration:const Duration(seconds: 2) ),
              BounceInUp(child: Text("k",style: latoStyle800ExtraBold.copyWith(color: AppColors.feedback,fontSize: 22)),duration:const Duration(seconds: 2) ),
              const SizedBox(width: 10,),
              BounceInRight(child: Text("S",style: latoStyle800ExtraBold.copyWith(color: AppColors.feedback,fontSize: 22)),duration:const Duration(seconds: 2) ),
              BounceInLeft(child: Text("o",style: latoStyle800ExtraBold.copyWith(color: AppColors.feedback,fontSize: 22)),duration:const Duration(seconds: 2) ),
              BounceInRight(child: Text("c",style: latoStyle800ExtraBold.copyWith(color: AppColors.feedback,fontSize: 22)),duration:const Duration(seconds: 2) ),
              BounceInLeft(child: Text("i",style: latoStyle800ExtraBold.copyWith(color: AppColors.feedback,fontSize: 22)),duration:const Duration(seconds: 2) ),
              BounceInRight(child: Text("a",style: latoStyle800ExtraBold.copyWith(color: AppColors.feedback,fontSize: 22)),duration:const Duration(seconds: 2) ),
              BounceInLeft(child: Text("l",style: latoStyle800ExtraBold.copyWith(color: AppColors.feedback,fontSize: 22)),duration:const Duration(seconds: 2) ),

            ],
          ),

        ],
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
      Future.delayed(const Duration(seconds: 5), () {
        if (Provider.of<AuthProvider>(context, listen: false).getUserToken().isEmpty) {
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const LoginScreen()), (route) => false);
        } else {
          Provider.of<NotificationProvider>(context, listen: false).check();
          Provider.of<AuthProvider>(context, listen: false).getUserInfo();
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const DashboardScreen()), (route) => false);
        }
      });

      Provider.of<SplashProvider>(context, listen: false).initializeVersion();
    } else {
      Get.to(const NoInternetScreen());
    }
  }
}
