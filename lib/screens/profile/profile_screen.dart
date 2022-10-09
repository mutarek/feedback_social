import 'package:als_frontend/provider/auth_provider.dart';
import 'package:als_frontend/screens/auth/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: TextButton(
      onPressed: () {
        Provider.of<AuthProvider>(context, listen: false).logout().then((value) {
          if (value) {
            Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => LoginScreen()), (route) => false);
          }
        });
      },
      child: Text('Logout'),
    ));
  }
}
