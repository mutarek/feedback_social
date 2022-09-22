import 'package:als_frontend/screens/screens.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
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
    
    Future.delayed(const Duration(seconds: 1), () {
      DatabaseProvider().getToken().then((value) {
        if (value == '') {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (_) => const LoginScreen()),
              (route) => false);
        } else {
          final value =
              Provider.of<NotificationsProvider>(context, listen: false);
          value.getData();
          Get.to(() => NavScreen());
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
      ),
    );
  }
}
