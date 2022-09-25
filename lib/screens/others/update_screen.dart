import 'package:als_frontend/provider/latest_version/latest_version_provider.dart';
import 'package:als_frontend/screens/others/get_token_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class UpdateScreen extends StatefulWidget {
  const UpdateScreen({Key? key}) : super(key: key);

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
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
}