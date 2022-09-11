

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../screens.dart';

class NoInternetScreen extends StatefulWidget {
  const NoInternetScreen({Key? key}) : super(key: key);

  @override
  State<NoInternetScreen> createState() => _NoInternetScreenState();
}

class _NoInternetScreenState extends State<NoInternetScreen> {
  bool connection = false;
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(top: height * 0.3),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "No internet Connection",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
              const Text(
                "Check your internet connection, then refresh the page",
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
              ),
              ElevatedButton(
                  onPressed: () {
                    Get.to(const SplashScreen());
                  },
                  child: const Text("Refresh")),
            ],
          ),
        ),
      ),
    );
  }
}
