import 'package:als_frontend/old_code/screens/screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../provider/provider.dart';

class GetTokenScreen extends StatefulWidget {
  const GetTokenScreen({Key? key}) : super(key: key);

  @override
  State<GetTokenScreen> createState() => _GetTokenScreenState();
}

class _GetTokenScreenState extends State<GetTokenScreen> {
  @override
  void initState() {
    final version = Provider.of<LatestVersionProvider>(context, listen: false);

    Future.delayed(const Duration(seconds: 1), () {
      DatabaseProvider().getToken().then((value) {
        if (value == '') {
          Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const LoginScreen()), (route) => false);
        } else {
          final value = Provider.of<NotificationsProvider>(context, listen: false);
          value.getData();
          // Get.to(() => const NavScreen());
          Get.off(const NavScreen());
          // version.chekVersion();
        }
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        body: Center(
      child: CupertinoActivityIndicator(),
    ));
  }
}
