import 'package:als_frontend/provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OtherUserProfileScreen extends StatefulWidget {
  const OtherUserProfileScreen({Key? key}) : super(key: key);

  @override
  State<OtherUserProfileScreen> createState() => _OtherUserProfileScreenState();
}

class _OtherUserProfileScreenState extends State<OtherUserProfileScreen> {
  @override
  void initState() {
    final value =
        Provider.of<PublicProfileDetailsProvider>(context, listen: false);
    value.getUserData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<PublicProfileDetailsProvider>(
          builder: (context, provider, child) {
        return Center(
            child: ElevatedButton(
          child: const Text("data"),
          onPressed: () {
          },
        ));
      }),
    );
  }
}
