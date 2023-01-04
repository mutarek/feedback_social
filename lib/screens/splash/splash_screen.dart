import 'package:als_frontend/provider/auth_provider.dart';
import 'package:als_frontend/provider/notication_provider.dart';
import 'package:als_frontend/provider/profile_provider.dart';
import 'package:als_frontend/provider/splash_provider.dart';
import 'package:als_frontend/screens/auth/login_screen.dart';
import 'package:als_frontend/screens/dashboard/dashboard_screen.dart';
import 'package:als_frontend/screens/splash/no_internet_screen.dart';
import 'package:als_frontend/util/helper.dart';
import 'package:als_frontend/util/theme/app_colors.dart';
import 'package:als_frontend/util/theme/text.styles.dart';
import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(child: Lottie.asset('assets/animations/splash2.json')),
          BounceInDown(
              child: SizedBox(
                  height: 30,
                  width: 30,
                  child: Image.asset('assets/logo/logo.jpeg'))),
          BounceInDown(
              child: Text(
            "Welcome to",
            style: latoStyle800ExtraBold.copyWith(
                color: AppColors.timeColor, fontSize: 22),
          )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              BounceInDown(
                  duration: const Duration(seconds: 2),
                  child: Text("F",
                      style: latoStyle800ExtraBold.copyWith(
                          color: AppColors.feedback, fontSize: 22))),
              BounceInUp(
                  duration: const Duration(seconds: 2),
                  child: Text("e",
                      style: latoStyle800ExtraBold.copyWith(
                          color: AppColors.feedback, fontSize: 22))),
              BounceInDown(
                  duration: const Duration(seconds: 2),
                  child: Text("e",
                      style: latoStyle800ExtraBold.copyWith(
                          color: AppColors.feedback, fontSize: 22))),
              BounceInUp(
                  duration: const Duration(seconds: 2),
                  child: Text("d",
                      style: latoStyle800ExtraBold.copyWith(
                          color: AppColors.feedback, fontSize: 22))),
              BounceInDown(
                  duration: const Duration(seconds: 2),
                  child: Text("b",
                      style: latoStyle800ExtraBold.copyWith(
                          color: AppColors.feedback, fontSize: 22))),
              BounceInUp(
                  duration: const Duration(seconds: 2),
                  child: Text("a",
                      style: latoStyle800ExtraBold.copyWith(
                          color: AppColors.feedback, fontSize: 22))),
              BounceInDown(
                  duration: const Duration(seconds: 2),
                  child: Text("c",
                      style: latoStyle800ExtraBold.copyWith(
                          color: AppColors.feedback, fontSize: 22))),
              BounceInUp(
                  duration: const Duration(seconds: 2),
                  child: Text("k",
                      style: latoStyle800ExtraBold.copyWith(
                          color: AppColors.feedback, fontSize: 22))),
              const SizedBox(
                width: 10,
              ),
              BounceInRight(
                  duration: const Duration(seconds: 2),
                  child: Text("S",
                      style: latoStyle800ExtraBold.copyWith(
                          color: AppColors.feedback, fontSize: 22))),
              BounceInLeft(
                  duration: const Duration(seconds: 2),
                  child: Text("o",
                      style: latoStyle800ExtraBold.copyWith(
                          color: AppColors.feedback, fontSize: 22))),
              BounceInRight(
                  duration: const Duration(seconds: 2),
                  child: Text("c",
                      style: latoStyle800ExtraBold.copyWith(
                          color: AppColors.feedback, fontSize: 22))),
              BounceInLeft(
                  duration: const Duration(seconds: 2),
                  child: Text("i",
                      style: latoStyle800ExtraBold.copyWith(
                          color: AppColors.feedback, fontSize: 22))),
              BounceInRight(
                  duration: const Duration(seconds: 2),
                  child: Text("a",
                      style: latoStyle800ExtraBold.copyWith(
                          color: AppColors.feedback, fontSize: 22))),
              BounceInLeft(
                  duration: const Duration(seconds: 2),
                  child: Text("l",
                      style: latoStyle800ExtraBold.copyWith(
                          color: AppColors.feedback, fontSize: 22))),
            ],
          ),
        ],
      ),
    );
  }

  void navigate() async {
    bool result = await InternetConnectionChecker().hasConnection;
    if (result == true) {
      // ignore: use_build_context_synchronously
      Provider.of<SplashProvider>(context, listen: false).initializeVersion();
      Future.delayed(const Duration(seconds: 5), () {
        if (Provider.of<AuthProvider>(context, listen: false)
            .getUserToken()
            .isEmpty) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const LoginScreen()),
              (route) => false);
        } else {
          Provider.of<NotificationProvider>(context, listen: false).check();
          Provider.of<AuthProvider>(context, listen: false).getUserInfo();
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const DashboardScreen()),
              (route) => false);
          Provider.of<ProfileProvider>(context, listen: false)
              .initializeUserData();
        }
      });
    } else {
      //Helper.toScreen(const NoInternetScreen());
      Provider.of<SplashProvider>(context, listen: false).initializeVersion();
      Future.delayed(const Duration(seconds: 5), () {
        if (Provider.of<AuthProvider>(context, listen: false)
            .getUserToken()
            .isEmpty) {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const LoginScreen()),
              (route) => false);
        } else {
          Provider.of<NotificationProvider>(context, listen: false).check();
          Provider.of<AuthProvider>(context, listen: false).getUserInfo();
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const DashboardScreen()),
              (route) => false);
          Provider.of<ProfileProvider>(context, listen: false)
              .initializeUserData();
        }
      });
    }
  }
}
