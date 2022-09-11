

import 'package:flutter/material.dart';

class CommingSoonScreen extends StatelessWidget {
  const CommingSoonScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Comming Soon",
          style: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            
          ),
        ),
      ),
    );
  }
}
